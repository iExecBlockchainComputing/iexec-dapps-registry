module.exports = {
  name: 'Gimp',
  app: {
    type: 'DOCKER',
    envvars: 'XWDOCKERIMAGE=bigpapoo/sox',
  },
  work: {
    cmdline: `mysox --help`,
  }
};
