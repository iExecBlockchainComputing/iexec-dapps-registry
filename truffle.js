module.exports = {
  networks: {
    development: {
      host: "localhost",
      port: 8545,
      network_id: "*" // Match any network id
    };
    ropsten: {
      host: "https://ropsten.infura.io/berv5GTB5cSdOJPPnqOq",
      port: 8545,
      network_id: "3" // Match any network id
    };
  }
};
