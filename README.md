# Time clock
## Description

Badge-in, badge-out, get pay in eth and switch on et twitch off the office alarm with iExec.


## Dapp params
```
module.exports = {
  name: 'TimeClock',
  data: {
    type: 'BINARY',
    cpu: 'AMD64',
    os: 'LINUX',
  },
  work: {
    cmdline: '--activate',
  }
};
```

## [Examples](./examples)

## Tests


```
iexec init timeclock
cd iexec-timeclock
```
make sure the development network host in truffle.js is well configured ('localhost' and not 'http://localhost:8545'):
```
module.exports = {
  networks: {
    development: {
      host: 'localhost',
      port: 8545,
      network_id: '*', // Match any network id,
      constructorArgs: [LOCAL_ORACLE_ADDRESS],
      server: 'https://localhost:443'
    },
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
You must see somting like this atb the end of the log

```
Listening on localhost:8545
```
Your testrpc network simultaor is ready, you can launch your truffle test with :
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
Your local geth network  is ready, you can launch your truffle test with :
```
iexec truffle test
```
