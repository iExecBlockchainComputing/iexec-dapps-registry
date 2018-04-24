module.exports = {
  name: 'Gnuplot',
  app: {
    type: 'DOCKER',
    envvars: 'XWDOCKERIMAGE=wcurrie/gnuplot',
  },
  work: {
    cmdline: '/iexec/script.gp',
    dirinuri:'https://raw.githubusercontent.com/iExecBlockchainComputing/iexec-dapps-registry/gnuplot/apps/script.gp',
  }
};
