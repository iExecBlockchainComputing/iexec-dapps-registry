pragma solidity ^0.4.11;
import "iexec-oracle-contract/contracts/IexecOracleAPI.sol";
import "./strings.sol";
contract Stockfish is IexecOracleAPI{
    using strings for *;
    
    uint public constant DAPP_PRICE = 0;
    string public constant DAPP_NAME = "stockfish";

    event Logs(string status, address indexed user); // logs for the front-end or smart contract to react correctly

    struct Chess {
    string game;
    }

    mapping (address => Chess) chessRegister;

    function Stockfish (address _iexecOracleAddress) IexecOracleAPI(_iexecOracleAddress,DAPP_PRICE,DAPP_NAME){

    }

    function checkValidity(string userMove) constant returns (bool validity) {
        if (userMove.toSlice().len() != 4) return false;
        else if (bytes(userMove)[0] < "a" || bytes(userMove)[0] > "h") return false;
        else if (bytes(userMove)[1] < "1" || bytes(userMove)[1] > "8") return false;
        else if (bytes(userMove)[2] < "a" || bytes(userMove)[2] > "h") return false;
        else if (bytes(userMove)[3] < "1" || bytes(userMove)[3] > "8") return false;
        else return true;
    }

    function setParam(string userMove)  {
        bool validity = checkValidity(userMove);
        if (!validity) {
            Logs("ERROR", msg.sender);
            throw;
        }
        if (chessRegister[msg.sender].game.toSlice().len() != 0)
        chessRegister[msg.sender].game = " ".toSlice().concat(chessRegister[msg.sender].game.toSlice()); // separate moves
        chessRegister[msg.sender].game = userMove.toSlice().concat(chessRegister[msg.sender].game.toSlice());
        //iexecSubmit(string appName, string param)
       //iexecSubmit("stockfish",chessRegister[msg.sender].game);
    }

    function undoMove() {
        var game = chessRegister[msg.sender].game.toSlice();
        uint8 nbmoves;
        for( nbmoves=0; nbmoves<2; nbmoves++) { // delete the player move and the IA move
            game.split(" ".toSlice());
        }
        chessRegister[msg.sender].game = game.toString();
        Logs("Task finished !", msg.sender);
    }

    function flushGame() {
        chessRegister[msg.sender].game = "";
        Logs("Task finished !", msg.sender);
    }

    //overwrite IexecOracleAPI iexecSubmitCallback
    function iexecSubmitCallback(bytes32 submitTxHash, address user, string appName, string stdout) returns (bool){
        require(msg.sender == iexecOracleAddress);
        IexecSubmitCallback(submitTxHash,user,appName,stdout);
        pushResult(user,stdout);
        return true;
    }

    function pushResult(address userAddr, string newAIMove) internal {
        if (chessRegister[userAddr].game.toSlice().len() != 0)
        chessRegister[userAddr].game = " ".toSlice().concat(chessRegister[userAddr].game.toSlice());
        chessRegister[userAddr].game = newAIMove.toSlice().concat(chessRegister[userAddr].game.toSlice());
        Logs("Task finished !",userAddr);
    }

    function getResult() constant returns (string game) {
        return (chessRegister[msg.sender].game);
    }


}
