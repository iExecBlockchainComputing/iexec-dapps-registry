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
            iexecOracleAddress: "0x04ffc7d992ddd3c4062e575dad3962927242150e",//oracle v0.1.3
            // gasPriceMultiplier: 2,  // use factor 2 of the network estimated gasPrice
            // gasLimitMultiplier: 4,  // use factor 4 of the network estimated gasLimit
            // gasPrice: 21000000000  // manually set the gasPrice in gwei. Prefer "gasPriceMultiplier"
            // gas: 400000  // manually set the gas limit in gwei. Prefer "gasLimitMultiplier"
        },
        rinkeby: {
            host: "https://rinkeby.infura.io/berv5GTB5cSdOJPPnqOq",
            port: 8545,
            network_id: "4",
            iexecOracleAddress: "0xc457c33bee7da36d4d73210693d058edd4402bbf",//oracle v0.1.3
        },
        kovan: {
            host: "https://kovan.infura.io/berv5GTB5cSdOJPPnqOq",
            port: 8545,
            network_id: "42",
            iexecOracleAddress: "0x2a3c991ce5622ed8b061de1a2630cff49478d148",//oracle v0.1.3
        },
    }
};
