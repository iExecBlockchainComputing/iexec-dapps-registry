module.exports = {
  name: 'DockerWithScript',
  app: {
    type: 'DOCKER',
    envvars: 'XWDOCKERIMAGE=iexechub/docker-with-script',
  },
  work: {
    cmdline: '/bin/bash customeScript.sh ShowMethisText',
    dirinuri:'https://github.com/iExecBlockchainComputing/iexec-dapp-samples/raw/docker-with-script/apps/text.txt',
  }
};
