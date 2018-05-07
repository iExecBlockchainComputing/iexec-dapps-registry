module.exports = {
  name: 'FindFace',
  app: {
    type: 'DOCKER',
    envvars: 'XWDOCKERIMAGE=ugodock/find-face',
  },
  work: {
    cmdline: 'iexec/team.jpg',
    dirinuri:'https://raw.githubusercontent.com/iExecBlockchainComputing/iexec-dapps-registry/find-face/apps/team.jpg',
  }
};
