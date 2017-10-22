# IExec dApp for outsourcing 

## Goal of the dapp

Today, more and more companies resort to outsourcing in order to have tasks of certain fields taken care of without having to hire anybody inside the company. One field where the outsourcing play a quite important part is IT and particularly the development of programs. Indeed, a lot of companies pay others companies that are specialized in development of IT solutions to take care of their needs in this domain. Unfortunately, it is not uncommon to see litigation happens between the concerned companies about the work that has been done. This may be due to several reasons like a bad work done by the client doing the specifications or a misunderstanding from the developers. The goal of our dapp is to limit the number of litigation and make the outsourcing safer for both parts by using smart contracts.

## Why is it built on Ethereum

The dApp will be built on Ethereum to allow the use of smart contracts. A smart contract will take care of expressing all the specifications and tests that need to be passed in order to confirm that the program developed is conform. All those informations could be stored off chain.

## Why does it use iExec

The dApp will use iExec in order to run the computations needed to test programs. The result of those computations will be sent back to the smart contract to define the percentage of acceptance of the work done by the developers.

## A presentation of the implementation

![alt text](https://github.com/Andy92Pac/iexec-dapp-samples/blob/dapp-challenge/img/schema.png?raw=true "IExec dapp challenge schema")

As stated earlier, a smart contract will allow the client to express all the specifications and the tests that need to be validate to accept the program. Those specifications could include date limit, bug acceptance percentage, etc... The max amount that the company is willing to pay for the development is locked using a stable coin. Once the client is done setting those parameters and the tests that are going to run to test the program, the developers can start working on the program.
When the development is done, the program is deployed on IExec and the tests are launched via a call to the smart contract. 
The results of the testing are then sent back to the smart contract and the latter take care of the rest. A percentage or the totality of the amount locked in the smart contract is sent to the developers of the program depending of the results of the computations done on IExec.