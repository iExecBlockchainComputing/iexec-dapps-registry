module.exports = {
  name: 'RWordcloud',
  app: {
    type: 'DOCKER',
    envvars: 'XWDOCKERIMAGE=iexechub/r-wordcloud',
  },
  work: {
      cmdline: 'Rscript iExecWordcloud.R',
      dirinuri: 'zip link TBD',
  }
};