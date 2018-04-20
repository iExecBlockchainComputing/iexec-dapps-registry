pragma solidity ^0.4.11;
import "iexec-oracle-contract/contracts/IexecOracleAPI.sol";
contract TensorflowOnIexec is IexecOracleAPI{

    uint public constant DAPP_PRICE = 0;
    string public constant DAPP_NAME = "TensorflowOnIexec";
    bytes32 storedData;
    
    event Set(address from,bytes32 stored);

    function set(bytes32 x) {
        storedData = x;

        Set(msg.sender,x);
    }
    function get() constant returns (bytes32 retVal) {
        return storedData;
    }
    
    function TensorflowOnIexec (address _iexecOracleAddress) IexecOracleAPI(_iexecOracleAddress,DAPP_PRICE,DAPP_NAME){
    }

}
