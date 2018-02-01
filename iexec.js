module.exports = {
  name: 'R',
  app: {
    type: 'DOCKER',
    envvars: 'XWDOCKERIMAGE=r-base',
  },
  work: {
      cmdline: 'Rscript HelloWorld.R',
      dirinuri: 'https://github.com/iExecBlockchainComputing/iexec-dapp-samples/raw/r-project/apps/HelloWorld.R',
  }
};
