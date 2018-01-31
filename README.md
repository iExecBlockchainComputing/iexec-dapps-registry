# Abstract

We propose an API for the off-chain execution of programs in the side-effect-free fragment of Haskell.
This enables smart contracts to delegate gas intensive computations and thus save money.

# Idea Proposal

As computational power on the blockchain is expensive (due to high gas consumption), it is favorable to pull computations off the blockchain.
In this proposal, we want to address two problems (A and B):

A)
There are many use cases for substituting on-chain calculations with cheaper off-chain calculations.
But it is too much boilerplate code and deployment effort to generate a unique DApp for each of these problems.
Should we really have a specific single purpose DApp that computes the human readable date from unix timestamps, another one that computes the median of a list of integers and another that calculates the average of a list of integers? Each of these ideas also has to be submitted as an DApp to the Iexec app store and the code of each of these DApps has to be reviewed individually, even though most of it is just boilerplate code.


We propose a general framework for executing such code snippets. This enables us to solve a multitude of problems with one DApp, but we shouldn’t forget that with power comes responsibility. This leads us to the second problem:


B)
We have to guarantee security for the providers of computational power, so that no malicious code can be executed on the servers running the calculations.

In other words, we are trying to find the sweet spot between expressiveness and security.

In our opinion, both can be achieved by allowing only the definition of side-effect free programs. Such programs are not allowed to access the internet, write to disk or call system functions. Thus, these kind of programs cannot pose a security risk for the host machine.


Of course, such a proposal is only useful if there is a simple mechanical check for the absence of side-effects.
The functional programming language Haskell provides such tools.
Every function in Haskell has a unique type that reveals
whether the function is side-effect free.
In order to check if the entire program is side-effect free, it is sufficient to check the type of the main function.

Before creating this proposal, we came up with countless simple single-purpose applications for the iExec challenge.
At some point, we realized that all of those snippets are side-effect free programs, which will now serve as mere demonstrators for the proposed framework.
We will briefly sketch three of them in the next section.

## Operations on numeric array

For-loops are heavily used in Solidity but can be very expensive in terms of gas.
Most of these can be compactly formulated in Haskell (example below).
By pulling the computations off the blockchain, a lot of gas and thus money can be saved.

The following shows a typical example of a for-loop in Solidity. Imagine a betting game, where each user gets a payout depending on the number of correct guesses. The Solidity script calculates the total payout for each user.

Let bets[i] be the number of correct guesses of User i.


Solidity:

>for(uint j=0;j<=betIndex;j++) {

> sum = sum + bets[j];

>}

>for(uint j=0;j<=betIndex;j++) {

> payout[j] = (bets[j] * totalPayout)/sum;

>}

The following Haskell code is functionally equivalent:


>let su =  sum bets

>let payout =  map  ((round) . (/su) . (*total_payout)) bets

For a very concrete example, spawning an off-chain computation on iExec could be wrapped like this:

>iexecSubmit("bets = [1,20,3,4,5]; let su =  sum bets;let payout =  map  ((round) . (/su) . (*3000)) bets")

Here, the values of the array bets are hardcoded, but they can come from any uint array in the smart contract.

For larger arrays, the cost of RLC could be much lower than the cost of gas.

## String operations


Another use-case could be string operations, eg. replace:

>iexecSubmit("replace \"O\" \"X\" ".toSlice().concat(text.toSlice()))

In this example all “O” are replaced by “X” in the solidity string text. All other string operations in Haskell could be used in the same way.


## Date API


A third use-case is to calculate dates exactly, taking into consideration leap seconds and time zones.
For example, it would be possible to convert a Unix timestamp into a human readable string:

>iexecSubmit("formatTime defaultTimeLocale \"%c\".toSlice().concat(stringUtils.uintToBytes(now).toSlice()))

Other possible functions include converting string dates to Unix timestamps and adding/subtracting specific time intervals to/from dates.

The example above uses the Solidity libraries https://github.com/Arachnid/solidity-stringutils and https://github.com/pipermerriam/ethereum-string-utils for string manipulation.


# Technical Challenges/Problems


## Getting the input data into the correct format

To use the example

>iexecSubmit("bets = [1,20,3,4,5]; let su =  sum bets;let payout =  map  ((round) . (/su) . (*3000)) bets")

with dynamic arrays, it is necessary to convert the integer arrays into strings. (e.g. the uint array uint[] bets  = [1,20,3,4,5]; into the string "[1,20,3,4,5]")
The callback function, which returns the result, has to turn the string "[90, 1800,270,360,450]" into an integer array again, which costs gas.
The overhead of converting to and from strings is considerable.
For complex operations, our solution might still be cheaper, but it is preferable to find a way around this.
If the iExec API allowed to provide arrays as parameters and also returned arrays, this would be much simpler
(Consider this as a feature request!).
The function could then simply be called with

>iexecSubmit(bets, "let su =  sum bets;let payout =  map  ((round) . (/su) . (*3000)) bets").

Independently of this feature, a wrapper function

>iexecArrayOperation(bets, "let su =  sum bets;let payout =  map  ((round) . (/su) . (*3000)) bets")

will be made available by our wrapper smart contract that takes care of converting the parameters into the right format for the iexecSubmit function.

# Roadmap


Alpha:
* All Haskell code can be called with one string parameter from a wrapper smart contract.

Beta:
* Haskell code is only run when it is proven to be side-effect free.


Release:
* The parameter wrapping (eg. from uint array to string) is done in a wrapper smart contract or possibly directly in the iexecSubmit function.

Post-release:
* Proofing and benchmarking the cost-efficiency of our proposed API for the three use-cases. 
* Documenting and communicating the API to the community.


# Component diagram

Verifier

Input: Haskell code as a string
Output: The type of the function containing this code. If it is a pure function, the code can be executed. If it is not, return an exception.


Off-chain App

Input: Haskell code as String or any Solidity data types + Haskell code as String

Output: String of the program output.


Wrapper Smart Contract

The Wrapper Smart Contract has two objectives:
Wraps the Solidity variables and the String containing the code into a String containing the full Haskell code. (including the variable initializations)
Converts the returned result string into Solidity variables in the callback function.


# Sequential diagram of the solution

1. User Smart Contract calls our Wrapper Smart Contract by ForeignFunctionCall

2. Our Wrapper Smart Contract takes care of converting all required data into a String containing the Haskell code and spawns an off-chain computation by calling the iExcec submit function via the iExcec API.

3. iExcec reads the block and finds out that there was a call to our iExec project.
In the "verification phase", the Haskell interpreter is instructed to infer the type of the provided Haskell program.
If it is side-effect free and thus regarded as safe, it is executed using the Haskell interpreter (in an "execution phase").
Its result is written back as the return string to the calling smart contract.

4. The Wrapper Smart Contract converts the computation’s result into the required format and returns it to the User Smart Contract.

# Bonus: a DApp smart contract with truffle tests

The following code on github includes Solidity code and truffle tests for a simple game that can be played on the Ethereum blockchain.
There are two teams, Red and Blue. Players can add money to the stack of Red or Blue and regardless of which team gets money from the player, the player can bet which team wins.
A team wins if it has either more than 50% or less than 25% of the total ETH sent to the team.


https://github.com/ahoelzl/smartContract


# Team

We are an international Munich based team of four people. Two of us are working as Software Engineers in the area of Data Science/Machine Learning, one is a PhD student in the field of Formal Verification and Interactive Theorem Solving and one a Postdoc in the same field.
In our opinion, this is the right mixture of academia and industry.

