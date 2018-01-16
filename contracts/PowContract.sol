pragma solidity ^0.4.18;

import "../iexec-oracle-contract/contracts/IexecOracleAPI.sol";

contract PowContract is IexecOracleAPI{

  uint public constant DAPP_PRICE = 0;
  string public constant DAPP_NAME = "proof-of-work";

  function PowContract (address _iexecOracleAddress) IexecOracleAPI(_iexecOracleAddress, DAPP_PRICE, DAPP_NAME){}

  function mint(string header, string difficulty) payable external {
    require(iexecSubmit("./pow.py"," "+header+" "+difficulty));
  }

}
