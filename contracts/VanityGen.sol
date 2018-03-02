pragma solidity ^0.4.11;
import "iexec-oracle-contract/contracts/IexecOracleAPI.sol";
contract VanityGen is IexecOracleAPI{

    uint public constant DAPP_PRICE = 0;
    string public constant DAPP_NAME = "vanitygen";

    function VanityGen (address _iexecOracleAddress) IexecOracleAPI(_iexecOracleAddress,DAPP_PRICE,DAPP_NAME){

    }

    function generateVanity(string pattern,string publickey) payable external {
        require (bytes(pattern).length > 0);
        require (bytes(pattern).length <= 5);// max vanity lenght
        require(iexecSubmit("vanitygen","-P "+pattern+ " 1" + publickey ));
    }

}


