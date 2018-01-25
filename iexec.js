module.exports = {
  name: 'Blender',
  app: {
    type: 'DOCKER',
    envvars: 'XWDOCKERIMAGE=ikester/blender',
  },
  work: {
    cmdline: '/host/buggy2.1.blend -o /host/frame_### -f 1',
    dirinuri:'https://github.com/sulliwane/files/raw/master/buggy2.1.blend',
  }
};
