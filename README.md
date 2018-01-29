####Abstract


We propose an API for off-chain execution of programs in the side-effect-free fragment of Haskell.
This enables smart contracts to delegate gas intensive computations and thus save money.

####Idea Proposal

As computational power on the blockchain is expensive (due to high gas consumption) it is favorable to pull computations off the blockchain.
In this proposal we want to adress two problems (A and B):

A) 
There are many use cases for substituting onchain calculations with cheaper offchain calculations. 
But it is too much boiler-plate and deployment effort to generate a unique DApp
for each of these problems.
Should we really have a specific single purpose DApp that computes
the human readable date from unix timestamps, another one that computes the median of a list of integers and another that that calculates the average of a list of integers? Each of these ideas also has to be submitted as an app to the Iexec app store and the code of each of these dapps has to be reviewed individually, even though most of it is just boilerplate code.


What we propose is a general framework for executing such code snippets.


B)
But we shouldn't forget that with power comes responsibility. 
We have to guarantee security for the providers of computational power, so that no malicious code can be executed on the servers running the calulcations

In other words, we are trying to solve an optimisation problem: between expressiveness and security.

In our opinion, side-effect free programs are the sweet spot on this scale.
Such programs are amonst others not allowed to access the internet, write to disk or call system functions. But they ARE allowed to compute any desired function that only depends on its parameters and return its result.


Of course, such a proposal is only useful if there is a simple mechanical check for the absence of side effects.
In contrast to imperative programming languages such as C++ or Java, the functional programming language Haskell provides such facilities.
Every program in Haskell has a unique type that reveals
whether the program is side effect free. 

When brainstorming for this challenge we made the same mistake and came up with
countless simple single purpose applications.
At some point we realized that all of these snippets are side effect free programs, which will now serve as mere demonstrators for the proposed frame work.
We will briefly sketch three of them in the next section.

##Operations on numeric array

One possible use-case for this is performing operations on arrays.
For-loops are heavily used in Solidity but can be very expensive in terms of gas.
Most of such easy computations can be compactly formulated in Haskell (example below).
By pulling those computations off the blockchain, a lot of gas and thus money can be saved.

Example of for-loop in solidity and an equivalent functional program, which calulates
the total payout for each users, if user i has correctly betted the amount bets[i]:

Solidity:

>for(uint j=0;j<=betIndex;j++) {

> sum = sum + bets[j];

>}

>for(uint j=0;j<=betIndex;j++) {

> payout[j] = (bets[j] * totalPayout)/sum;

>}

Haskell:

>let bets = [1,20,3,4,5]

>let su =  sum bets

>let payout =  map  ((round) . (/su) . (*3000)) bets



Spawning an offchain-computation on iexec could be wrapped like this:

>iexecSubmit("bets = [1,20,3,4,5]; let su =  sum bets;let payout =  map  ((round) . (/su) . (*3000)) bets")

For larger arrays the cost of RLC could be much lower than the cost of gas.
Here the values of the array bets are hardcoded, but they can come from any uint array in the smart contract.


##String operations


Another use-case could be string operations, eg. replace:

>iexecSubmit("replace \"O\" \"X\" ".toSlice().concat(text.toSlice()))

In this example all O are replaced by X in the solidity string text. All string operations in Haskell could be used that way.


##Date API


A third use-case is to calculate dates exactly, taking into consideration leap seconds and time zones.
For example, it would then be possible to get the exact date as a string given the unix time stamp:

>iexecSubmit("formatTime defaultTimeLocale \"%c\".toSlice().concat(stringUtils.uintToBytes(now).toSlice()))

Other possible functions include estimating unix time from dates as string and adding/substracting specific time intervals to/from dates.

The example above uses https://github.com/Arachnid/solidity-stringutils and https://github.com/pipermerriam/ethereum-string-utils for string manipulation.


####Technical Challenges/Problems


##Getting the input data into the correct format

To use the example

>iexecSubmit("bets = [1,20,3,4,5]; let su =  sum bets;let payout =  map  ((round) . (/su) . (*3000)) bets")

with dynamic arrays it is necessary to convert an array, for example uint array uint[] bets  = [1,20,3,4,5]; into the string "[1,20,3,4,5]".
The returned string "[90, 1800,270,360,450]" then has to be turned into a uint array again, which costs gas.
The overhead of converting to and from strings is considerable.
For complex operations this solution might still be cheaper, but is preferable to find a way around this.
If the IExec API allowed us to give arrays as parameters and returned arrays, this would be much simpler
(Consider this as a feature request!).
The function could then be called simply as

>iexecSubmit(bets, "let su =  sum bets;let payout =  map  ((round) . (/su) . (*3000)) bets").

Independently of that, a wrapper function

>iexecArrayOperation(bets, "let su =  sum bets;let payout =  map  ((round) . (/su) . (*3000)) bets")

 will be made available by our wrapper smart contract that takes care of converting the parameters into the right format for the iexecSubmit function.
The wrapper function additionally would ensure that it is not necessary to manually concatenate the strings in a complicated manner.

The call to out wrapper function could for example look like this:

>iexecSubmit(text, "replace \"O\" \"X\" $x")



####Roadmap


Alpha:
* All Haskell code can be called with one string parameter from a wrapper  smart contracts.

Beta:
* The parameter wrapping (eg. from uint array to string) is done in a wrapper smart contract or possibly directly in the iexecSubmit function.

Release:
* Haskell code is only run when it is ensured that is side-effect free

Post-release:
* Proofing and benchmarking the cost-efficiency of our proposed API for the three use-cases; Documentation and communicating the API to the community


####Component diagram

Verifier
Input: haskell code as a string
Output: The type of the function containing this code. If it is a pure function,the code can be executed, if it is not return an exception


Offchain-app

Input: Haskell code as string, or any solidity data types + haskell code as string

Output: String of the output of the program.


Wrapper Smart Contract

Wraps the solidity variables and the code-string to the full code-string and converts the haskell string output into the proper format in the callback function.


####Sequential diagram of the solution

1. User Smart Contract calls our Wrapper Smart Contract by ForeignFunctionCall

2. Our Wrapper Smart Contract takes care of converting all required data into a string containing the haskell code and spawns an off-chain computation,
 by calling the IExcec submit function via the IExcec API.


3. IExcec reads the block and finds out that there was a call to our iexec project and the binary in the apps folder starts to run with the given parameters.
In the "verification phase" the Haskell interpreter is instructed to infer the type of the provided Haskell program.
If it is side effect free and thus regarded as safe, it is executed using the Haskell interpreter (in an "execution phase")
and its result is written back as the return string to the calling smart contract.

4. The wrapper Smart Contract converts the computation's result into the required format and returns it to the User Smart Contract.

##Bonus: a dapp smart contract with truffle tests

The following code on github includes solidity code and truffle tests for  a simple game that can be played on the Ethereum blockchain.
There are two teams, Red and Blue. Players can add money to the stack of Red or Blue and independently of which team gets money from the player, the player can bet which team wins.
A team wins if it has more than 50% or less than 25% of the total ETH sent to the team.


https://github.com/ahoelzl/smartContract
