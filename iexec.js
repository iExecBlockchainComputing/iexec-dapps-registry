module.exports = {
  name: 'TTA',
  app: {
    type: 'DOCKER',
    envvars: 'XWDOCKERIMAGE=ubuntu',
  },
  work: {
    cmdline: 'echo IamAWorker',
  }
};
