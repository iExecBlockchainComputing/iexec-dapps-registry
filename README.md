# Tensorflow on iExec 
## Distributed Neural Net Calculation on iExec Blockchain
This dapp enables Tensorflow's distributed calculation codes on iExec sdk by which any programmer can make models in any amount of calculation.

##MNIST Example Usage

###[CAUTION]
This is just a test program that executes mnist on iexec between 2 ip address.
There is neither scaling system nor managing system. 

###Ethereum Environment Setup
(1)
<code>geth -networkid "10"  -nat "none" console</code>
(2)
<code>testrpc</code>

###Your commands
(1) change explanation/python/iexecsetting.py
    do environment setting here

<code>
vi explanation/python/iexecsetting.py

PS_HOST="IP:PORT"
WORDER="IP:PORT"
MODE="ps"
INDEX=0
</code>

(2) execute manager program and deploy on iExec
<code>iexec truffle test</code>

(3) Wait for workers.
 
###Workers' commands
(1) change explanation/python/iexecsetting.py
    do environment setting here
<code>
PS_HOST="IP:PORT"
WORDER="IP:PORT"
MODE="worker"
INDEX=0
</code>
(2) execute the worker program
<code>iexec truffle test</code>

###[CAUTION]
you don't have to command
<code>iexec result</code>
the result can be found in the result dump of Tensorflow.

###[CAUTION]
You need to install python3
the initial program "apps/Tensorflow"
is just commiting "python3 ../explanation/python3/task.py" in cmdline.
This is a compiled python code.

