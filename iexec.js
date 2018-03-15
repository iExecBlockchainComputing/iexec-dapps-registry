module.exports = {
  name: 'Gimp',
  app: {
    type: 'DOCKER',
    envvars: 'XWDOCKERIMAGE=jamesnetherton/gimp',
  },
  work: {
    cmdline: "--version",
    dirinuri: 'https://github.com/iExecBlockchainComputing/iexec-dapp-samples/raw/gimp/apps/make-logo.scm',
  }
};
