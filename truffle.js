module.exports = {
    networks: {
        development: {
            host: "http://localhost:8545",
            port: 8545,
            network_id: "42",
            gasLimitMultiplier: 5
        },
        ropsten: {
            host: "https://ropsten.infura.io/berv5GTB5cSdOJPPnqOq",
            port: 8545,
            network_id: "3",
            iexecOracleAddress: "0x552075c9e40b050c8b61339b770e2a21e9014b3c",
            gasLimitMultiplier: 5

            // gasPriceMultiplier: 2,  // use factor 2 of the network estimated gasPrice
            // gasLimitMultiplier: 4,  // use factor 4 of the network estimated gasLimit
            // gasPrice: 21000000000  // manually set the gasPrice in gwei. Prefer "gasPriceMultiplier"
            // gas: 400000  // manually set the gas limit in gwei. Prefer "gasLimitMultiplier"
        },
        rinkeby: {
            host: "https://rinkeby.infura.io/berv5GTB5cSdOJPPnqOq",
            port: 8545,
            network_id: "4",
            iexecOracleAddress: "0x0b1ea4ff347e05ca175e3d3cfb4499bc4ad5ada5",
            gasLimitMultiplier: 5
        },
        kovan: {
            host: "https://kovan.infura.io/berv5GTB5cSdOJPPnqOq",
            port: 8545,
            network_id: "42",
            iexecOracleAddress: "0xe6b658facf9621eff76a0d649c61dba4c8de85fb",
            gasLimitMultiplier: 5
        },
    }
};