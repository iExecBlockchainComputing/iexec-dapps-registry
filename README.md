## Abstract

We propose to provide verified algorithms that would serve as building blocks
for smart contracts implementing supply chains.

## Idea proposal

Various ambitious projects implemented as a smart contract were recently proposed
such as decentralized supply chains. Venture capitalists go even further and talk about
Industry 4.0 [1]. Whether you are a buzzword bingo aficionado or not, let us note that
big players such as Airbus [2] and IBM [3] already started to work on
decentralized supply chains.

We want to stay realistic in our proposal and rather than to implement such a (global)
supply chain, we would like to offer building blocks for such smart contracts.

Regardless of the details, their authors must be able to solve some or all of the following problems:
1) What is the shortest/cheapest/fastest path between places A and B?
2) Given capacities of different supply chains in the network, what is the maximal
amount of products that can be transported over the network?
3) Given an implicit description of the final product, which components do we have to supply
such that they are compatible with each other (e.g., the engine of type E1 allows only for gear boxes G2 or G3)?

Those questions correspond to classical computer science problems that can be solved by
efficient algorithms. Yet, these algorithms cannot be executed on-chain since
to compute anything of nontrivial complexity (definitely anything above the linear complexity),
implies astronomical costs for the user.
Executing them off-chain seems to be a potent workaround to this problem.

Therefore, we propose to solve the problems 1-3 by running the following algorithms
in the iExec cloud:
A1. Dijkstra's Algorithm for the shortest path in a graph
A2. Edmonds-Karp's Algorithm for the maximum flow in a flow network
A3. SAT Algorithm for solving the configuration problem.

Moreover we want to go beyond the usual Implement & Run paradigm.

### The Main Goal:
We want to provide as strong as possible guarantees that the implementation of the
algorithms A1-A3 is correct.

Needless to say, any bug in their implementation
could potentially cause astronomical loss in the context of a global supply chain.

The technology that allows us to achieve The Main Goal is interactive theorem
proving (ITP) used for software verification. This technology has been in development
for 30 years and is based on strong formal notions from mathematics, logic and
computer science.

In our team, we have two experts on Isabelle, one of the leading systems for ITP.
Luckily for us, all the algorithms A1-A3 were already implemented and proved to be
correct in Isabelle [4-7]. Moreover, the Isabelle community developed a framework that
allows us to obtain efficient implementation without compromising the correctness.

Examples of properties that were proved are:
* If the Dijkstra's implementation does not return any path then there is none
in the input graph; if it returns a path between A and B, then any other path connecting A and B
has larger or the same weight as the returned one.
* Edmonds-Karp's implementation always returns a flow such that any other flow
in the graph is not bigger.
* The SAT implementation returns a configuration meeting all the constraints
if and only if there is one.

### How are we going to realize our proposal?

In short:
1. Query
2. Extract
3. Deploy

or even shorter: QED :)

Now seriously:
we plan to query Isabelle's Archive of Formal Proofs, where the theories implementing
the algorithms A1-A3 were submitted. We extract a runnable code from them
(the extraction is a built-in feature of Isabelle) and check how performant the concrete
implementations are and potentially improve the code. We expect if some then rather
mild modifications. While extracting the code, we have a couple of choices which
target programming language we could use (Haskell, OCaml, Scala). Let us stress
that the generated code possesses the same properties that were proved in Isabelle.
The last step is to deploy the generated code into the iExec application.

### References:

[1] https://outlierventures.io/convergence-wp-thanks

[2] https://www.ibm.com/blockchain/supply-chain/

[3] https://www.airbus.com/newsroom/news/en/2017/03/Blockchain.html

[4] https://www.isa-afp.org/entries/Dijkstra_Shortest_Path.html

[5] https://www.isa-afp.org/entries/EdmondsKarp_Maxflow.html

[6] https://www21.in.tum.de/~lammich/pub/cade2017.pdf

[7] https://www21.in.tum.de/~lammich/grat/


## Component Diagram


### Wrapper smart contract

The wrapper wraps the inputs and outputs of the calls to the offline app.

### Offline App for A1:

Input: Graph with weights on its edges.

Output: Shortest path.

### Offline App for A2:

Input: Graph with weights on its edges.

Output: Integer representing the maximal flow of the network.

### Offline App for A3:

Input: Propositional logic formulas representing the constraints.

Output: Assignment (of values to the variables) representing the solution of the constraint problem.

## Sequential diagram of the solution

Step 1: The user uploads the files representing the problem to iExec via the command line and calls the algorithm they want to execute.

Step 2: The offline app computes the formally verified solution to the given problem.

Step 3: The user gets the link to the result on the command line. Due to the nature of our project, the user can be sure that this is the correct solution.

## Roadmap

Beta: All algorithms work and can be called via iExec.

Release: Performance improvements if needed.


## Team

### The MAOH Team

We are an international Munich-based team of four people. Two of us are working as software engineers in the area of data science/machine learning and the other two are a PhD student and a postdoc in the field of formal verification and interactive theorem proving.
In our opinion, our team represents the right mixture of academia and industry.
