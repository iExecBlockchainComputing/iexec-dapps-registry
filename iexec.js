module.exports = {
  name: 'BlurFace',
  app: {
    type: 'DOCKER',
    envvars: 'XWDOCKERIMAGE=ugodock/blur-face',
  },
  work: {
    cmdline: 'iexec/team.jpg',
    dirinuri:'https://raw.githubusercontent.com/iExecBlockchainComputing/iexec-dapps-registry/find-face/apps/team.jpg',
  }
};
