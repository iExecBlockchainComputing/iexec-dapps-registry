module.exports = {
  name: 'OpenFOAM',
  app: {
    type: 'DOCKER',
    envvars: 'XWDOCKERIMAGE=openfoam/openfoam5-paraview54',
  },
  work: {
    cmdline: "--version",
  }
};
