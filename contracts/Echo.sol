pragma solidity ^0.4.11;
import "iexec-oracle-contract/contracts/IexecOracleAPI.sol";
contract Echo is IexecOracleAPI{

  uint public constant DAPP_PRICE = 0;

  function Echo (address _iexecOracleAddress) IexecOracleAPI(_iexecOracleAddress,DAPP_PRICE){

  }


}
