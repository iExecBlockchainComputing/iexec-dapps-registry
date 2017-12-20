module.exports = {
    name: 'Ffmpeg',
    data: {
        type: 'BINARY',
        cpu: 'AMD64',
        os: 'LINUX',
    },
    work: {
        cmdline:'-i small.mp4 small.avi',
        dirinuri:'http://techslides.com/demos/sample-videos/small.mp4',
    }
};
