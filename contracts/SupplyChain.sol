pragma solidity ^0.4.18;


import "./zeppelin/ownership/Ownable.sol";
import "./Chain.sol";


/**
 *@title SupplyChain
 *@author Gastón Rial
 *@dev This contract represents the organization compose by every stake holder of the supply chain.
 * It serves the purpose of registration of new members of the chain and validation of shipments. 
 */
contract SupplyChain is Ownable {

  /**@dev State variables */
  struct MemberStruct {

    bytes16 name;
    bytes32 email;
    uint index; // Way to store and search for an existing member

  }
  
  mapping ( address => MemberStruct ) private memberStructs;
  address[] private memberIndex;
  mapping(address => mapping(uint => bool)) public chainIsActive; // Map member to 
  Chain public chainInstance; 

  /**@dev Events*/
  event createMemberEvent(address indexed _memberId, uint indexed _index); // Alerts about the creation of a new member

  event deleteMemberEvent(address indexed _memberId, uint indexed _index); // Alerts about the removal of an existing member

  /**@dev modifiers */
  modifier memberExist ( address _id, bool _condition ) { // whether condition == true, then check if exist. Else, check that does not exist

    uint checkIndex = memberStructs[_id].index;
    if(_condition) {
    /** In order to update, retrieve or delete*/
    require( memberIndex.length != 0 && memberIndex[checkIndex] == _id);     

    } else {
     /** In order to create */
     require( memberIndex.length == 0 || memberIndex[checkIndex] != _id); 

    }
    _;
  }

  modifier memberHasChain(address _member, uint _chainId){

    require(chainIsActive[_member][_chainId]);
    _;

  }

  modifier memberHasNotChain(address _member, uint _chainId){

    require(!chainIsActive[_member][_chainId]);
    _;

  }

  /**@dev constructor */
  function SupplyChain() 
  public {
    chainInstance = new Chain(owner);
  }

  /**
   *@dev Function: createMember
   *     Description: Adds new member to list of supply chain owners
   */
  function createMember ( address _member, bytes16 _name, bytes32 _email) 
  public 
  onlyOwner()
  memberExist(_member , false)
  returns (uint index) {
    
    memberStructs[_member].name = _name;
    memberStructs[_member].email = _email;
    memberStructs[_member].index = memberIndex.push(_member)-1;
    createMemberEvent(_member,memberStructs[_member].index);
    return memberIndex.length-1;

  }
  
  /**@dev Function: addChain
  *       Description: Creates a new member
  */
  function addChain( uint _chainId , bytes16 _name ) 
  public 
  onlyOwner()
  returns (uint chainIndex){

    return chainInstance.createChain(_chainId ,_name);
    
  } 

  /**@dev Function: addMemberToAChain */
  function addMemberToAChain(address _member , uint _chainId) 
  public
  onlyOwner()
  memberHasNotChain(_member , _chainId)
  {

    chainIsActive[_member][_chainId]= true;

  }

  /**@dev Function: removeMemberfromAChain */
  function removeMemberfromAChain(address _member , uint _chainId) 
  public
  onlyOwner()
  memberHasChain(_member , _chainId)
  {

    chainIsActive[_member][_chainId]= false;
    
  }

  /**@dev Function: getMember */
  function getMember( address _member ) 
  public
  view 
  memberExist(_member,true)
  returns (bytes16 name,
    bytes32 email,
    uint index) {

    return (memberStructs[_member].name,
    memberStructs[_member].email,
    memberStructs[_member].index);

  }

  /**@dev Function: getMemberId */
  function getMemberId(uint _index) 
  public 
  view
  returns(address _member){
    return memberIndex[_index];
  }

  /**@dev Function: deleteMember
  *       Description: Deletes an existing member
  */
  function deleteMember(address _member)
  public
  onlyOwner()
  memberExist(_member,true)
  returns (uint _index){

    address idToMove = memberIndex[memberIndex.length-1];
    uint indexToDelete = memberStructs[_member].index;
    memberIndex[indexToDelete] = idToMove;
    memberStructs[idToMove].index = indexToDelete;
    memberIndex.length--;
    deleteMemberEvent(_member,_index);
    return indexToDelete; 

  }

  /**@dev Function: kill
  *      Description: Erases the contract state from the EVM
  */
  function kill() 
  public 
  onlyOwner(){

    selfdestruct(msg.sender);

  }

}