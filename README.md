# ffmpeg

## Description

You can see a full description of the ffmpeg dapp on [iExec Dev Letter #11](https://medium.com/iex-ec/iexec-dev-letter-11-daad1c8b9b75).


## Dapp params


```
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
```
## [Examples](./examples)
