module.exports = {
  name: 'RWordcloud',
  app: {
    type: 'DOCKER',
    envvars: 'XWDOCKERIMAGE=iexechub/r-wordcloud',
  },
  work: {
      cmdline: 'Rscript iExecWordcloud.R',
      dirinuri: 'https://github.com/iExecBlockchainComputing/iexec-dapp-samples/raw/r-wordcloud/apps/iExecWordcloudInputs.zip',
  }
};
