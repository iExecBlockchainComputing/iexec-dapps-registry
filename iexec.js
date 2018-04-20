module.exports = {
  name: 'Blender',
  app: {
    type: 'DOCKER',
    envvars: 'XWDOCKERIMAGE=ikester/blender',
  },
  work: {
    cmdline: 'iexec/iexec-rlc.blend -o iexec/iexec-rlc -f 1',
    dirinuri:'https://github.com/iExecBlockchainComputing/iexec-dapp-samples/raw/blender/apps/iexec-rlc.blend',
  }
};
