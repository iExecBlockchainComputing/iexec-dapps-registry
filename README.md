# figlet
## Description
http://www.figlet.org/
```
cd apps
./Figlet -f big.flf iExec
```
## Dapp params
```
module.exports = {
  name: 'Figlet',
  data: {
    type: 'BINARY',
    cpu: 'AMD64',
    os: 'LINUX',
  },
  work: {
    cmdline:'-f iexec/big.flf iExec',
    dirinuri:'http://www.figlet.org/fonts/big.flf',
  }
};
```
## [Examples](./examples)

##  Transactions story of the first dapp deploy on Main Net with iExec V1 The Wanderer

- Dapp Provider : [0xf33cddcd0bc63127d9b4b1331115c4fdc0bfdb36](https://etherscan.io/address/0xf33cddcd0bc63127d9b4b1331115c4fdc0bfdb36)

- Dapp User : [0x968883460d448cd1d606d843ef0dc87076f3f4ab](https://etherscan.io/address/0x968883460d448cd1d606d843ef0dc87076f3f4ab)

- Dapp Provider deploy the figlet dapp :
 [0x9e13e12dc330a83ceec53c66ef2ac2ea215e19afcb78298d21c53772005bb400](https://etherscan.io/tx/0x9e13e12dc330a83ceec53c66ef2ac2ea215e19afcb78298d21c53772005bb400)


```
vagrant@vagrant-ubuntu-trusty-64:~/iexecdev/iexec-figlet$ iexec deploy --chain mainnet
ℹ txHash: 0x9e13e12dc330a83ceec53c66ef2ac2ea215e19afcb78298d21c53772005bb400

ℹ View on etherscan: https://etherscan.io/tx/0x9e13e12dc330a83ceec53c66ef2ac2ea215e19afcb78298d21c53772005bb400

✔ Dapp contract deployed on ethereum. Contract address is 0x38c45565a01f86a1182dd8bc5922f374d5566b31

✔ App deployed on iExec offchain platform. Only callable through mainnet dapp at: 0x38c45565a01f86a1182dd8bc5922f374d5566b31
```

- First, the dapp user allow 5 nRLC Token for offchain computing : [0xb3c8aab20f7244a279d3e071fecf86d2a55aecb8e8fecac19a24995103b01ea5](https://etherscan.io/tx/0xb3c8aab20f7244a279d3e071fecf86d2a55aecb8e8fecac19a24995103b01ea5)


- Then, the dapp User choose a text to print and a figlet font to apply and call iexec submit :
 [0x4f69d3a76f018ee2db19d52265075435e8b7ad0201cc04d06f4124a4ec45fed4](https://etherscan.io/tx/0x4f69d3a76f018ee2db19d52265075435e8b7ad0201cc04d06f4124a4ec45fed4)

```
vagrant@vagrant-ubuntu-trusty-64:~/iexecdev/iexec-figlet$ ../iexec-sdk/dist/iexec.js submit --dapp 0x38c45565a01f86a1182dd8bc5922f374d5566b31 --chain mainnet
⠅⠀ ▶ calling iexecSubmit({"cmdline":"-f big.flf iExec V1 The Wanderer on MainNet","dirinuri":"http://www.figlet.org/fonts/big.flf"}) 
ℹ iexecSubmit({"cmdline":"-f big.flf iExec V1 The Wanderer on MainNet","dirinuri":"http://www.figlet.org/fonts/big.flf"}) 
txHash: 0x4f69d3a76f018ee2db19d52265075435e8b7ad0201cc04d06f4124a4ec45fed4

⠉⠙ ▶ waiting for transaction to be mined 
ℹ View on etherscan: https://etherscan.io/tx/0x4f69d3a76f018ee2db19d52265075435e8b7ad0201cc04d06f4124a4ec45fed4

✔ calculation job submitted to iExec workers

```

- A worker execution later, the dapp user can retrieve his result with the previous submit transaction :


```
vagrant@vagrant-ubuntu-trusty-64:~/iexecdev/iexec-figlet$ ../iexec-sdk/dist/iexec.js result 0x4f69d3a76f018ee2db19d52265075435e8b7ad0201cc04d06f4124a4ec45fed4 --chain mainnet  --save
✔ Result:
   stdout:   "PK\u0003\u0004\u0014"
   stderr:   ""
   resuri:   "xw://mainxw.iex.ec/dc91ec50-5400-4f8e-9ee7-c71205084349"

✔ Saved result to file /home/vagrant/iexecdev/iexec-figlet/0x4f69d3a76f018ee2db19d52265075435e8b7ad0201cc04d06f4124a4ec45fed4.zip
vagrant@vagrant-ubuntu-trusty-64:~/iexecdev/iexec-figlet$ unzip 0x4f69d3a76f018ee2db19d52265075435e8b7ad0201cc04d06f4124a4ec45fed4.zip
Archive:  0x4f69d3a76f018ee2db19d52265075435e8b7ad0201cc04d06f4124a4ec45fed4.zip
  inflating: stdout.txt
vagrant@vagrant-ubuntu-trusty-64:~/iexecdev/iexec-figlet$ cat stdout.txt
 _ ______                __      ____   _______ _
(_)  ____|               \ \    / /_ | |__   __| |
 _| |__  __  _____  ___   \ \  / / | |    | |  | |__   ___
| |  __| \ \/ / _ \/ __|   \ \/ /  | |    | |  | '_ \ / _ \
| | |____ >  <  __/ (__     \  /   | |    | |  | | | |  __/
|_|______/_/\_\___|\___|     \/    |_|    |_|  |_| |_|\___|


__          __             _
\ \        / /            | |
 \ \  /\  / /_ _ _ __   __| | ___ _ __ ___ _ __    ___  _ __
  \ \/  \/ / _` | '_ \ / _` |/ _ \ '__/ _ \ '__|  / _ \| '_ \
   \  /\  / (_| | | | | (_| |  __/ | |  __/ |    | (_) | | | |
    \/  \/ \__,_|_| |_|\__,_|\___|_|  \___|_|     \___/|_| |_|


 __  __       _       _   _      _
|  \/  |     (_)     | \ | |    | |
| \  / | __ _ _ _ __ |  \| | ___| |_
| |\/| |/ _` | | '_ \| . ` |/ _ \ __|
| |  | | (_| | | | | | |\  |  __/ |_
|_|  |_|\__,_|_|_| |_|_| \_|\___|\__|

```

- At the same time, the dapp provider earn 1nRLC : the RLC price he has set in his dapp smart contract.
[0x2785be7198632fe8159e718ba1109bfa988cdb0294b186bda7822b0a88cb4033](https://etherscan.io/tx/0x2785be7198632fe8159e718ba1109bfa988cdb0294b186bda7822b0a88cb4033)




