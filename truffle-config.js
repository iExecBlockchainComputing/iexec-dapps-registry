module.exports = {
  networks: {
    development: {
      host: 'http://localhost:8545',
      port: 8545,
      network_id: '*', // Match any network id,
      constructorArgs: [LOCAL_ORACLE_ADDRESS],
      server: 'https://localhost:443'
    }
  }

  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
};
