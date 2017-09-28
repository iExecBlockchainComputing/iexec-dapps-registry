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


}