module.exports = {
  name: 'Oyente',
  app: {
    type: 'DOCKER',
    envvars: 'XWDOCKERIMAGE=iexechub/iexec-dapp-oyente',
  },
  work: {
    cmdline: 'bash /oyente/customScript.sh',
    dirinuri:'https://github.com/iExecBlockchainComputing/iexec-dapps-registry/blob/oyente/apps/contracts.zip?raw=true',
  }
};
