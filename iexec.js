module.exports = {
  name: 'Scilab',
  app: {
    type: 'DOCKER',
    envvars: 'XWDOCKERIMAGE=',
  },
  work: {
    cmdline: '-i /iexec/small.mp4 /iexec/small.avi',
    dirinuri: 'http://techslides.com/demos/sample-videos/small.mp4',
  },
};
