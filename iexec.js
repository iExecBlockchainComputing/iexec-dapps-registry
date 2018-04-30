module.exports = {
  name: 'Julia',
  app: {
    type: 'DOCKER',
    envvars: 'XWDOCKERIMAGE=julia',
  },
  work: {
    cmdline: 'julia iexec/example.jl',
    dirinuri:'https://raw.githubusercontent.com/iExecBlockchainComputing/iexec-dapps-registry/julia/apps/example.jl',
  }
};
