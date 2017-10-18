const oracleJSON = require('iexec-oracle-contract/build/contracts/IexecOracle.json');

const ROPSTEN_ORACLE_ADDRESS = oracleJSON.networks['3'].address;
const RINKEBY_ORACLE_ADDRESS = oracleJSON.networks['4'].address;
const KOVAN_ORACLE_ADDRESS = oracleJSON.networks['42'].address;
const LOCAL_ORACLE_ADDRESS = 'LOCAL_ORACLE_ADDRESS_VALUE';

module.exports = {
    networks: {
        development: {
            host: "http://localhost:8545",
            port: 8545,
            network_id: "*" // Match any network id,
            constructorArgs: [LOCAL_ORACLE_ADDRESS],
        },
        ropsten: {
            host: "https://ropsten.infura.io/berv5GTB5cSdOJPPnqOq",
            port: 8545,
            network_id: "3",
            constructorArgs: [ROPSTEN_ORACLE_ADDRESS],
            // gasPriceMultiplier: 2,  // use factor 2 of the network estimated gasPrice
            // gasLimitMultiplier: 4,  // use factor 4 of the network estimated gasLimit
            // gasPrice: 21000000000  // manually set the gasPrice in gwei. Prefer "gasPriceMultiplier"
            // gas: 400000  // manually set the gas limit in gwei. Prefer "gasLimitMultiplier"
        },
        rinkeby: {
            host: "https://rinkeby.infura.io/berv5GTB5cSdOJPPnqOq",
            port: 8545,
            network_id: "4",
            constructorArgs: [RINKEBY_ORACLE_ADDRESS],
        },
        kovan: {
            host: "https://kovan.infura.io/berv5GTB5cSdOJPPnqOq",
            port: 8545,
            network_id: "42",
            constructorArgs: [KOVAN_ORACLE_ADDRESS],
        },
    }
};
