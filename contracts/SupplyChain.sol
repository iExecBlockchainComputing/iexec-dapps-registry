pragma solidity ^0.4.18;

import "./Authentication.sol";
import "./Shipment.sol";
/**
 *@title SupplyChain
 *@author Gastón Rial
 *@dev This contract represents the organization compose by every stake holder of the supply chain.
 * It serves the purpose of registration of new members of the chain and validation of shipments. 
 */
contract SupplyChain is Authentication {

  /**@dev State variables */
  struct ChainStruct{

    bytes16 name;
    uint creationTime;
    uint index;

  }

  mapping(uint => ChainStruct) private chainStructs;
  uint[] private chainIndex;

  mapping(address => mapping(uint => bool)) public chainIsActive; // Map member to 
  address public shipmentInstance;


  /**@dev Events */
  event createChainEvent(uint indexed _id , uint indexed _index,  uint _creationTime); // Alerts about the creation of a new chain

  event deleteChainEvent(uint indexed _id , uint indexed _index);

  /**@dev modifiers */
  modifier chainExist ( uint _id, bool _condition ) { // whether condition == true, then check if exist. Else, check that does not exist

    uint checkIndex = chainStructs[_id].index;
    if(_condition) {
    /** In order to update, retrieve or delete*/
    require( chainIndex.length != 0 && chainIndex[checkIndex] == _id);     

    } else {
     /** In order to create */
     require( chainIndex.length == 0 || chainIndex[checkIndex] != _id); 

    }
    _;
  }

  modifier memberHasChain(uint _chainId){

    require(chainIsActive[msg.sender][_chainId]);
    _;

  }

  modifier memberHasNotChain(uint _chainId){

    require(!chainIsActive[msg.sender][_chainId]);
    _;

  }
  
  /**@dev Constructor*/
  function SupplyChain () public {
    shipmentInstance = new Shipment(msg.sender);
  }

  /**@dev Function: createChain
  *       Description: Creates a new chain
  */
  function createChain( uint _id , bytes16 _name ) 
  public 
  onlyExistingUser()
  chainExist(_id,false)
  returns (uint index){

    chainStructs[_id].name = _name;
    chainStructs[_id].creationTime = now;
    chainStructs[_id].index = chainIndex.push(_id)-1;
    createChainEvent(_id,chainStructs[_id].index,chainStructs[_id].creationTime);
    return chainIndex.length-1;

  } 

  /**@dev Function: addMemberToAChain */
  function addMemberToAChain( uint _chainId) 
  public
  onlyExistingUser()
  memberHasNotChain( _chainId)
  {

    chainIsActive[msg.sender][_chainId]= true;

  }

  /**@dev Function: removeMemberfromAChain */
  function removeMemberfromAChain( uint _chainId) 
  public
  onlyExistingUser()
  memberHasChain(_chainId)
  {

    chainIsActive[msg.sender][_chainId]= false;
    
  }

  /**@dev Function: getChain
  *       Description: This method retrieves all the data concerning a particular chain
  */
  function getChain(uint _id) 
  view
  public
  chainExist(_id,true)
  returns( bytes16 name,
    uint creationTime,
    uint index) {
    
    return (chainStructs[_id].name,
            chainStructs[_id].creationTime,
            chainStructs[_id].index);

  }

    /**@dev Function: getChainId
  *       Description: retrieve id from index 
  */
  function getChainId(uint _index) 
  public 
  view 
  returns (uint id){
    return chainIndex[_index];
  }

  /**@dev Function: getChainCount
          Description Return the number of registered chains 
  */
  function getChainCount()
  public 
  view
  returns (uint count){
    return chainIndex.length-1;
  }

  /**@dev Function: deleteChain
  *       Description: Remove existing references to chain
  */
  function deleteChain(uint _id)
  public
  onlyOwner()
  chainExist(_id,true)
  returns (uint _index){

    uint idToMove = chainIndex[chainIndex.length-1];
    uint indexToDelete = chainStructs[_id].index;
    chainIndex[indexToDelete] = idToMove;
    chainStructs[idToMove].index = indexToDelete;
    chainIndex.length--;
    deleteChainEvent(_id,_index);
    return indexToDelete; 

  }

  /**@dev Function: kill
  *      Description: Erases the contract state from the EVM
  */
  function kill() 
  public
  onlyExistingUser {

    selfdestruct(msg.sender);

  }

}