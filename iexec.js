module.exports = {
  name: 'Octave',
  app: {
    type: 'DOCKER',
    envvars: 'XWDOCKERIMAGE=openmicroscopy/octave',
  },
  work: {
    cmdline: "--version",
  }
};
