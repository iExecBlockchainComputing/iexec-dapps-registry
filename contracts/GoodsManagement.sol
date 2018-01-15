pragma solidity ^0.4.18;

import "./zeppelin/ownership/Ownable.sol";
import "./Property.sol";


/**
 *@title GoodsManagement
 *@author Gaston Rial
 *@dev This contract represents a list of goods
 */
contract GoodsManagement is Ownable{
  
  /**@dev State variables */
  /**@dev Description: This holds the features of every good or asset in a shipment */
  struct GoodsStruct {

    uint price; // In wei or other currency
    uint shipmentId;
    uint index;
  
  }
  
  mapping ( uint => GoodsStruct ) private goodsStructs;
  uint[] private goodsIndex;
  Property public propertyInstance;

  /**@dev Events */
  event createGoodsEvent( uint indexed _id, uint indexed _index, uint _price );

  event deleteGoodsEvent(uint indexed _goodsId,uint indexed _index);
  /**@dev modifiers */
  modifier goodsExist ( uint _id, bool _condition ) { // whether condition == true, then check if exist. Else, check that does not exist

    uint checkIndex = goodsStructs[_id].index;
    if(_condition) {
    /** In order to update, retrieve or delete*/
    require( goodsIndex.length != 0 && goodsIndex[checkIndex] == _id);     

    } else {
     /** In order to create */
     require( goodsIndex.length == 0 || goodsIndex[checkIndex] != _id); 

    }
    _;
  }

  modifier goodsHasProperty(uint _id,uint _propertyId) {
   /** Check that the given property belongs to the goods */
    var (,,,,,,,goodsId,) = propertyInstance.getProperty(_propertyId);
    require(_id == goodsId);
    _;
  }

  /**@dev Constructor */
  function GoodsManagement(address _owner) public {
    owner = _owner;
    propertyInstance = new Property(owner); 
  }

  /**@dev Function: createGoods
   *      Description: Set new goods 
   */
  function createGoods( uint _id, uint _price, uint _shipmentId) 
  public 
  onlyOwner() 
  goodsExist(_id,false)
  returns (uint index){

    goodsStructs[_id].price = _price;
    goodsStructs[_id].shipmentId = _shipmentId;
    goodsStructs[_id].index = goodsIndex.push(_id)-1;
    createGoodsEvent( _id,goodsStructs[_id].index,_price );
    return goodsIndex.length-1;

  }

  /**@dev Function: addProperty
   *      Description: Set new property to an existing good
   */
  function addProperty(uint _id, uint _propertyId, bytes16 _name , bytes16 _unit , address _sensor, int _lowerTh ,int _upperTh)
  public
  onlyOwner() 
  goodsExist(_id,true)
  returns (uint _propertyIndex){

    uint index = propertyInstance.createProperty(_propertyId, _name ,_unit ,_sensor );
    propertyInstance.setThreshold(_propertyId,_lowerTh , _upperTh);
    propertyInstance.associateGoods(_propertyId,_id);
    return index;
  }

  /**@dev Function: removeProperty
   *      Description: delete a property from some existing goods
   */
  function removeProperty(uint _id, uint _propertyId)
  public
  onlyOwner() 
  goodsExist(_id,true)
  goodsHasProperty(_id,_propertyId)
  returns (uint _propertyIndex){

    return propertyInstance.deleteProperty(_propertyId);
  
  }

  /**@dev Function: getGoods
  *       Description: retrieve goods struct by id
  */
  function getGoods(uint _id)
  public 
  view
  goodsExist(_id,true)
  returns(uint price,
    uint shipmentId,
    uint index){

    return (goodsStructs[_id].price,
    goodsStructs[_id].shipmentId,
    goodsStructs[_id].index);
  
  }

 /**@dev Function: getGoodsId
  *       Description: retrieve goods id by index
  */
  function getGoodsId(uint _index) 
  public
  view
  returns (uint id){
    return goodsIndex[_index];
  }
  
  /**@dev Function: getGoodsCount 
  *       Description: Get the counter of indexes
  */
  function getGoodsCount()
  public 
  view 
  returns ( uint count){
    
    return goodsIndex.length;

  }

  /**@dev Function: deleteGoods
  *       Description: Remove existing references to goods
  */
  function deleteGoods(uint _goodsId)
  public
  onlyOwner()
  goodsExist(_goodsId,true)
  returns (uint _index){

    uint idToMove = goodsIndex[goodsIndex.length-1];
    uint indexToDelete = goodsStructs[_goodsId].index; 
    goodsIndex[indexToDelete] = idToMove;
    goodsStructs[idToMove].index = indexToDelete;
    goodsIndex.length--;
    deleteGoodsEvent(_goodsId,_index);
    return indexToDelete; 

  }


  /**@dev Function: kill*/
  function kill()
  public 
  onlyOwner(){
    selfdestruct(owner);
  }

}