const oracleJSON = require('iexec-oracle-contract/build/contracts/IexecOracle.json');

const ROPSTEN_ORACLE_ADDRESS = oracleJSON.networks['3'].address;
const RINKEBY_ORACLE_ADDRESS = oracleJSON.networks['4'].address;
const KOVAN_ORACLE_ADDRESS = oracleJSON.networks['42'].address;

module.exports = {
    networks: {
        development: {
            host: "http://localhost:8545",
            port: 8545,
            network_id: "*", // Match any network id
            server: "https://localhost:443",
        },
        ropsten: {
            host: "https://ropsten.infura.io/berv5GTB5cSdOJPPnqOq",
            port: 8545,
            network_id: "3",
            constructorArgs: [ROPSTEN_ORACLE_ADDRESS],
            server: "https://testxw.iex.ec:443",
            // gasPriceMultiplier: 2,  // use factor 2 of the network estimated gasPrice
            // gasLimitMultiplier: 4,  // use factor 4 of the network estimated gasLimit
            // gasPrice: 21000000000,  // manually set the gasPrice in gwei. Prefer "gasPriceMultiplier"
            // gas: 400000,  // manually set the gas limit in gwei. Prefer "gasLimitMultiplier"
        },
        rinkeby: {
            host: "https://rinkeby.infura.io/berv5GTB5cSdOJPPnqOq",
            port: 8545,
            network_id: "4",
            constructorArgs: [RINKEBY_ORACLE_ADDRESS],
            server: "https://testxw.iex.ec:443",
            // gas: 400000,  // manually set the gas limit in gwei. Prefer "gasLimitMultiplier"
        },
        kovan: {
            host: "https://kovan.infura.io/berv5GTB5cSdOJPPnqOq",
            port: 8545,
            network_id: "42",
            constructorArgs: [KOVAN_ORACLE_ADDRESS],
            server: "https://testxw.iex.ec:443",
            // gas: 400000,  // manually set the gas limit in gwei. Prefer "gasLimitMultiplier"
        },
    }
};
