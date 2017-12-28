pragma solidity ^0.4.11;
import "iexec-oracle-contract/contracts/IexecOracleAPI.sol";
contract TimeClock is IexecOracleAPI{

    uint public constant DAPP_PRICE = 0;
    string public constant DAPP_NAME = "timeclock";


    mapping (address => uint) employeeTimeClock;

    uint public employeeAtOffice;

    bool public alarmActivated;

    function TimeClock (address _iexecOracleAddress) IexecOracleAPI(_iexecOracleAddress,DAPP_PRICE,DAPP_NAME){
        alarmActivated= true;
    }

    function getEmployeeBadgeInTime(address employee) constant return uint {
      return employeeTimeClock[employee];
    }


    function badgeIn() payable public{
        //employee can't badge-in two time without badge-out
        require(employeeTimeClock[msg.sender]  == 0);
        if(employeeAtOffice == 0){
            //first employee arrive at office => desactivate alarm
            iexecSubmit("--desactivate");
        }
        //store entering time of the employee
        employeeTimeClock[msg.sender] = now;
        // update the total of employee present at office
        employeeAtOffice++;
    }


    function badgeOut() payable public {
        // check if employee has badge-in. if badge-in, entering time of employee is valorized
        if( employeeTimeClock[msg.sender] != 0 ){
            //retreived the employee entering time
            uint badgeInTime = employeeTimeClock[msg.sender];
            //reset the employee entering time
            employeeTimeClock[msg.sender] = 0;
            //calcule how much to pay employee. simple 1 sec = 1 wei
            uint weiToPay =  now - badgeInTime;
            // send eth to employee
            msg.sender.transfer(weiToPay);
            // update the total of employee present at office
            employeeAtOffice--;
            // if no more employees at office => activate alarm
            if(employeeAtOffice == 0){
                iexecSubmit("--activate");
            }
        }
    }

    // function will be call after the off-chain computation has been done
    function iexecSubmitCallback(bytes32 submitTxHash, address user, string stdout, string uri) public returns  (bool){
        require(msg.sender == iexecOracleAddress);
        IexecSubmitCallback(submitTxHash,user,stdout,uri);
        if(keccak256(stdout) == keccak256("ON")){
            alarmActivated = true;
        }

        if(keccak256(stdout) == keccak256("OFF")){
            alarmActivated = false;
        }
        return true;
    }



}
