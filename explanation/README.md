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

#Dapp-Challenge-Format
##Idea proposal
Generally machine leaning needs much amount of calculation especially Neural Net (NN). Tensorflow is a NN library which is cut out for distributed NN calculation among several machines.Enabling this package on iExec makes a trustless and scalable NN calculation without having a huge machine. 
This is neither an ensembling learnig nor a deployment on a single machine.
This is distributed and parallel computing which can shorten the run time.

About Tensorflow:
Tensorflow is a Deep Learning library with scalability by distributing,CPU/GPU flexibility,and law level codings.
Distributing DL tasks on several machines is needed no matter of whether the task is
(1)Data parallel or Model parallel
(2)Synchronous or ASynchronous 
(3)Using GPU or only CPU

and,in any case,is able to shorten the run time.
In addition,by iExec SDK, there is also a possibility to achieve purposes below
(1)Cloud Sourcing of Machine Learning
(2)Auto Scaling of Machine Learning
(3)Cloud Sourcing of Designing models
All of the above is about trustless Collaborations about Machine Learning,and (1) can be achieved in a simple code (python/task.py).

This proposal forcuses on (1)Cloud sorcing of Data Parallel Machine Learning,and designs the system extensible for (2),(3).
Basically,Tensorflow is extensible,and these iExec codes should make use of this feature.
To be easily forked for extensions,these point should be made sure of
(1)Clear design patterns and documents describing these.
(2)Simple codes and documents for connections between tensorflow packages and iExec SDK.
(3)Example codes of famous tests (MNIST,cifar10)

Reference: 
[Tensorflow Document](http://download.tensorflow.org/paper/whitepaper2015.pdf)
[Tensorflow Code sample](https://www.tensorflow.org/deploy/distributed)
[Distributed Tensorflow Overhead Measurement Benchmark](https://gist.github.com/ahaider3/ae4f6d2d790d963a93b346bb0138a41d)

##Roadmap
by 1/19 Deploying mnist task on iexec blockchain.

by 1/31 Launching the user interface.One can load any data and ask calculations.

by 2/10 Challenge to auto scaling.
        Applying to Dapps store.  

##Component diagram
please take look at component.png

##Sequential diagram of the solution
please take look at sequence.png

##Bonus: a dapp smart contract with truffle tests

