# iExec dapp samples
## 1 branch = 1 dapp

Each branch of this repo is a sample iExec dapp, and can be easily played with by using the [iexec sdk cli](https://github.com/iExecBlockchainComputing/iexec-sdk) like this:
```iexec init branchName```


```bash
iexec init # current branch containing minimum working config
iexec init factorial # download and init factorial dapp
iexec init echo # download and init echo dapp
```

Start a [Pull Request](https://github.com/iExecBlockchainComputing/iexec-dapp-samples/pulls) to add you dapp to this repo.

## [iExec Dapp Challenge](https://medium.com/iex-ec/the-iexec-%C3%B0app-challenge-150k-of-grants-to-win-abf6798b31ee)

 * Go checkout the [iExec Dapp Challenge](https://medium.com/iex-ec/the-iexec-%C3%B0app-challenge-150k-of-grants-to-win-abf6798b31ee)
 * Go submit a request to be listed on the [iExec dapp store](https://dapps.iex.ec/)

---
# S-Chain (a Dapp for supply chain)
## Description

###### *Summary*

The purpose of this application is to transfer value to the different stakeholders inside a supply-chain. The idea is to rely on the immutability and transparecy provided by the blockchain technology to inform the main actors (or stakeholders) of the chain what is the current state of its goods.

Furthermore, it should allow strategically deployed sensors to interact with each other in order to manage the enviroment in which the goods are being tranported and possibly predict how they are going to be when arriving at their destination.

This Dapp is going to be developed by a team of the Engineering Department at Universidad de Montevideo, Uruguay, as part of a research project on [industry 4.0](https://home.kpmg.com/xx/en/home/insights/2017/10/the-industry-4-0-revolution-is-here.html) and disruptive technologies, led by the CINOI (see Team, below). 

###### *Motivation*

On a country such as Uruguay, where agricultural activity is very important, what drives this project are the following points:

* Reduction of costs due to lack of control of goods in every stage. 
* Creation of value in the form of information about the characteristics of assets collected by sensors during the whole chain.
* Enable the stakeholders with relevant data to fill their compliance reports and develop statistics around them to understand how improvements could be made.
* Reach business oportunities to scale the system on a sustainable fashion.
* Take the advantages of immutability, single global truth and decentralization provided by the blockchain to overcome current centralized IoT system issues.

###### *Background*

Despite the recent innovative solutions on IoT infrastructure on the blockchain, for example  Streamr, they seem to focus on a wider target rather than on applications for the supply chain.

These solutions are based on live stream of data and are used as exchanges for buying and selling raw data captured with sensors from the surroundings. Many of them does not take into account whether this information is valid or not, perhaps, due to a misfunction of the system.

Our approch would be somewhat similar, but at the same time, more reliable since every stakeholder must behave and support the system with trusted information. 

Moreover, the equipment deployed to control the assets' state (sensors and actuators) are going to be autonomus and won't be influenced by earning any reward from the network. Only the current owner of the goods sees the real benefit of the system in the information available on the network and the reduction of management costs.

###### *Initial Scope*

To achive our goals, two types of users are to be defined. Smart sensors (for temperature, humidity, weight, among others) and actuators are going to run their own Ethereum accounts, as well as humans (or the supply chain stakeholders).

The intended workflow is that all the relevant information given by the sensors are going to be processed using the computational resources provided by Iexec (running programms written in Java, Python or Go), so if some value exceeds a given threshold, this will create an event which shall set new parameters to the actuators (e.g. air conditioner). All the communication between this two is carried out through smart contracts deployed on Ethereum (at the beginig, on a test or private network).

Meanwhile, those interested in the status of what is being transported could reach the data over the blockchain since this is going to form part of a smart contracts.

These contracts will represent the assests or goods of the supply chain and their state on real time. Even though the issues found on scalability and network latency of the blockchain, considering the transport of goods aren't instanteneous, this should not affect much the overall eficiency of the initial system.

###### *Planning*

Owning to the fact that this is a research project, the amount of resources are limited until progress has been achived. For that matter, there will be serveral trials during the first three months of 2018. Whether it succeeds, more people may come to work on it and more resources would be avaliable.

Initially, the considered roadmap will be the one shown bellow.

> 01/05/18 - 01/15/18 : **Learning**

Develop and improve the neccessary skills to work with smart contracts and define which hardware (Ardunio, Raspberry-Pi , emmbed systems or linux embedded) are needed for the sensors and actuators. Determine the supply chain to be used as test case.

**Note :** The considered supply chain so far is the transport of fruits and vegetables inside Uruguay (from the farm to the city's grocery store).

> 01/16/18 - 02/02/18 : **Implementing**

Start deploying the smart contracts on a testing network (public or private - using puppeth -) and system logic on Iexec (or other CSP)

> 02/03/18 - 02/20/18 : **Integration**

Adapt peripherals and run tests to adjusts the measured parameters so as they are accurate enough for the supply chain. Begin the development of UI (possibly web-based - using the React framework -) for the stakeholders to interact with the contracts.

> 02/21/18 - 03/05/18 : **Analysis and futher improvements**

Check whether the main goals were achived, study the results and difficulties encountered during the development. Propose changes to the design and future work to improve the Dapp.

**Trello board**

At the end of every week this [Trello board](https://trello.com/b/wXZNnXtR/s-chain-a-dapp-for-supply-chain) is going to be updated to show how the project is advancing, what activities are in progress and what has been done.

###### *Team*

The team if formed by a group of engineering students from [FIUM](http://fium.um.edu.uy/) and members of the [CINOI](http://fium.um.edu.uy/produccion-academica/cinoi/). The technical development will be done by a group of Telematic engineering students, while the relevant information and business analysis will be carried out by Industrial engineers.

## Dapp params
On progress

## Initial work
On progress, developing and testing with truffle on a local Ethereum node (testrpc - Ganache-core -).

