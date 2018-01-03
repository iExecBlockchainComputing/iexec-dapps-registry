# Tensorflow on iExec 
## Distributed Neural Net Calculation on iExec Blockchain
This dapp enables Tensorflow's distributed calculation codes on iExec sdk by which any programmer can make models in any amount of calculation.

## Usage
Your commands
(1) SET numbers of workers,and send requests.
(2) SET environment values
(3) execute manager program.
''./app/task''
(4) deploy on iExec
(5) Wait for workers.
 
Workers' commands
(1) SET environment values
(2) execute worker program.

##Code and Binary
1. app/task 
This is exe file which was compiled from tensorflow python codes.

2. python/
This directory includes tensorflow source codes.These codes were compiled by
pyinstaller.

3. input/
You should put your input data for tensorflow NN to here.Then worker can download it from the url of this directory.

4. example/
you can run MNIST learning test by "mv example/mnist app/task".
alse read codes "vi python/mnist.py"

## [Examples](./examples)
A link to all iexec.js conf examples for the dapp.

#For iExec team
##Idea proposal
Generally ML needs much amount of calculation especially NN.Tensorflow is a NN library which is cut out for distributed NN calculation among several machines.Enabling this package on iExec makes a trustless and scalable NN calculation without huge machines. 
This is neither an ensembling learnig nor an application deployment.
This is distributed and parallel computing which can shorten the run time.

##Roadmap
by 1/19 Deploying mnist task on iexec blockchain.

by 1/31 Launching the user interface.One can load any data and ask calculation.

by 2/10 Applying to Dapps store.  

##Component diagram
please take look at component.png

##Sequential diagram of the solution
please take look at sequence.png

##Bonus: a dapp smart contract with truffle tests

