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

Jesus Najera - Product designer & learning blockchain engineer: https://github.com/setzeus
Oscar Lafarga - Product manager, lead tech, & full-stack dev: https://github.com/otech47
Balin Sinnott - Swift & kotlin senior engineer: https://github.com/bsin1
Bernardo Garciarivas - Senior frontend-engineer: https://github.com/brgarciarivas
Jordan Bruner - Web backend & API engineer: https://github.com/jordanbruner13

## Detailed Overview
The standard smart contract in EthScholar dapp is the Scholarship contract. But our dapp exists as a chain of less common EthScholar contracts. An EthScholar contract, or block, in simple terms, is a block of x batched Scholarship contracts. At the beginning, this x is represented by the initial themes within EthScholar, which is a total of five referenced in the previous paragraph but is likely to change. 

A Scholarship contract, on the other hand, is quite in-depth. A scholarship contract has three significantly different states: upcoming, live & historical. An upcoming Scholarship contract accepts donations from donors who are particularly interested in crafting the conditions for future applicants such as application essay length; at this point in time scholars cannot submit applications. A live Scholarship is open for scholars to submit applications & is going to be a part of the next EthScholar block committed to our dapp; additionally, a live Scholarship is open to donations from donors at a lower donor fee than an upcoming Scholarship. Lastly, after a Scholarship contract is finally committed within an EthScholar contract to our dapp’s blockchain, its state is changed to historical. A historical Scholarship contract is a contract that has released all donations & accompanying bonus pool to applicants. 

Additionally, both the EthScholar contract & each individual Scholarship contract have a built-in bonus pool fund. Once the team’s breakeven donation revenue is met, all additional donations for the current upcoming and/or live state Scholarship contracts are programmatically distributed to both the EthScholar contract & the underlying Scholarship contracts. 50% of additional donations are locked into the EthScholar contract; 50% of additional donations are distributed equally & locked into the underlying Scholarship contracts. The EthScholar bonus pool fund, once the block is committed, is distributed to all applicants in the most popular underlying Scholarship contract (by theme); the Scholarship contract bonus pools are distributed to the winning applications in each respective theme.


## Dapp params
An example of a iexec.js conf
## [Examples](./examples)
A link to all iexec.js conf examples for the dapp.
