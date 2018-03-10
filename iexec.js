module.exports = {
  name: 'Gimp',
  app: {
    type: 'DOCKER',
    envvars: 'XWDOCKERIMAGE=renyufu/lame',
  },
  work: {
    cmdline: `--help`,
    dirinuri: 'https://github.com/iExecBlockchainComputing/iexec-dapp-samples/raw/gimp/logo.png',
  }
};
