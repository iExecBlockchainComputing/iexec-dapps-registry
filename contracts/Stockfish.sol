pragma solidity ^0.4.11;
import "./IexecOracleAPI.sol";
import "./strings.sol";
contract Stockfish is IexecOracleAPI{

    using strings for *;

    event Logs(string status, address indexed user); // logs for the front-end or smart contract to react correctly

    struct Chess {
    string game;
    }

    mapping (address => Chess) chessRegister;

    function Stockfish (address _iexecOracleAddress) IexecOracleAPI(_iexecOracleAddress){

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
        iexecSubmit("stockfish",chessRegister[msg.sender].game);
    }



}