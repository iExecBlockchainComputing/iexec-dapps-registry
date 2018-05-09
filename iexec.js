module.exports = {
  name: 'BlurFace',
  app: {
    type: 'DOCKER',
    envvars: 'XWDOCKERIMAGE=ugodock/blur-face',
  },
  work: {
    cmdline: 'iexec/victor.mp4',
    dirinuri:'https://raw.githubusercontent.com/Ugo/iexec-dapps-registry/ugoblur/apps/victor.mp4',
  }
};
