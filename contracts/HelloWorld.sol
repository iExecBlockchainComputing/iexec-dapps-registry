pragma solidity ^0.4.11;
import "./IexecOracleAPI.sol";
contract HelloWorld is IexecOracleAPI{

  function HelloWorld (address _iexecOracleAddress) IexecOracleAPI(_iexecOracleAddress){

  }


  function submitEcho(string helloText ){
    iexecSubmit("echo",helloText);
  }

  function submitAndWaitEcho(string helloText ){
    iexecSubmitAndWait("echo",helloText);
  }

  function statusHelloWorld(string workUid){
    iexecStatus(workUid);
  }

  function resultHelloWorld(string workUid){
    iexecResult(workUid);
  }









}
