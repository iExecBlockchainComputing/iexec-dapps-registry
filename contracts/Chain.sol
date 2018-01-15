pragma solidity ^0.4.18;


import './zeppelin/ownership/Ownable.sol';
import "./Shipment.sol";

/**
 *@title Chain
 *@author Gastón Rial
 *@dev This contract represents a sigle chain bound to a supply chain organization 
 */
contract Chain is Ownable{

  /**@dev State variables */
  struct ChainStruct{

    bytes16 name;
    uint creationTime;
    uint index;

  }

  mapping(uint => ChainStruct) private chainStructs;
  uint[] private chainIndex;
  Shipment public shipmentInstance;
  
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
  
  modifier chainHasShipment(uint _id,uint _shipmentId) {
   /** Check that the given property belongs to the goods */
    var (,,,chainId,) = shipmentInstance.getShipment(_shipmentId);
    require(_id == chainId);
    _;
  }
  /**@dev constructor */
  function Chain(address _owner)
  public{
    owner = _owner;
    shipmentInstance = new Shipment(owner);
  }

  /**@dev Function: createChain
  *       Description: Creates a new chain
  */
  function createChain( uint _id , bytes16 _name ) 
  public 
  onlyOwner()
  chainExist(_id,false)
  returns (uint index){

    chainStructs[_id].name = _name;
    chainStructs[_id].creationTime = now;
    chainStructs[_id].index = chainIndex.push(_id)-1;
    createChainEvent(_id,chainStructs[_id].index,chainStructs[_id].creationTime);
    return chainIndex.length-1;

  } 

  /**@dev Function: addShipment
   *      Description: Add a new shipment instance to this chain
   */
  function addShipment (uint _shipmentId,
  bytes16 _origin,
  bytes16 _destination,
  uint _id) 
  public
  onlyOwner()
  chainExist(_id,true)
  returns (uint index){
     
    index = shipmentInstance.createShipment(_shipmentId, _origin, _destination, _id);
    return index;
  }

  /**@dev Fuction: removeShipment
  *       Description: delete a shipment on this chain
  */
  function removeShipment(uint _id, uint _shipmentId)
  public
  onlyOwner()
  chainExist(_id,true)
  chainHasShipment(_id,_shipmentId)
  returns (uint _shipmentIndex){
    
    return shipmentInstance.deleteShipment(_shipmentId); 
  
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
  onlyOwner(){

    selfdestruct(msg.sender);

  }

}