# Proof-of-Work

## Description

PoW-DApp aim to provide a decentralized crypto-mining marketplace while helping
miners to increase their gains by reducing pool fees.  

We want to let people buy tokens that are not yet tradable on any platform by
mining them. And encourage people who have mining hardware to maximize their
profits if they don’t want to mine anything in particular.  

Also, by creating a fully decentralized pool, with a certain amount of hash-rate
we can reduce the fees to only blockchains fees.

This would lead to multiple use-cases where anyone could :
 + rent computed power to mint whatever they want
 + lend computed power to make profits with their hardware
 + connect to a decentralized pool to get reduced fees

## Implementation Presentation

 + __The App__
```
On mining side, it's completely blockchain agnostic. The app running the calculations takes in parameters: an algorithm, some data (usually a block header) and a difficulty. Then, it send back a nonce if found.
```

 + __The 'base' smart-contract__
```
Make the connection between someone buying computed power with his parameters.  
The buyer pay the contract for a certain amount of computed power, he can send multiple parameters during the process. Each time he change the parameters, the miner stop and re-start with new parameters.
```

 + __The 'pool' smart-contract__
```
This allow people to run organized mining. The miners agreed to mine the same block header that contains a multisig address in the COINBASE. Then, if then pool successfully mine the block, miners can sign the transaction where everyone
get his tokens.  

We could also add rules like middle proof-of-work to proove a hash-ratio. And everyone should be able to audit every miners from his intermediate PoW(s) and his proof-of-work(s).  

This would mean the only fees are in transaction to pay miners. There is no middleman to do the job, it's fully decentralized.
```

 + __Client Side__
```
The client contains an interface to buy/sell computed power.  
It should also propose to connect directly to any RPC from any (full/vpc) node.  
And in the future, we should be able to connect to the decentralized pools with our own miner.
```

## Why is it Built on Ethereum?

We choosed to use an already existing ledger and plug the DApp on it. We wanted
to only focus on things that matters: the DApp and not the blockchain
technology. And because there is already dozens of blockchains ready to support
DApps, we just have to found one that fits our needs.

Ethereum is one of the most advanced ledger right now. It already provide a lot
of functionalities. Also, a lot of people already know Ethereum and the network
seems more secure because of it's high valuation and large use across the globe.

## Why does it use Iexec?

It does use Iexec because the Ethereum network won't provide the needed computed
power at a reasonable cost. It would be too expensive to mine directly on the
chain because every (full/vpc) nodes would be required to run the calculations.
Also, there is too much gas needed to mine anything (even at the lowest
difficulty). But we only need one (trusted) machine to run the miner and write
the result on the decentralized ledger.

Iexec provide a lot of computing power resources and connect them onto the
Ethereum chain. We could get the power outside of the chain while still using
the Ethereum blockchain to manage the DApp. This would mean less cost and more
power. And because of that, we only need to focus on connecting miners with
PoW-buyers through the DApp.

## Usage
 + Initialize your IExec wallet :
```
iexec wallet create # create a wallet
iexec wallet getETH # get some ETH
iexec wallet getRLC # get some RLC
iexec wallet show
```
 + Initialize your IExec account :
```
iexec account login
iexec account allow 5
iexec account show
```
 + Deploy with : `npm run deploy`
 + Submit work : `iexec submit --chain ropsten`
 + Check result : `iexec result <txHash> --chain ropsten`
