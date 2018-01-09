bstract
We propose an API for off-chain execution of programs in the side-effect-free fragment of Haskell.
This enables smart contracts to delegate gas intensive computations and thus save money.

#Idea Proposal

For-loops are heavily used in Solidity but can be very expensive in terms of gas.
Most of such easy computations can be compactely reformulated in a functional programming language
such as Haskell (example below). 
By pulling those computations off the blockchain, a lot of gas and thus money can be saved.

Example of for-loop in solidity and an equivalent functional program:

for(uint j=0;j<=betIndex;j++) {
 sum = sum + bets[j];
}

for(uint j=0;j<=betIndex;j++) {
 bets[j] = bets[j]/sum;
}

> bets = [1,20,3,4,5]
> sum = fold (+) bets
> map (%b. b / sum ) bets

Spawning an offchain-computation on iexec could be compactely wrapped like this:

iexecSubmit("bets = [1,20,3,4,5]; sum = fold (+) bets; map (%b. b / sum ) bets")

For larger arrays the cost of RLC could be much lower than the cost of gas.


* Potentially this MapReduce can be calculated distributed
* foreign code in Haskell's side-effect-free fragment can be executed without security concerns
* 




##Roadmap
 * Design of a simple use case Smart Contract

 * Design Choice: which existing Library to use (Python lambda expression? is there some Haskell library? ...)

 * Development of the DApp w.r.t. the aforementioned Design

 * Deployment of API as version 0.1 including map, reduce

 * Deployment of API as version 0.1 including sort

 * Process Mining and Platform for Feedback and Feature Requests (in order to monitor usage behaviour)



##Component diagram

Wrapper Smart Contract
Wraps the call to the offchain-app, takes care of conversion to the correct format

Offchain-app
Input: Float Array and lambda expression as string
output: Float Array

##Sequential diagram of the solution

1. User Smart Contract (calling SC) calls our Wrapper Smart Contract by ForeignFunctionCall

2. Our Wrapper Smart Contract takes care of spawning off an off-chain date API call, by calling the IExcec submit function via the IExcec API


3b. IExcec reads the IExcec block and DApp binary, runs it i, verifies its legitimacy, and writes back the return array to the calling SC.


4. Smart Contract uses the computation's result for the next killer App.

##Bonus: a dapp smart contract with truffle tests
 


