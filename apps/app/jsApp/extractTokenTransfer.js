const Promise = require('bluebird');
const Web3 = require('web3');
const fs = require('fs-extra');
const openAsync = Promise.promisify(fs.open);
const writeAsync = Promise.promisify(fs.write);
const readFileAsync = Promise.promisify(fs.readFile);
const writeFileAsync = Promise.promisify(fs.writeFile);

var SMART_CONTRACT_ADDRESS = process.argv[2];
var NB_TX_LIMIT = process.argv[3];
var NODE_TARGET = process.argv[4];

console.log("SMART_CONTRACT_ADDRESS:" + SMART_CONTRACT_ADDRESS);
console.log("NB_TX_LIMIT:" + NB_TX_LIMIT);
console.log("NODE_TARGET:" + NODE_TARGET);

web3 = new Web3(new Web3.providers.HttpProvider(NODE_TARGET));
//wait for infura to do this to replace our test node .
//https://github.com/INFURA/infura/issues/13
Promise.promisifyAll(web3.eth, {
  suffix: "Promise"
});

async function getAbiContent() {
  try {
    var abiFileContent = await readFileAsync("./ERC20.abi");
    return JSON.parse(abiFileContent);
  } catch (err) {
    console.error(err)
  }
};

const saveResult = async(tab, file) => {
  const jsonTab = JSON.stringify(tab, null, 4);
  try {
    const fd = await openAsync(file, 'wx');
    await writeAsync(fd, jsonTab, 0, 'utf8');
    return fs.close(fd);
  } catch (error) {
    throw error;
  }
};


async function run() {
  try {
    var finalize = false;
    var count = 0;
    var abi = await getAbiContent();
    var tokenContract = web3.eth.contract(abi).at(SMART_CONTRACT_ADDRESS);
    var transferEvent = tokenContract.Transfer({}, {
      fromBlock: 0,
      toBlock: 'lastest'
    });

    //check ERC20 contract has totalSupply <> 0
    var totalSupply = await tokenContract.totalSupply.call();
    console.log("totalSupply:"+totalSupply.toNumber());
    if(totalSupply.toNumber() == 0){
      console.log("wrong ERC20 contract address because totalSupply=0");
      process.exit(1);
    }

    var transferTransactions = [];
    //Transfer(address indexed from, address indexed to, uint value);
    transferEvent.watch(async function(error, result) {
      if (!error) {
        count++;
        var transferTransaction = {
          blockNumber: result.blockNumber,
          transactionHash: result.transactionHash,
          from: result.args.from,
          to: result.args.to,
          value: result.args.value.toNumber()
        };
        transferTransactions.push(transferTransaction);
        if (count >= NB_TX_LIMIT && !finalize) {
          finalize = true;
          await saveResult(transferTransactions, "/host/transferTransactions.json");
          console.log("create transferTransactions.json");
          process.exit(0);
        }
      } else {
        console.log(error);
        process.exit(1);
      }
    });

  } catch (err) {
    console.error(err);
    process.exit(1);
  }
};

run();
