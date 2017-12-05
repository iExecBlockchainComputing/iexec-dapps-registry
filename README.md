# iexec dapps samples - ffmpeg

```bash
iexec init ffmpeg
cd iexec-ffmpeg
[ iexec wallet getETH, iexec wallet getRLC, iexec account allow 5, ...]
iexec deploy
iexec submit "{ \"cmdline\": \"-i demos/sample-videos/small.mp4 small.avi\", \"dirinuri\": \"http://techslides.com/demos/sample-videos/small.mp4\" }"
iexec result 0x5ff9ez6r7t8e4t7hh5tmy0tx0hash --save

```
