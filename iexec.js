module.exports = {
  name: 'Gmsh',
  app: {
    type: 'DOCKER',
    envvars: 'XWDOCKERIMAGE=renumics/gmsh',
  },
  work: {
    cmdline: 'gmsh -version',
  },
};
