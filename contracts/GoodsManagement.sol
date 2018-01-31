pragma solidity ^0.4.18;


import "./Property.sol";
import "./zeppelin/ownership/Ownable.sol";


/**
 *@title GoodsManagement
 *@author Gaston Rial
 *@dev This contract represents a list of goods
 */
contract GoodsManagement is Ownable {
  
  /**@dev State variables */
  /**@dev Description: This holds the features of every good or asset in a shipment */
  struct GoodsStruct {

    uint shipmentId;
    uint index;
    address currentOwner;
  
  }
  
  mapping ( uint => GoodsStruct ) private goodsStructs;
  uint[] private goodsIndex;
  address public propertyInstance;

  /**@dev Events */
  event createGoodsEvent( uint indexed _id, uint indexed _index, address currentOwner);

  event deleteGoodsEvent(uint indexed _goodsId,uint indexed _index, address currentOwner);
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
    Property propertyContract = Property(propertyInstance);
    var (,,,,,,,goodsId,) = propertyContract.getProperty(_propertyId);
    require(_id == goodsId);
    _;
  }

  /**@dev Constructor */
  function GoodsManagement(address _admin) public {
    owner = _admin;
    propertyInstance = new Property(_admin); 
  }

  /**@dev Function: createGoods
   *      Description: Set new goods 
   */
  function createGoods( uint _id, uint _shipmentId, address _currentOwner) 
  public
  goodsExist(_id,false)
  returns (uint index){

    goodsStructs[_id].shipmentId = _shipmentId;
    goodsStructs[_id].currentOwner = _currentOwner;
    goodsStructs[_id].index = goodsIndex.push(_id)-1;
    createGoodsEvent( _id,goodsStructs[_id].index, _currentOwner);
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
    Property propertyContract = Property(propertyInstance);
    uint index = propertyContract.createProperty(_propertyId, _name ,_unit ,_sensor );
    propertyContract.setThreshold(_propertyId,_lowerTh , _upperTh);
    propertyContract.associateGoods(_propertyId,_id);
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
    Property propertyContract = Property(propertyInstance);
    return propertyContract.deleteProperty(_propertyId);
  }

  /**@dev Function: getGoods
  *       Description: retrieve goods struct by id
  */
  function getGoods(uint _id)
  public 
  view
  goodsExist(_id,true)
  returns(uint shipmentId,
    uint index,
    address currentOwner){

    return (goodsStructs[_id].shipmentId,
    goodsStructs[_id].index,
    goodsStructs[_id].currentOwner);
  
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
    address currentOwner = goodsStructs[_goodsId].currentOwner; 
    goodsIndex[indexToDelete] = idToMove;
    goodsStructs[idToMove].index = indexToDelete;
    goodsIndex.length--;
    _index = indexToDelete;
    deleteGoodsEvent(_goodsId,_index,currentOwner);
    return indexToDelete; 

  }

  /**@dev Function: changeOwnership*/
  function changeOwnership(uint _goodsId, address oldAddress, address newAddress) public 
  onlyOwner() 
  goodsExist(_goodsId,true)
  {
    require(oldAddress == goodsStructs[_goodsId].currentOwner);
    goodsStructs[_goodsId].currentOwner = newAddress;
  }

  /**@dev Function: kill*/
  function kill()
  public 
  onlyOwner(){
    selfdestruct(owner);
  }

}