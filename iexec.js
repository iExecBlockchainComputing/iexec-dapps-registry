module.exports = {
  name: 'Octave',
  app: {
    type: 'DOCKER',
    envvars: 'XWDOCKERIMAGE=openmicroscopy/octave-docker',
  },
  work: {
    cmdline: "--version",
  }
};
