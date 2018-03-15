module.exports = {
  name: 'ImageMagick',
  app: {
    type: 'DOCKER',
    envvars: 'XWDOCKERIMAGE=v4tech/imagemagick',
  },
  work: {
    cmdline: 'convert logo.png logo.jpg',
    dirinuri: 'https://github.com/iExecBlockchainComputing/iexec-dapp-samples/raw/imagemagick/logo.png',
  }
};
