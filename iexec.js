module.exports = {
  name: 'Gimp',
  app: {
    type: 'DOCKER',
    envvars: 'XWDOCKERIMAGE=bigpapoo/sox',
  },
  work: {
    cmdline: `mysox sound.mp3 -r 8000 -c2 sound.wav`,
    dirinuri: 'https://github.com/iExecBlockchainComputing/iexec-dapp-samples/raw/gimp/logo.png',
  }
};
