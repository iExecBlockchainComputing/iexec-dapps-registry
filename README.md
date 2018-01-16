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


## [Tests](./test/ffmpeg.js)

```
iexec init ffmpeg
cd iexec-ffmpeg
```

### testrpc Tests

Install the latest testrpc
```
npm install -g ethereumjs-testrpc

```
start your testrpc with
```
testrpc
```
You must see someting like this at the end of the log

```
Listening on localhost:8545
```
Your testrpc network simulator is ready, you can launch your truffle test with :
```
iexec truffle test
```

### Local geth node Tests

Pull the the following docker image
```
docker pull iexechub/iexec-geth-local
```
start container
```
docker run -d --name iexec-geth-local --entrypoint=./startupGeth.sh -p 8545:8545 iexechub/iexec-geth-local
```
wait to see in logs the word : LOCAL_GETH_WELL_INITIALIZED :
```
docker logs -f iexec-geth-local
```
Your local geth network is ready, you can launch your truffle test with :
```
iexec truffle test
```
