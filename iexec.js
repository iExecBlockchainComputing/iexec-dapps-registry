module.exports = {
  name: 'FindFace',
  app: {
    type: 'DOCKER',
    envvars: 'XWDOCKERIMAGE=ugodock/find-face',
  },
  work: {
    cmdline: 'cli arguments',
  }
};
