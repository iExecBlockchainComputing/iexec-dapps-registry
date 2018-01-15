pragma solidity ^0.4.18;


import "./zeppelin/ownership/Ownable.sol";
import "./GoodsManagement.sol";


/**
 *@title Shipment
 *@author Gastón Rial
 *@dev This contacts represent assets in the supply chain with given properties.
 * It would be derived by others more specific 
 */
contract Shipment is Ownable{

  /**@dev State variables */
  struct ShipmentStruct {
    
    uint creationTime; // When was created 
    bytes16 origin;
    bytes16 destination;
    int latitud;  // Current location
    int longitud; // Current location
    uint weight;
    uint chainId;
    uint index;

  }

  mapping(uint => ShipmentStruct) private shipmentStructs;
  uint[] private shipmentIndex;
  GoodsManagement public  goodsManagementInstance; // Instance of GoodsManagement



  /**@dev Events */
  /**@dev Description: event to be trigger when a new shipment is created */
  event createShipmentEvent( uint creationTime,uint indexed _id, bytes16 _origin,bytes16  _destination, uint indexed _index);
  
  event updateShipmentLocationEvent( uint _currentTime , uint _id , int _latitud , int _longitud ,uint _weight );
  
  event deleteShipmentEvent(uint indexed _id, uint indexed _index);
  
   /**@dev modifiers */
  modifier shipmentExist ( uint _id, bool _condition ) { // whether condition == true, then check if exist. Else, check that does not exist

    uint checkIndex = shipmentStructs[_id].index;
    if(_condition) {
    /** In order to update, retrieve or delete*/
    require( shipmentIndex.length != 0 && shipmentIndex[checkIndex] == _id);     

    } else {
     /** In order to create */
     require( shipmentIndex.length == 0 || shipmentIndex[checkIndex] != _id); 

    }
    _;
  }

  modifier shipmentHasGoods(uint _id,uint _goodsId) {
   /** Check that the given property belongs to the goods */
    var (,shipmentId,) = goodsManagementInstance.getGoods(_goodsId);
    require(_id == shipmentId);
    _;
  }

  /**@dev Constructor */
  function Shipment( address _owner )
  public{
    owner = _owner;
    goodsManagementInstance = new GoodsManagement(owner); 
  }
  
  /**@dev Function: createShipment
  *        Description: Inserts into the blockchain a new shipement
  */
  function createShipment(
  uint _id,
  bytes16 _origin,
  bytes16 _destination,
  uint _chainId) 
  public 
  onlyOwner()
  shipmentExist(_id,false)
  returns (uint index){
    
    shipmentStructs[_id].creationTime = now;
    shipmentStructs[_id].origin = _origin;
    shipmentStructs[_id].destination = _destination;
    shipmentStructs[_id].chainId = _chainId;
    shipmentStructs[_id].index = shipmentIndex.push(_id)-1;
    createShipmentEvent( shipmentStructs[_id].creationTime, _id, _origin, _destination,shipmentStructs[_id].index);
    return shipmentIndex.length-1;
  }


  /**@dev Function: addGoods
  *       Description: insert goods of a given shipment
  */
  function addGoods(uint _id, uint _goodsId, uint _price)
  public 
  onlyOwner()
  shipmentExist(_id,true)
  returns (uint _goodsIndex) {

    return goodsManagementInstance.createGoods(_goodsId,_price,_id);

  }

  /**@dev Function: removeGoods
  *       Description: deletes goods of a given shipment
  */
  function removeGoods(uint _id, uint _goodsId)
  public 
  onlyOwner()
  shipmentExist(_id,true)
  shipmentHasGoods(_id,_goodsId)
  returns (uint _goodsIndex) {

    return goodsManagementInstance.deleteGoods(_goodsId);

  }

  /**@dev Function: updateShipmentLocation
   *      Description: This function is call when a shipment has change its place 
   */
  function updateShipmentLocation( uint _id, int _latitud, int _longitud, uint _weight )
  public 
  onlyOwner() 
  shipmentExist(_id,true){

    shipmentStructs[_id].latitud = _latitud;
    shipmentStructs[_id].longitud = _longitud;
    shipmentStructs[_id].weight = _weight;
    updateShipmentLocationEvent( now , _id , _latitud , _longitud , _weight );
  
  }

  /**@dev Function: getShipment
  *       Description: Retrieves shipment information
  */
  function getShipment(uint _id)
  public 
  view
  shipmentExist(_id,true)
  returns (uint creationTime,
    bytes16 origin,
    bytes16 destination,
    uint chainId,
    uint index){

    return (shipmentStructs[_id].creationTime,
            shipmentStructs[_id].origin,
            shipmentStructs[_id].destination,
            shipmentStructs[_id].chainId,
            shipmentStructs[_id].index);
  }

  /**@dev Function: getShipmentLocationAndWeight */
  function getShipmentLocationAndWeight (uint _id)
  view 
  public 
  shipmentExist(_id,true) 
  returns (int latitud,
    int longitud,
    uint weight) {
    
    return (shipmentStructs[_id].latitud,
            shipmentStructs[_id].longitud,
            shipmentStructs[_id].weight);
  
  }

  /**@dev Function: getShipmentId
  *       Description: Retrieve the id from the index of a shipement
  */
  function getShipmentId(uint _index)
  public
  view
  returns (uint id) {
    return shipmentIndex[_index];
  }

  /**@dev Function: getShipmentCount
  *       Description: Retrieve the amout of shipments in the system
  */
  function getShipmentCount()
  public
  view
  returns (uint count) {
    return shipmentIndex.length;
  }

  /**@dev Function: deleteShipment
  *       Description: Remove existing references to shipment
  */
  function deleteShipment(uint _id)
  public
  onlyOwner()
  shipmentExist(_id,true)
  returns (uint _index){

    uint idToMove = shipmentIndex[shipmentIndex.length-1];
    uint indexToDelete = shipmentStructs[_id].index;
    shipmentIndex[indexToDelete] = idToMove;
    shipmentStructs[idToMove].index = indexToDelete;
    shipmentIndex.length--;
    deleteShipmentEvent(_id,_index);
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