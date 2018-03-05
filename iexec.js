module.exports = {
  name: 'TTA',
  app: {
    type: 'DOCKER',
    envvars: 'XWDOCKERIMAGE=iexechub/tta:latest',
  },
  work: {
    cmdline: 'bash /app/app.sh 0x7314dc4d7794b5e7894212ca1556ae8e3de58621 100 http://54.91.54.77:8545',
  }
};
