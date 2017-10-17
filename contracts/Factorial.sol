pragma solidity ^0.4.11;
import "iexec-oracle-contract/contracts/IexecOracleAPI.sol";
contract Factorial is IexecOracleAPI{

  uint public constant DAPP_PRICE = 1;

  function Factorial (address _iexecOracleAddress) IexecOracleAPI(_iexecOracleAddress,DAPP_PRICE){

  }

}
