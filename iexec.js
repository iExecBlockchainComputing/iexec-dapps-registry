module.exports = {
  name: 'FacialRecognition',
  app: {
    type: 'DOCKER',
    envvars: 'XWDOCKERIMAGE=ericro/face-recognition',
  },
  work: {
    cmdline: '',
  }
};
