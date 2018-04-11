pragma solidity ^0.4.11;
import "iexec-oracle-contract/contracts/IexecOracleAPI.sol";
contract Stockpredictor is IexecOracleAPI{

    uint public constant DAPP_PRICE = 0;
    string public constant DAPP_NAME = "stockpredictor";
    
    function Stockpredictor (address _iexecOracleAddress) IexecOracleAPI(_iexecOracleAddress,DAPP_PRICE,DAPP_NAME){

    }

}
