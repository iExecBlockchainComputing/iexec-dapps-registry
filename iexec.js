module.exports = {
  name: 'VanityGen',
  app: {
    type: 'DOCKER',
    envvars: 'XWDOCKERIMAGE=iexechub/vanitygen',
  },
  work: {
    cmdline: '1iEx'
  }
};
