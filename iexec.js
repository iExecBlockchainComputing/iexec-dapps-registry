module.exports = {
  name: 'OyenteTest',
  app: {
    type: 'DOCKER',
    envvars: 'XWDOCKERIMAGE=iexechub/iexec-dapp-oyente',
  },
  work: {
    cmdline: 'bash /oyente/customScript.sh',
    dirinuri:'https://github.com/iExecBlockchainComputing/iexec-dapps-registry/blob/oyenteTest/contracts.zip?raw=true',
  }
};
