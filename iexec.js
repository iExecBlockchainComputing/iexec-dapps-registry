module.exports = {
  name: 'OpenFOAM',
  app: {
    type: 'DOCKER',
    envvars: 'XWDOCKERIMAGE=openmicroscopy/octave-docker',
  },
  work: {
    cmdline: "--version",
  }
};
