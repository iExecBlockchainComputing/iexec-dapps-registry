module.exports = {
  name: 'RWordcloud',
  app: {
    type: 'DOCKER',
    envvars: 'XWDOCKERIMAGE=iexechub/r-wordcloud',
  },
  work: {
      cmdline: 'Rscript HelloWorld.R',
      dirinuri: 'https://github.com/iExecBlockchainComputing/iexec-dapp-samples/raw/r-project/apps/HelloWorld.R',
  }
};
