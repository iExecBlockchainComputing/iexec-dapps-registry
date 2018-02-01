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

## Roadmap
EthScholar Goal
The goal of the iExec grant is to provide enough runway to allow the SetOcean team to allocate two full-time (40 hr / week) contractors to build EthScholar to the point that it’s self-funded. We do not plan on scaling or selling this as a business - this is merely an idea we’d be privileged to work on simply covering our expenses. 

To that end, this means that by the end of month nine of kickoff, EthScholar must bring in enough revenue to cover our staffing & operational costs. Let’s approximate this monthly as two full-time employees (2 * $3.25K)  & one part-time contractor ($1.5K), plus splitting our current office lease ($1K), plus a couple grand of operational expenses such as hosting, utilities & equipment ($1K). This roughly equals $10K. 

Therefore the goal of the iExec grant is to build & scale EthScholar, a scholarship charity dapp, to the point that monthly revenues are approximately ~$12.5K ($2.5K buffer). Since we’re essentially not looking to increase monthly margins, it might make sense to scale this number only as the team scales. Once our monthly burn is reached, the rest of the “donor fee” is added to the EthScholar & Scholarship bonus pool fund.

We propose an initial donation % fee of 10% which means that in order to hit our goal of self-sustaining dapp we’d need monthly donations of approximately $100K. We will decrease this team % as demand increases but for this roadmap the goal is to reach a self-sustaining model first without seeking additional financing. The goal is to hit this monthly donation figure of $100K in the month of May. The $100K in monthly donations will be a direct function of (donors) * (avg. donation). We propose the timeline listed below:

  - Feb. 1st - Mar. 31st	 Design, Engineer, Test & Deploy on Testnet Alpha (v0.0 - v0.9)
  - Apr 1st - Apr 30th	EthScholarhips live & committed every 1000 Eth blocks  (~2 weeks). Beta (v1.0 - 1.9)
  - May 1st - May 31st	Marketable MVP & Product/Market Fit  MVP (v2.0 - 2.9)
  - June 1st - Sept 30th	Multi-lingual support, video applications, & donor-to-scholar messaging (3.0 - 3.9)
  - Oct 1st - Dec 31st	Auto-generated tax donor Form 8283s for donor’s benefit. (4.0 - 4.9)
  - Alpha (February 1st - March 31st)

Two Months to Design, Engineer, Test & Deploy on Testnet

The goal of this phase to successfully deploy (on a testnet) the EthScholar dapp that passes all user-tests & Truffletests. 

The resources allocated for this phase will be one full-time blockchain engineer/product designer ($3250/M) & one part-time full-stack engineer/PM ($1500/M). In addition to shared office space, operations & shared technical resources ($500/M). 

$5.25K / Month * 2 ~ $10.5K for Alpha Phase

Beta (April 16th - May 30th)
One Month Polishing & Deploying on Ethereum Network 

The goal of this phase is to successfully deploy the EthScholar origin block with an additional block committed with some ether donations released to at least five applications. The main EthScholar smart contract is live. EthScholarhips live & committed every 1000 Eth blocks

The resources allocated for this phase will be one part-time blockchain engineer/product designer ($1625/M) & one part-time marketer/customer service rep ($1500/M). In addition to shared office space, operations & shared technical resources ($500/M). 

$3.625K / Month * 1 ~ $3.625K for MVP Phase

3 Months Alpha & Beta MVP						~Total   $14,125


The goal is hit a breakeven total donation fee of $10K (Two full-time employees @ $3.5/M + One part-time @ $1.5/M + Operations & Marketing @ $1K + a $1K buffer). This donation fee is ideally as low as possible, however, in the beginning, it follows that in order to guarantee continued operations, we’ll need to err on the side of caution (possibly going up to 10%). Once the team’s breakeven number is met, the rest of EthScholar fees from incoming donations for the current round are added to the EthScholar bonus pool as well as the corresponding Scholarship contract bonus pool. 

For example, let’s say May, our first full, unassisted month in operations, goes way better than expected with $200K in total monthly donations. Since we were reasonably uncertain about covering our breakeven, we set a relatively high donation fee of 10%. With a monthly breakeven goal of 10K, this required a total monthly donations of only $100K. Does it make sense to only charge a donation fee to those who donate early? No. So what happens to the rest of the donation fees stemming from the additional $200K? Since the EthScholar team no longer needs those funds to operate, the extra $10K ($200K in donations * 10% donation fee - $10K) in donation fees are split in half & allocated to the current EthScholar contract bonus pool as well as their respective Scholarship contracts. $5K goes to the EthScholar contract & is awarded to the one of the five Scholarships that “wins” the current round; the second $5K is distributed evenly among all five Scholarships. 


![alt tag](https://i.imgur.com/aPwGPgK.png)

## Frontend Preview
![alt tag](https://i.imgur.com/PRP8Eiv.png)
![alt tag](https://i.imgur.com/CIQlGxp.png)


## Dapp params
An example of a iexec.js conf
## [Examples](./examples)
A link to all iexec.js conf examples for the dapp.
