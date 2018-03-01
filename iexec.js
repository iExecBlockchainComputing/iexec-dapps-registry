module.exports = {
  name: 'RWordcloud',
  app: {
    type: 'DOCKER',
    envvars: 'XWDOCKERIMAGE=iexechub/r-wordcloud',
  },
  work: {
      cmdline: 'Rscript iExecWordcloud.R https://iex.ec/app/uploads/2017/04/iExec-WPv2.0-English.pdf',
      dirinuri: 'https://github.com/iExecBlockchainComputing/iexec-dapp-samples/raw/r-wordcloud/apps/iExecWordcloud.R',
  }
};
