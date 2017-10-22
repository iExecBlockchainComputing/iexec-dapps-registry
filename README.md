# Cron

Cron for Ethereum - Scheduled smart contract function calls.

## Why Ethereum?

For the time being it's the only viable smart contract platform in town. Plus community!

## Why iExec?

This is an iExec competition right? And I'm short 1 devcon3 ticket :-)

## Description

As Tolstoy famously observed, distributed `cron` would be pretty cool:

> Call out to `cron` and `cron` will call back to you (L. Tolstoy)

Cron for Ethereum provides for scheduled off-chain execution of arbitrary tasks, the output of which can be fed to a given smart contract via a specified function call.   

Cron for Ethereum is essentially a transaction-scheduler, where the calldata parameters can be dynamically determined on every invocation.  

In case you find this uninteresting, have think about recusive cron - tasks that can write tasks.

## Implementation

An Ethereum smart contract `Cron` provides a simple interface for scheduling function calls. Tasks are scheduled by specifying `dst`; a contract address, `sig`; the function signature to be called and `code`; the script which should be executed in order to provide arguments for `sig`.

`code` is an IPFS hash for the location of an execution manifest containing the `code` which is to be run, along with a proof that the `msg.sender` is authorized to access.   

```js
// Pseudocode -----------------------------------------------------------------
contract Cron is DSAuth, DSNote, IexecOracleAPI {
  uint public constant DAPP_PRICE = 0;

  struct Task {
      address src;  // msg.sender
      address dst;  // target contract
      bytes32 sig;  // function signature
      string code;  // ipfs hash
      uint rpt;     // block interval
  }

  Task[] public tasks;

  function Cron (address _iexec) IexecOracleAPI(_iexec, DAPP_PRICE) {
      owner = msg.sender;
  }

  function schedule(
      address dst_,
      string  sig_,
      string  code_,
      uint    rpt_
  ) public note returns (uint) {
      Task storage t = Task({src: msg.sender, dst: dst_, code: code_, rpt: rpt_});
      tasks.push(t);
      iexecSubmit("cron", t);
      return tasks.length-1;
  }
}
```

The frequency at which tasks should be run is specified by the integer `rpt` - the number of blocks after which a job should repeat. 0 indicates that the job should run once and never repeat, 1 indicates that the job should be submitted on every block, 100 at every 100 blocks and so forth.

#### Example - schedule a task

Regularly update a value on the blockchain. Consider the following:

```js
contract Cache {
  function write(uint value_) auth {
    value = value_;
  }
}
```

We can schedule a write to the deployed `Cache` every 10 blocks using Cron `schedule`:

```js
schedule(
  '0011111111111111111111111111111111111111',       // dst
  'write(uint value)',                              // sig
  'QmcNsPV7QZFHKb2DNn8GWsU5dtd8zH5DNRa31geC63ceb4', // code
  10                                                // rpt
)
```

This will trigger the iExec app to fetch and verify and the `code` at the given IPFS hash and run it every 10 blocks. The script at `code` is expected to return a list to `stdout` which will be passed as arguments when calling `sig` on the target contract.

The script at the IPFS address `code` could be any price of arbitrary code, a simple price feed for example:

```bash
#!/usr/bin/env bash
# Note: Whilst it might not be possible to execute shell scripts via
# XtremWeb-HEP I'm assuming that it would be possible to provide similar
# functionality by some means.

json=$(curl -sS "https://api.coinbase.com/v2/prices/ETH-USD/spot")
price=$(jshon <<<"$json" -e data -e amount -u)
echo $price
```

The iExec Cron app would use the output `$price` as the argument when periodically calling the specified function: `write(uint value)` - it would send a transaction every 10 blocks containing:

```js
// Pseudocode -----------------------------------------------------------------
{
  "from": "accounts[0]", // Cron account owner
    "to": "$dst",
  "data": "write($price)"
}
```

### Auth

The `Cache` contract in the example is using the `auth` modifier provided by the [DSAuth](https://dapp.tools/dappsys/ds-auth.html) lib. This would allow the contract owner to whitelist Cron to be able to call the specified function `sig` via an `authority`.

It would also be possible to proxy transactions from the iExec Cron app through the deployed Cron contract in order that the deployed contract address could be used for auth white-listing:

```js
function execute(address dst_, bytes32 sig_) auth returns (bool) {
  dst_.call(bytes4(keccak256(sig_)));
}
```

### Kill a scheduled task

Use the task id returned by `schedule`

```js
function unschedule(uint id) public note returns (bool) {
    Task storage t = tasks[id];
    require(t.owner == msg.sender);
    tasks[id] = "";
    // flush iExec task
    // etc.
}
```

## iExec App

The iExec cron app would involve an XtremWeb-HEP task that:

* Waits for the next scheduled block `now + rpt`
* Runs the given `code`
* Either: Calls the given function `src` at `dst`
* Or: error/timeout

On first run, if the outputs from `code` don't match those required by the given function `sig` the task would be disabled.

If the execution time of `code` exceeds a given limit the task would be disabled.

## Assumptions

* Correctness of execution handled by iExec
* Payment handled by iExec
* Malicious code handled by iExec

## Further Work

* execution manifest specification
* data availability
* `code` validation
* finer grained task control (start, stop, update)
* transaction throughput
