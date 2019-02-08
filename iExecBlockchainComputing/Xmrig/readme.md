![dapp logo](./logo.png)

# XMRig

## Description

XMRig is a high-performance Monero CPU mining software.
Before starting, make sure you:

- Have a Monero Wallet
- Have chosen a mining pool, most known pools are xmrpool.eu and minexmr.com

## [Dapp params](./iexec.json)

These are the parameters to customize in your iexec.json, in: order -> buy -> params -> cmdline:

**TIMEOUT** -o **POOL**:**PORT** -u **ADDRESS** -p x --donate-level=**DONATE_LEVEL**

**TIMEOUT**: mining duration, in seconds  
**POOL**: the XMR mining pool you chose  
**PORT**: mining port, usually 3333 for beginners  
**ADDRESS**: the public address of your Monero Wallet  
**DONATE_LEVEL**: how much share you want to give to your mining pool
