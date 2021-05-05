# iexec-face-swap

Face Swap

## Prerequisites

iExec installation and good iExec infrastructure understanding


## Build

```
./build
```

## Run the test locally

```
./run
```

## Dapp addresses

```
https://explorer.iex.ec/bellecour/app/0xc26C15A294168b743ef1eF9699da6b3aA5b3DEe4
```

## App run script on Bellecour

```
#!/bin/sh
iexec app run 0xc26C15A294168b743ef1eF9699da6b3aA5b3DEe4 \
      --chain bellecour \
      --wallet-file your wallet \
      --params {\"iexec_input_files\":[\"https://github.com/iExecBlockchainComputing/dapp-FaceSwap/raw/master/images/test4.jpg\",\"https://github.com/iExecBlockchainComputing/dapp-FaceSwap/raw/master/images/test6.jpg\"]} \
      --skip-request-check \
      --watch


```
