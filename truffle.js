module.exports = {
    networks: {
        development: {
            host: "http://localhost:8545",
            port: 8545,
            network_id: "*" // Match any network id
        },
        ropsten: {
            host: "https://ropsten.infura.io/berv5GTB5cSdOJPPnqOq",
            port: 8545,
            network_id: "3",
            // gasPriceMultiplier: 2,  // use factor 2 of the network estimated gasPrice
            // gasLimitMultiplier: 4,  // use factor 4 of the network estimated gasLimit
            // gasPrice: 21000000000  // manually set the gasPrice in gwei. Prefer "gasPriceMultiplier"
            // gas: 400000  // manually set the gas limit in gwei. Prefer "gasLimitMultiplier"
        },
        rinkeby: {
            host: "https://rinkeby.infura.io/berv5GTB5cSdOJPPnqOq",
            port: 8545,
            network_id: "4",
        },
        kovan: {
            host: "https://kovan.infura.io/berv5GTB5cSdOJPPnqOq",
            port: 8545,
            network_id: "42",
        },
    }
};
