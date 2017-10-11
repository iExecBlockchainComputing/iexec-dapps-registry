const oracleJSON = require('iexec-oracle-contract');

const ROPSTEN_ORACLE_ADDRESS=oracleJSON.networks['3'].address;
const RINKEBY_ORACLE_ADDRESS=oracleJSON.networks['4'].address;
const KOVAN_ORACLE_ADDRESS=oracleJSON.networks['42'].address;

module.exports = {
  name: 'Echo',
  constructorArgs: [ROPSTEN_ORACLE_ADDRESS],
  // constructorArgs: [RINKEBY_ORACLE_ADDRESS],
  // constructorArgs: [KOVAN_ORACLE_ADDRESS],
};
