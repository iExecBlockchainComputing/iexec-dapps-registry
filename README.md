## DAISEE
The DApp is about designing, developping and deploying an app for for both the energy flow allocation and energy billing within the context of self electricity consumption, based on a concrete experimental field.
This DApp development opportunity is partly the result of iExec and Urban Solar Energy meeting that validated a common interest in the topic.

### Ideal Proposal
The DAISEE DApp would be able:
* treat electricity consumption and production data and discriminate electricty flow allocation for which type of electricity is produced or consumed by who and when;
* embed learning algorithms for automation of electricity flows allocation and potential prediction;
* personalized and peer-to-peer electricity billing in the case of collective self-production and consumption of the electricity locally produced.

#### DAISEE, citizen research program
DAISEE is open-design and non-standard citizen research program aiming at producing knowledge while experimenting emerging IT technologies applied to energy transition on concrete experimentation fields.

DAISEE has the ambition to facilitate to contribution of the citizens to the electricity grid governance. It's about giving the capabilities to the grid stakeholers (from consumers to producers, passing by pro-sumers of grid operator) to embed shared governance into algorithms in which rules has been collectively defined. It thus necessitate to work at 3 levels:
* the data infrastructure level
* the physical infrastructure level
* the governance infrastructure level

The link between all those level are not only the facilitators but also the interface for data management, making sense fo the data and peer-to-peer billing. This is the Citizen-Governed Data Platform.

#### Citizen-Governed Data Platform
Experimentation are on their ways, specifically both in Prats de Mollo (little village in the south of France experimenting the shared governance of the grid in accordance with the development of locally and autonomously produced and consumed energy) or in Villeurbanne with Urban Solar Energy (experimenting collective self-production and consumption from solar energy).

Research and experimentation in both cases are focusing on the development of the necessary technological bricks for a Citizen-Governed Data Platform to take shape. The idea with the Citizen-Governed Data Platform, applied to the energy sector if to collectively govern the electricity grid, in the context of autonomous production and consumption and local energy balance necessity.
In practice, the Citizen-Governed Data Platform for energy grid governance is a tool for data collection, storage and management (through autonomous algorithms) - in other words for addressing the energy data life-cycle - while assuring transparency, security, anonymity and interoperability for the stakeholders. This thus not only ring technical challenges but also legal and political stakes.

For the moment verious contributive residencies as well as bootcamps have help prototyping as well as produce and diffuse knowledge.

#### Billing data calculation
In the context of the Urban Solar Energy project, that is supporting the organization of a technical, economical and political consortium in Lyon-Villeurbanne for the development of collective self production and consumption of solar electricity, working with iExec on the development of the core interface for data management and accessibility (as a consequence for billing) makes perfectly sense.

In practice, solar PV panels are situated on the roof of a tertiary building in the Villeurbanne area (Urban Solar Energy being the owner of the building and the PV panels as an energy provider). The produced electricity from those solar PV panels will flow in the grid for local consumption: first of the users of the building and secondly in the nearby locality for local consumption. Urban Solar Energy is thus positionned as an energy provider and responsible for local energy balance.

In order to treat the massive energy data flow for both local grid management and balance and billing, computer power for running complex algorithms and treat data is needed. Moreover, data visualization is on crucial interest for consumers and producers to follow their need and usage. The Citizen-Governed Data Platform is about experimenting the full distribution of data management in a context of autonomization and automation of the data treatment (storage, algorithms...). Thus is makes sense to test and experiment distributed cloud computing in our case.

Within the massive amount of energy data flowing to the grid operator, some are not relevant and algorithmic treatment is necessary to make sense of the data and autonomating the fair allocation for energy billing. In this context, the aim is also to involve the citizen in the governance of the platform, meaning that it has to be transparent, secure and anonymous.

Energy billing comes in 3 layers:
* standardization of the data
* billing calculation and dynamic allocation
* data access and governance

#### Data conformity checking and formatting
Data conformity consist in making sure that data that are sent ot the energy provider as well as that data sent to the grid operator and usefull and consistent not only for grid operation but also and mostly for billing purpose.
In fact, today the energy provider do not have direct access to consumption or production data; they need to ask for that data: first to the consumer, secondly to the distribution grid operator. He thus depends upon both parties, knowing that if there is a difference between what the consumer declare (or the remote or on site observations say), the grid operator set the right measure and the provider must adjust to this arbitrage.
In practice, energy data (both the format and the data itself) sent to the providers usually does not fit its needs for billing or local energy management (balance between production and consumption). It thus requires post-treatment, that grows while energy flows are growing.

Checking of the consistancy of the energy data and their format will be running in the iExec Cloud through rules (autonomous algorithms) that will be implemented as a smartcontract.
The process may look like!
* 1 - Energy data are pre-treated with a data management tool that collect, store and plan to treatment of the data received from the grid operator.
* 2 - Smart-contract is the called to treat the data : format and data checking consistant with the energy provider needs. If it returns an error then it is about spotting the issue (corrupt data, non-standard data, useless data...) to decide what kind of treatment to apply. If result of the pre-treatment is correct this data is stored in a generic format and can be used for visualization.

Aside of the technical challenge. The legal issue of the treatment of the data will be adressed so as for the system to be compliant with GDPR. Moreover, privacy consideration will be adressed not only through the legal prism but also by design.

Last of all, this is also about the enforcement of automated and potentially "smart" algorithms. In other words, given the possibiliy for a learning algortihms run by through the smart-contract to be autonomous in decision making (providing that rules have been implemented through a share governance process), what is the legal right concerning this algorithm ?

#### Data access and arbitration
**Data Access**
There are 3 layers of acces:
* access for the energy consumer/producer
* access for the energy provider
* access for the grid operator

The aim is not to have to bother with specific access right to the data given that all three protagonists are stakeholders, and thus has the right to access the data they own or for which they've got the usage right to use (for billing or grid operation for instance). That is why we need agnostic infrastructure for data governance and management, that can be provided through blockchain technolgy.
Moreover, if specific rights are required, rights automation can be embeded within the smartcontract that can automatically deal with specific rights providing that identities of the user is consistent.

**Data Visualization**
The DApp will provide an interface for data visualization and energy management.
The aim would be to embed the governance process and rules administration with the DApp interface.

**Arbitration**
Arbitration is both a governance issue and a legal issue.
On the governance part, transparency allows to assure that rules are respected and, in case of conflict, to enforce the contract bounding the stakeholders together.
On the legal part, transparency, ledger and proof of identity helps resolving conflicting energy measures between the energy provider and the grid operator.

### Roadmap
This participation to the DApp challenge is part of the DAISEE experimentation and research program, in the case of application to two fields exepriment (Prats de Mollo and Urban Solar Energy).
The first application and test will be held in the case of the Urban Solar Energy project.

Q2 2018 :
* Hardware deployment for data collection and design and prototype of data infrastructure (Smart contract and DApp)

Q3 2018 :
* Data collection and experimentation of the prototype while investigatin the legal compliance

Q4 2018 :
* DApp interface for energy management and billing compliant with legal data framework.

### Diagram
**Component diagram**

![](https://github.com/DAISEE/iexec-dapp-samples/blob/init/diagrams/component_diagram.png?raw=true)

**Sequential diagram**

![](https://github.com/DAISEE/iexec-dapp-samples/blob/init/diagrams/sequential_diagram.png?raw=true)
