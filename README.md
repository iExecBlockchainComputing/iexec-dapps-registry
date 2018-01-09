
##Abstract

This distributed app enables the on-chain usage of date computations in Smart Contracts,
by providing access to an off-chain date API; its functionality includes addition of dates and time zone
conversion, being correct even w.r.t. nasty details such as leap seconds.

##Idea proposal

Every author of a smart contract faces this problem:
Calculation of dates and times get quite involved/involved if correctness is required/crucial.
As no correct and efficient Library for that exists in Solidity, any author of smart contracts has
to implement these functions themselves and have them executed on chain.
This has two big disadvantages:
* time computations are involved and hard to implement correctly. (citation! to some hidden bug)
* time/date computations are complicated and especially time/gas intensive

By pulling these computations off chain one can trust/delegate these problems to an API that is
designed to be correct and executed in a distributed and cost efficient framework.
This enables authors of smart contracts to base their work on a correct foundation of API functionality.


As future developments of usage of smart contracts can hardly be estimated let alone foreseen/forcasted,
it is hard to rate the usefullness of these specific API functionality, nevertheless we came up with
this one (speculative) use case where involved date computations are crucial or at least beneficial:

Imagine a speed up of the time difference of two consecutive Ethereum blocks to under 1 second, also
imagine that micro trading gets a use case for Etherium, then things like leap seconds may result in
problematic behaviour of smart contracts.
Using correct API functionality for time and date computations lay the foundations of correct and
safe smart contracts that involve timed actions.

##Roadmap

 * Design of a simple use case Smart Contract

 * Analysis of competitors (pricing)

 * Design Choice: which existing Library to use (Linux date library? is there some Haskell library? ...)

 * Design of API functionality and priceing (version 0.1)
  --> how can an author of a SC react if pricing changes suddenly?
  --> can we change the price of an API call freely?
  --> are the prices demanded by IExcec stable or volatile? in which currency?
  -->

 * Development of the DApp w.r.t. the aforementioned Design

 * Deployment of API as version 0.1

 * Process Mining and Platform for Feedback and Feature Requests (in order to monitor usage behaviour)

##Component diagram





##Sequential diagram of the solution

1. User Smart Contract (calling SC) calls our Wrapper Smart Contract by ForeignFunctionCall

2. Our Wrapper Smart Contract takes care of spawning off an off-chain date API call, by calling the IExcec submit function via the IExcec API
[advantage of this approach: the author of the calling SC does not have to invest the time to learn the IExcec API]

[IExcec stuff:
3a. IExcec block (?) is included in the next Ethereum block
3b. IExcec reads the IExcec block and DApp binary, runs it in a distributed manner, verifies its legitimacy, and writes back the return value to the calling SC.
]

4. Smart Contract uses the computation's result for the next killer App.

It's as Easy as that! :)

##Bonus: a dapp smart contract with truffle tests

Done



