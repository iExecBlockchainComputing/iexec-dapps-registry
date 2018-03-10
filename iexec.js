module.exports = {
  name: 'Gimp',
  app: {
    type: 'DOCKER',
    envvars: 'XWDOCKERIMAGE=v4tech/imagemagick',
  },
  work: {
    cmdline: `convert logo.png logo.jpg`,
    dirinuri: 'https://github.com/iExecBlockchainComputing/iexec-dapp-samples/raw/gimp/logo.png',
  }
};
