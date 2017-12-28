# Time clock
## Description

Badge-in, badge-out, get pay in eth and switch on et twitch off the office alarm with iExec.

![TimeClock](./TimeClock.gif)

## Dapp params
```
module.exports = {
  name: 'TimeClock',
  data: {
    type: 'BINARY',
    cpu: 'AMD64',
    os: 'LINUX',
  },
  work: {
    cmdline: '--activate',
  }
};
```

## [Examples](./examples)

## [Tests](./test/timeclock.js)


```
iexec init timeclock
cd iexec-timeclock
```
make sure the development network host in truffle.js is well configured ('localhost' and not 'http://localhost:8545'):
```
module.exports = {
  networks: {
    development: {
      host: 'localhost',
      port: 8545,
      network_id: '*', // Match any network id,
      constructorArgs: [LOCAL_ORACLE_ADDRESS],
      server: 'https://localhost:443'
    },
```

some tests are specific to testrpc mode (play with evm time) and others are for local geth used.
The isTestRPC variable is used to skip or not test according to the current network used.

### testrpc Tests

Install the latest testrpc
```
npm install -g ethereumjs-testrpc

```
start your testrpc with
```
testrpc
```
You must see somting like this atb the end of the log

```
Listening on localhost:8545
```
Your testrpc network simultaor is ready, you can launch your truffle test with :
```
iexec truffle test
```
Result must looks like :
```

  Contract: TimeClock

aRLCInstance.address is
0x237938b89a9ee2a27bcbaacc0cef58b8e01c7d5d

aIexecOracleEscrowInstance.address is
0xbba8b932da0de4c923e5397e9ffb9ba6d42cd158

aIexecOracleInstance.address is

0x7a65242cf3aefaf37ec3c455eb0c7617f12552d5

aTimeClockInstance.address is

0x0dd78cf78f11d2dc4424c00be294f007494e9eb2

    - Geth mode example : test only launch when geth is used

    ✓ TestRPC mode example : test only launch when testrpc is used

    ✓ Test provider and dapp of TimeClock are set correctly in IexecOracle

    ✓ Test initial employeeAtOffice

    ✓ Test initial alarm state  (50ms)

    ✓ Test badgeIn function by dappUser (455ms)

    Test badgeOut function by dappUser

aTimeClockInstance.address is

0xb42690c16880dad1feaba82dbf00ee950c0d3ab6

refill 5 ether to 0xb42690c16880dad1feaba82dbf00ee950c0d3ab6

dappUserBadgeInTime is :

1514490223

      ✓ Test getEmployeeBadgeInTime not null after badge In

aTimeClockInstance.address is

0xc06819d3de6e06440f670359bb5dbb0a88c1db31

refill 5 ether to 0xc06819d3de6e06440f670359bb5dbb0a88c1db31

      - Test badge-out function call . Geth MODE

aTimeClockInstance.address is

0x939745aba05c4c53e0601418cc3f35f87ecd14de

refill 5 ether to 0x939745aba05c4c53e0601418cc3f35f87ecd14de

DailyPay employee [0x48a686b281b4c5e05176deb0c04ef649ec77f415] received : 15 wei

      ✓ Test badge-out function call . TestRPC MODE (521ms)





  7 passing (3s)

  2 pending
```



### Local geth node Tests

Pull the the following docker image
```
docker pull iexechub/iexec-geth-local
```
start container
```
docker run -d --name iexec-geth-local --entrypoint=./startupGeth.sh -p 8545:8545 iexechub/iexec-geth-local
```
wait to see in logs the word : LOCAL_GETH_WELL_INITIALIZED :
```
docker logs -f iexec-geth-local
```
Your local geth network  is ready, you can launch your truffle test with :
```
iexec truffle test
```

Result must looks like :
```
Contract: TimeClock

refill 10 ether to 0x05d7fa0eff26af1020d82704341f2125c46a4d55

refill 10 ether to 0x2017c14fabfd46f7bf3232db768ad976bdf1d0e9

refill 10 ether to 0x89e4240d1e2ee087b187d583502b48f710a17f46

aRLCInstance.address is

0x2932ec800944dab6958bf05998eb6b5bc4b76307

aIexecOracleEscrowInstance.address is

0xba488861edf91c951ba8631dc37ac5d86073b2ac

aIexecOracleInstance.address is

0xe289bf4361db1cef66b061e16afff9b8b29e4726

aTimeClockInstance.address is
0x1a88633927a1bcfd9f666895ee9efda0e795ce7d

  ✓ Geth mode example : test only launch when geth is used

  - TestRPC mode example : test only launch when testrpc is used

  ✓ Test provider and dapp of TimeClock are set correctly in IexecOracle

  ✓ Test initial employeeAtOffice

  ✓ Test initial alarm state

  ✓ Test badgeIn function by dappUser (8586ms)

  Test badgeOut function by dappUser

aTimeClockInstance.address is

0x8ba61a60d73ce2ae785c1e1d8325b8a43326fb40

refill 5 ether to 0x8ba61a60d73ce2ae785c1e1d8325b8a43326fb40

dappUserBadgeInTime is :

1514489982

    ✓ Test getEmployeeBadgeInTime not null after badge In

aTimeClockInstance.address is
0xde84cc5f2893a313dce030312db4e7fa2dbfec06

refill 5 ether to 0xde84cc5f2893a313dce030312db4e7fa2dbfec06

wait 8000 burning cpu

DailyPay employee [0x05d7fa0eff26af1020d82704341f2125c46a4d55] received : 47 wei

    ✓ Test badge-out function call . Geth MODE (37809ms)

aTimeClockInstance.address is

0xee42cf7bac0b59257a86d9fc60ae7f739456ef27

refill 5 ether to 0xee42cf7bac0b59257a86d9fc60ae7f739456ef27

    - Test badge-out function call . TestRPC MODE





7 passing (3m)

2 pending

```
