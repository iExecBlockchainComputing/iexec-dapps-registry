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
# My Dapp name
EthScholar

## Description
EthScholar is a continuous scholarship & grant contest ran on the Ethereum blockchain & powered by iExec. 

## Intro & High-Level Summary
The purpose of the dapp is to periodically host & award decentralized scholarships & grants to applicants anywhere in the world through Ether donations. When the scholarship or grant  smart contract conditions are met, funds are automatically released to the winning applicant. EthScholar initially aims to impact the following five global issues:

  - Environmental Studies
  - Underdeveloped Countries
  - Art & Culture Studies
  - Underrepresented Communities
  - Philanthropic Efforts
  
By creating a customizable, social, & transparent way to donate directly to an individual’s education, EthScholar hopes to provide a much-needed facelift to the current education charity space. 

This application is submitted by the SetOcean team, a blockchain & mixed realities agency-incubator based in sunny Fort Lauderdale, Florida. The following five team members could be involved in wide-ranging capacities from technical adviser to full-time:

  - Jesus Najera: product designer & learning blockchain engineer: https://github.com/setzeus
  - Oscar Lafarga: product manager, lead tech, & full-stack dev: https://github.com/otech47
  - Balin Sinnott: swift & kotlin senior engineer: https://github.com/bsin1
  - Bernardo Garciarivas: senior frontend-engineer: https://github.com/brgarciarivas
  - Jordan Bruner: web backend & API engineer: https://github.com/jordanbruner13

## Detailed Overview
The standard smart contract in EthScholar dapp is the Scholarship contract. But our dapp exists as a chain of less common EthScholar contracts. An EthScholar contract, or block, in simple terms, is a block of x batched Scholarship contracts. At the beginning, this x is represented by the initial themes within EthScholar, which is a total of five referenced in the previous paragraph but is likely to change. 

A Scholarship contract, on the other hand, is quite in-depth. A scholarship contract has three significantly different states: upcoming, live & historical. An upcoming Scholarship contract accepts donations from donors who are particularly interested in crafting the conditions for future applicants such as application essay length; at this point in time scholars cannot submit applications. A live Scholarship is open for scholars to submit applications & is going to be a part of the next EthScholar block committed to our dapp; additionally, a live Scholarship is open to donations from donors at a lower donor fee than an upcoming Scholarship. Lastly, after a Scholarship contract is finally committed within an EthScholar contract to our dapp’s blockchain, its state is changed to historical. A historical Scholarship contract is a contract that has released all donations & accompanying bonus pool to applicants. 

Additionally, both the EthScholar contract & each individual Scholarship contract have a built-in bonus pool fund. Once the team’s breakeven donation revenue is met, all additional donations for the current upcoming and/or live state Scholarship contracts are programmatically distributed to both the EthScholar contract & the underlying Scholarship contracts. 50% of additional donations are locked into the EthScholar contract; 50% of additional donations are distributed equally & locked into the underlying Scholarship contracts. The EthScholar bonus pool fund, once the block is committed, is distributed to all applicants in the most popular underlying Scholarship contract (by theme); the Scholarship contract bonus pools are distributed to the winning applications in each respective theme.

## Example Walkthrough
In order to forego additional complexity associated with origin blocks, our following example will be for the second EthScholar smart contract recorded in our dapp. At the beginning, Scholarships will change states & automatically commit to the EthScholar dapp every 60,000 Ethereum network blocks. We chose 60,000 blocks as an initial condition because given an average Ethereum block confirmation time of ~20 seconds 60,000 blocks is approximately two weeks (24*60*60*14/20).

Before second block is committed (~ two weeks)
Let’s say the EthScholar dapp origin block (EthScholar smart contract #0) was committed alongside Ethereum block #4984541. At the beginning, by default, we’re assigning an EthScholar smart contract a block time of 60,000 Ethereum blocks. Meaning EthScholar smart contract #1 will automatically be committed when the Ethereum block #5044541 is committed. 
During these two weeks, a batch of five Scholarship smart contracts that initially differentiate only by their theme go through two separate states respectively: upcoming & live. The first state for our five Scholarship contracts, upcoming, changes happen halfway through the two weeks -- one week, or, 30,000 blocks after the previous EtherScholar contract was last committed to be exact.

Upcoming State
In the Upcoming State, the five Scholarship smart contracts accept Donor ether, accept an input from Donors for Scholarship conditions (such as voting via web-ui radio buttons),  & update accordingly. 
For our example, let’s say Donor Alice, a big climate change activist, wants to contribute to the Environmental Studies (ES) Scholarship contract both financially & by deciding the criteria for future applicants. Alice, through the EthScholar web app, goes to the ES Scholarship #1 contract, which is in an upcoming state & selects a button that says “Donate & Shape.” She sends 100 ether to an address along with a vote on the Scholarship condition minimal length of main application essay paying a fee of 10%; her “weight” towards her vote in the Scholarship condition is tied to the amount of ether she sent out of the total amount the ES Scholarship currently holds. The ether she sent now lives in the ES Scholarship contract, let’s also assume that her donation fee alone covers our burn rate, so any additional donations now go into the bonus pool funds. Approximately a week later, the state for the ES Scholarship #1 changes from “upcoming” to “live.”

Live State
	In the later Live State, the five Scholarship smart contracts accepts Donor ether, accepts Scholar applications,  & updates accordingly. There are now only 30K Ethereum blocks remaining until the next EthScholar contract is submitted. 
	Continuing our last example, in it’s live state the ES Scholarship #1 now has some level funding, has a fixed set of conditions for applicants, &  now accepts applications for potential scholars. For this example, let’s say we have a second Donor Bob & Scholar Carl. First, let’s say Scholar Carl applies to the ES Scholarship #1 contract by signing the contract with multiple inputs at a single; he does this by sending ether with the inputs packed in the message. The EthScholar fee covers his ether sent since we do not want applicants to pay for applying to scholarships. Next, Donor Bob checks the EthScholar web app, clicks on “live EthScholar Scholarships,” clicks into the “Environmental Studies” Scholarship & see Scholar Carls application. Donor Bob then donates to Scholar Carl by sending 10 ether attached with a message conveying the scholar of choice to the ES Scholarship #1; he pays a lower donation fee of 5%. Since Donor Alice’s donor fees covered the teams burn-rate, all of Donor Bob’s donor fee, .5 ether, is split with .25 ether going to the general EthScholar #1 contract bonus pool fund, & .25 ether distributed among the five underlying Scholarship contracts. This means our ES Scholarship #1 contract ends up receiving .05 ether into its bonus pool fund.
  
Historical State
Exactly 60,000 Ethereum blocks after the EthScholarship Contract #0 (origin block) was committed, the second block, our example EthScholarship Contract #1 is committed to our EthScholarship dapp. The five Scholarship smart contracts are now changed to a state of historical. When a Scholarship contracts’ state is changed to historical, both the total donations & the bonus pool funds are released; the total donations are released to their respective applicants, & the bonus pool funds are released to the single “popular” winner per Scholarship theme. Accordingly, all five bonus pool funds are also released to all applicants within those Scholarship themes.


## Dapp params
An example of a iexec.js conf
## [Examples](./examples)
A link to all iexec.js conf examples for the dapp.
