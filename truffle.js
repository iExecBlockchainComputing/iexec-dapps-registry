module.exports = {
    networks: {
        development: {
            host: "localhost",
            port: 8545,
            network_id: "*" // Match any network id
        },
        ropsten: {
            host: "https://ropsten.infura.io/berv5GTB5cSdOJPPnqOq",
            port: 8545,
            network_id: "3",
            gasPriceMultiplier: 2,
            iexecOracleAddress: "0x552075c9e40b050c8b61339b770e2a21e9014b3c",
        },
        rinkeby: {
            host: "https://rinkeby.infura.io/berv5GTB5cSdOJPPnqOq",
            port: 8545,
            network_id: "4",
            gasPriceMultiplier: 2,
            iexecOracleAddress: "0x0b1ea4ff347e05ca175e3d3cfb4499bc4ad5ada5",
        },
        kovan: {
            host: "https://kovan.infura.io/berv5GTB5cSdOJPPnqOq",
            port: 8545,
            network_id: "42",
            gasPriceMultiplier: 2,
            iexecOracleAddress: "0xe6b658facf9621eff76a0d649c61dba4c8de85fb",
        },
    }
};
