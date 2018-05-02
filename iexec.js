module.exports = {
  name: 'Scipy',
  app: {
    type: 'DOCKER',
    envvars: 'XWDOCKERIMAGE=ugodock/scinumpy',
  },
  work: {
    cmdline: 'iexec/example.py',
    dirinuri:'https://raw.githubusercontent.com/iExecBlockchainComputing/iexec-dapps-registry/scipy/apps/example.py',
  }
};
