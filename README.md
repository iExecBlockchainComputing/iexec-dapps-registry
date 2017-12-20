# Dapp ffmpeg

## Description

You can see a full description of the ffmpeg dapp on [iExec Dev Letter #11](https://medium.com/iex-ec/iexec-dev-letter-11-daad1c8b9b75).


## How to create ffmpeg dapp step by step from 'iexec init'

The ffmpeg dapp creation is explained step by step [on katacoda tutorial](https://www.katacoda.com/sulliwane/scenarios/ffmpeg).

## How to deploy ffmpeg dapp on rinkeby with 'iexec init ffmpeg'
```
iexec init ffmpeg
cd iexec-ffmpeg
# prepare your account with eth and rlc
iexec wallet create
iexec wallet getETH --chain rinkeby
iexec wallet getRLC --chain rinkeby
iexec wallet show
# allow some of your RLC for off-chain computing payment.
iexec account allow 5 --chain rinkeby
# check your allowance
iexec account show
# deploy the smart contract and the binary 
iexec deploy --chain rinkeby
# test your nex deployed dapp with :
iexec submit --chain rinkeby
# Download your job result with :
iexec result 0x49eac074179f69ba646fd370698d52f07dc107307b19fbd0bfcc844d0da48477 --chain rinkeby --save
# see the encoded small.avi in the zip result :
unzip 0x49eac074179f69ba646fd370698d52f07dc107307b19fbd0bfcc844d0da48477.zip
Archive:  0x49eac074179f69ba646fd370698d52f07dc107307b19fbd0bfcc844d0da48477.zip
  inflating: stderr.txt
  inflating: small.avi

```

## Howto deploy ffmpeg dapp on ropsten

Remove all "--chain rinkeby" on all commands above. The ropsten chain is the targeted chain by default.



## Test existing dapp ffmeg 0x928cf44589ee9c7df100d24d6731e22ef9e571d3 on ropsten 
```
iexec init ffmpeg
cd iexec-ffmpeg
# prepare your account with eth and rlc
iexec wallet create
iexec wallet getETH 
iexec wallet getRLC 
iexec wallet show
# allow some of your RLC for off-chain computing payment.
iexec account allow 5 
# check your allowance
iexec account show
# submit on existing dapp 
iexec submit --dapp 0x928cf44589ee9c7df100d24d6731e22ef9e571d3
TODO get result
```


## Test existing dapp ffmeg 0x17f2675c58a5c701cc6ab274b41bcbb919a88cd4 on rinkeby 
```
iexec init ffmpeg
cd iexec-ffmpeg
# prepare your account with eth and rlc
iexec wallet create
iexec wallet getETH --chain rinkeby
iexec wallet getRLC --chain rinkeby
iexec wallet show
# allow some of your RLC for off-chain computing payment.
iexec account allow 5 --chain rinkeby
# check your allowance
iexec account show
# submit on existing dapp 
iexec submit --dapp 0x17f2675c58a5c701cc6ab274b41bcbb919a88cd4
TODO get result
```

## Checklist
 * add license
 * author name

