module.exports = {
  name: 'Sox',
  app: {
    type: 'DOCKER',
    envvars: 'XWDOCKERIMAGE=bigpapoo/sox',
  },
  work: {
    cmdline: `mysox --help`,
  }
};
