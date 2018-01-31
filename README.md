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
# Hector on IExec - Global Climate Module

## Description

The idea is to decentralize climate models and let everyone participate with unused computing resources to run the models.
With the recent advent of open-source climate models that are highly modular everyone can contribute to climate research with code and with the emerging blockchain technology we can help to let people contribute with their hardware as well.  

HECTOR - https://github.com/JGCRI/hector

Hector, an open-source, object-oriented, reduced-form global climate carbon-cycle model, is written in C++. This model runs essentially instantaneously while still representing the most critical global-scale earth system processes. Hector has a three-part main carbon cycle: a one-pool atmosphere, land, and ocean. The model’s terrestrial carbon cycle includes primary production and respiration fluxes, accommodating arbitrary geographic divisions into, e.g., ecological biomes or political units. Hector actively solves the inorganic carbon system in the surface ocean, directly calculating air– sea fluxes of carbon and ocean pH. Hector reproduces the global historical trends of atmospheric [CO2], radiative forcing, and surface temperatures. The model simulates all four Representative Concentration Pathways (RCPs) with equivalent rates of change of key variables over time compared to current observations, MAGICC, and models from CMIP5 (Hartin et al., 2015). Hector’s flexibility, open-source nature, and modular design facilitates a broad range of research in various areas.

Introduction paper: https://www.geosci-model-dev.net/8/939/2015/gmd-8-939-2015.pdf

My personal background is software development (+20 years experience) as well as climate research (3 years) and teaching. My goal is to raise awareness for the current climate crisis and help people contribute. 
My vision is that science regains trust from the public by being completely open and transparent. Currently especially in climate research this is not the case and only very few models are open-source models. The hereby presented model HECTOR is one of those new approaches.

## Components

Main components of HECTOR model
http://jgcri.github.io/gcam-doc/hector.html

Inputs: 
Ini-file : a general setup file located in input directory ( links to emissions directory )
Start app with e.g. : "hector hector_rcp85.ini"

Outputs:
At every time step Hector calculates and outputs key climate variables for Atmosphere, Land and Ocean
e.g. CO2, CH4 etc…


## Open Tasks - Roadmap

- add HECTOR executable for x64 environments (MAC-OS build included) and integrate into sampled app pull request
- bundle output data files for iexec result output

-> HECTOR running on IExec (X64 environment) - timeline FEB/MARCH 2018

- advertise 1st climate model on blockchain ( similar to SETI project https://github.com/SETI one of the 1st public scientific HPC projects )
- develop a monetization model with RLC for 
    - a) business cases ( HPC on blockchain - similar to other IExec projects )
    - b) incentivize „normal“ interested users ( public ) to spend tokens and help promote climate models and open research


## Dapp params

module.exports = {
    name: 'HECTOR',
    data: {
      type: 'BINARY',
      cpu: 'AMD64',
      os: 'MACOS',
    },
    work: { // HERE: add input files
      cmdline: '10',
    }
}

## [Examples] - coming soon
