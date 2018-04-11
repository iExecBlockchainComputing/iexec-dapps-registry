module.exports = {
name:'Stockpredictor',
  app: {
    type: 'DOCKER',
    envvars: 'XWDOCKERIMAGE=reckey/iexecsgx_stockpredictor:demo_ibm',
    neededpackages: 'sgx',
  },
  work: {
    cmdline: '',
  }
};
