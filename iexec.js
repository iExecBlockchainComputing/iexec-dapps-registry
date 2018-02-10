module.exports = {
  name: 'CliffordAttractors',
  app: {
    type: 'DOCKER',
    envvars: 'XWDOCKERIMAGE=iexechub/r-clifford-attractors',
  },
  work: {
      cmdline: 'Rscript CliffordAttractors.R -1.24458046630025 -1.25191834103316 -1.81590817030519 -1.90866735205054',
      dirinuri: 'https://github.com/iExecBlockchainComputing/iexec-dapp-samples/raw/r-clifford-attractors/apps/CliffordAttractors.R',
  }
};