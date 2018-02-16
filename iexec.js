module.exports = {
    name: 'Ffmpeg',
    app: {
      type: 'DOCKER',
      envvars: 'XWDOCKERIMAGE=jrottenberg/ffmpeg:scratch',
    },
    work: {
        cmdline:'-i small.mp4 small.avi',
        dirinuri:'http://techslides.com/demos/sample-videos/small.mp4',
    }
};
