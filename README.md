Abstract


We propose an API for off-chain execution of programs in the side-effect-free fragment of Haskell.
This enables smart contracts to delegate gas intensive computations and thus save money.

#Idea Proposal


It would be ideal if smart contract deverlopers could just run general purpose code that is computationally intensive off-chain instead of on the blockchain.
 This is, however, a security risk for the people running the calculations of their personal computers. 
We believe that side-effect-free Haskell functions allows for a large multitude of possible programs that can be run while 
ensuring that there is no legal or security risk for the person selling their computational ressources.
 Ensuring and proofing the security of all possible programs that can be run on the servers running the offchain-computations is part of the project
 (TODO: write some more).

There are many use-cases for this, we propose three of them here:
 
1) Operations on numeric array 

One possible use-case for this would be performing operations on arrays. 
For-loops are heavily used in Solidity but can be very expensive in terms of gas.
Most of such easy computations can be compactly reformulated in Haskell (example below). 
By pulling those computations off the blockchain, a lot of gas and thus money can be saved.

Example of for-loop in solidity and an equivalent functional program, which calulates 
the total payout for each users, if user i has correctly betted the amount bets[i]: 

Solidity:

for(uint j=0;j<=betIndex;j++) {
 sum = sum + bets[j];
}

for(uint j=0;j<=betIndex;j++) {
 payout[j] = (bets[j] * totalPayout)/sum;
}

Haskell: 

> bets = [1,20,3,4,5]

> let sum = fold (+) bets

> let bets2 = map (%b. b*3000) bets

> map (%b. round b / sum ) bets2

Spawning an offchain-computation on iexec could be wrapped like this:

iexecSubmit("bets = [1,20,3,4,5]; let sum = fold (+) bets;let bets2 = map (%b. b*3000) bets; map (%b. round b / sum ) bets2")

For larger arrays the cost of RLC could be much lower than the cost of gas. 
Here the values of the array bets are hardcoded, but they can come from any uint array in the smart contract.


2) String operations


Another use-case could be string operations, eg. replace:

iexecSubmit("replace \"O\" \"X\" ".toSlice().concat(text.toSlice()))

In this example all O are replaced by X in the solidity string text. All string operations in Haskell could be used that way.


3) Date API


A third use-case is to calculate dates exactly, taking into consideration leap seconds and time zones. 
For example, it would then be possible to get the exact date as a string given the unix time stamp:

iexecSubmit("formatTime defaultTimeLocale \"%c\".toSlice().concat(stringUtils.uintToBytes(now).toSlice()))

Other possible functions include estimating unix time from dates as string and adding/substracting specific time intervals to/from dates.

The example above uses https://github.com/Arachnid/solidity-stringutils and https://github.com/pipermerriam/ethereum-string-utils for string manipulation.


#Challenges/Problems


These are the main challenges of the project:

1) Getting the input data into the correct format

To use the example
 
iexecSubmit("bets = [1,20,3,4,5]; let sum = fold (+) bets;let bets2 = map (%b. b*3000) bets; map (%b. round b / sum ) bets2") 

with dynamic arrays it would first be necessary to convert an array, for example uint array uint[] bets  = [1,20,3,4,5]; into the string "[1,20,3,4,5]". 
The returned string "[90, 1800,270,360,450]" would then have to be turned into a uint array again, which would cost gas. 
For complex operations our solution might still be cheaper, but it would be good to find a way around this. 
If the Iexec API would allow to give arrays as parameters and return arrays as parameters, this would be much simpler.
The function could then be called simply as 

iexecSubmit(bets, "let sum = fold (+) bets;let bets2 = map (%b. b*3000) bets; map (%b. round b / sum ) bets2"). 

Independently of that, a wrapper function 

iexecArrayOperation(bets, "let sum = fold (+) bets;let bets2 = map (%b. b*3000) bets; map (%b. round b / sum ) bets2")

 will be made available by out wrapper smart contract that takes care of converting the parameters into the right format for the iexecSubmit function.
Additionally the wrapper function would ensure that it is not necessary to manually concatenate the strings in a complicated manner. 
One way to do this might be to have an iexecSubmic function with several string parameters, and $x in the last parameter is replaced by 
the first parameter and $y in the last parameter is replaced by the second parameter. Example function call: 

iexecSubmit(text, "replace \"O\" \"X\" $x)

or 

iexecSubmit(stringUtils.uintToBytes(now), "formatTime defaultTimeLocale \"%c\ $x")

These wrapper functions will also be written by us if they are not made available at a deeper level.

2) Ensuring that all functions are side-effect free and there is no IO operations except at the beginning and at the end. 


Two extremes: Either allow only functions written by us and allow any Haskell code. TODO: Max



##Roadmap
 * Implement the three mentioned use cases

 * Research how parameters could be passed and returned in the cheapest way

 * Benchmark starting at which level of complexity calling iexecSublit is cheaper then calculating everything on-chain

 * Research how to ensure that all functions are side-effect free

 * Document the existing API so that it can be used and extended by other people


Version 1.0:
* The three mentioned use-cases can be called with one string parameter from smart contracts.

Version 2.0:
* The parameter wrapping (eg. from uint array to string) is done in a wrapper smart contract or possibly directly in the iexecSubmit function. 

Version 3.0:
* Additional Haskell functions are available if they are guaranteed to be save.


##Component diagram

Wrapper Smart Contract
Wraps the variables and the pure code to haskell code, converts the haskell string output into the proper format.

Offchain-app
Input: Haskell code as string, or any solidity data types + haskell code as string
output: string

##Sequential diagram of the solution

1. User Smart Contract (calling SC) calls our Wrapper Smart Contract by ForeignFunctionCall

2. Our Wrapper Smart Contract takes care of converting all required data into a string containing the haskell code and spawns an off-chain computation, by calling the IExcec submit function via the IExcec API


3. IExcec reads the block and finds out there was a call to our iexec project and the binary in the apps folder starts to run with the given parameters. After running it  writes back the return string to the calling smart contract.


4. The wrapper Smart Contract converts the computation's result into the required format and returns it to the User Smart Contract.

##Bonus: a dapp smart contract with truffle tests
 


