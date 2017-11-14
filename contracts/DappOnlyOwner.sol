pragma solidity ^0.4.11;
import "iexec-oracle-contract/contracts/IexecOracleAPI.sol";
import 'zeppelin-solidity/contracts/ownership/Ownable.sol'

contract DappOnlyOwner is IexecOracleAPI, Ownable{

    uint public constant DAPP_PRICE = 0;
    string public constant DAPP_NAME = "scTest";
    
    function DappOnlyOwner (address _iexecOracleAddress) IexecOracleAPI(_iexecOracleAddress,DAPP_PRICE,DAPP_NAME){

    }

    function iexecSubmit(string param) payable onlyOwner {
        IexecOracle iexecOracle = IexecOracle(iexecOracleAddress);
        require(iexecOracle.submit.value(msg.value)(param));
    }

}
