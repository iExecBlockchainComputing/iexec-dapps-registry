pragma solidity ^0.4.18;

import "iexec-oracle-contract/contracts/IexecOracleAPI.sol";

contract CpuMiner is IexecOracleAPI{

  uint public constant DAPP_PRICE = 0;
  string public constant DAPP_NAME = "cpuminer";

  function CpuMiner(address _iexecOracleAddress) IexecOracleAPI(_iexecOracleAddress,DAPP_PRICE,DAPP_NAME){}

}
