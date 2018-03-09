module.exports = {
  name: 'Gimp',
  app: {
    type: 'DOCKER',
    envvars: 'XWDOCKERIMAGE=jamesnetherton/gimp',
  },
  work: {
    cmdline: ` -i -b "$(cat make-logo.scm)(make-logo '(0 0 0) 200 \"iExec\") -b '(gimp-quit 0)'`,
    dirinuri: 'https://github.com/iExecBlockchainComputing/iexec-dapp-samples/raw/gimp/apps/make-logo.scm',
  }
};
