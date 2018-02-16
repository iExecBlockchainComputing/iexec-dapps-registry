module.exports = {
  name: 'MyContract',
  app: {
    type: 'DOCKER',
    envvars: 'XWDOCKERIMAGE=docker-image-name',
  },
  work: {
    cmdline: 'cli arguments',
  }
};
