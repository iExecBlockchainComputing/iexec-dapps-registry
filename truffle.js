const ROPSTEN_ORACLE_ADDRESS = 0x361a12b8caa96AdD52aBcae37cdC28DFabA24f04;

module.exports = {
  networks: {
    ropsten: {
      // ETH node relay config
      host: 'https://ropsten.infura.io/berv5GTB5cSdOJPPnqOq',
      port: 8545,
      network_id: '3',
      constructorArgs: [ROPSTEN_ORACLE_ADDRESS],
      // iExec server used to deploy legacy app
      server: 'https://testxw.iex.ec:443',
      // gasPriceMultiplier: 2,  // use factor 2 of the network estimated gasPrice
      // gasLimitMultiplier: 4,  // use factor 4 of the network estimated gasLimit
      // gasPrice: 21000000000  // manually set the gasPrice in gwei. Prefer 'gasPriceMultiplier'
      // gas: 400000  // manually set the gas limit in gwei. Prefer 'gasLimitMultiplier'
    }
  }
};
