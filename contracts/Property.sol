pragma solidity ^0.4.18;


import "./zeppelin/ownership/Ownable.sol";


/**
 *@title Property
 *@author Gaston Rial
 *@dev This contract represents properties of goods. 
 * They are owned and its state is updated by sensors.
 */
contract Property is Ownable{
  
  /**@dev State variables */
  struct PropertyStruct {
    
    bytes16 name;
    bytes16 unit;
    int value;
    uint updateTime; // seconds since unix epoch
    int lowerTh; // By default 0
    int upperTh; // By default 0
    address sensor; // Address of the account 
    uint goodsId; // Identifier of goods
    uint index;
  }

  mapping(uint => PropertyStruct) private propertyStructs; // From key to Property
  uint[] private propertyIndex; // Array of keys

  /** @dev Events */
  /**@dev Triggered when a new property is created */
  event createPropertyEvent(uint indexed _id, uint indexed _index,bytes16 _name , bytes16 _unit , address _sensor);
  /**@dev Triggered when an existing property is deleted */
  event deletePropertyEvent(uint indexed _id, uint indexed _index);
  /**@dev Triggered when the variable exceeds a value */
  event upperThresholdEvent(uint indexed _id,int _value, uint _updateTime , int _upperTh );
  /**@dev Triggered when the variable is under a certain value */
  event lowerThresholdEvent(uint indexed _id,int _value, uint _updateTime , int _lowerTh );

  /**@dev modifiers */
  modifier propertyExist ( uint _id, bool _condition ) { // whether condition == true, then check if exist. Else, check that does not exist

    uint checkIndex = propertyStructs[_id].index;
    if(_condition) {
    /** In order to update, retrieve or delete*/
    require( propertyIndex.length != 0 && propertyIndex[checkIndex] == _id);     

    } else {
     /** In order to create */
     require( propertyIndex.length == 0 || propertyIndex[checkIndex] != _id); 

    }
    _;
  }

  modifier onlyBySensor( uint _id ){
    
    require( propertyStructs[_id].sensor == msg.sender );
    _;
  }

  /**@dev Constructor */
  function Property ( address _owner ) public {
    owner = _owner;
  }

  /** @dev Function: createProperty
  *        Description: Insert a new property 
  */
  function createProperty( uint _id, bytes16 _name , bytes16 _unit , address _sensor ) 
  public
  onlyOwner() 
  propertyExist(_id,false)
  returns ( uint index ){

    propertyStructs[_id].name = _name;
    propertyStructs[_id].unit = _unit; 
    propertyStructs[_id].sensor = _sensor;
    propertyStructs[_id].lowerTh = 0;
    propertyStructs[_id].upperTh = 0;
    propertyStructs[_id].index = propertyIndex.push(_id)-1;    
    createPropertyEvent( _id, propertyStructs[_id].index, _name , _unit , _sensor);
    return propertyIndex.length-1;

  }

  /**
  *@dev Function: setThreshold
  *     Description: Needed to set the thresholds
  */
  function setThreshold( uint _id, int _lowerTh ,int _upperTh) 
  public
  onlyOwner() 
  propertyExist(_id,true){
    
    propertyStructs[_id].lowerTh = _lowerTh;
    propertyStructs[_id].upperTh = _upperTh;
  
  }

  /**@dev Function: associateGoods */
function associateGoods( uint _id, uint _goodsId) 
  public
  onlyOwner() 
  propertyExist(_id,true){
    
    propertyStructs[_id].goodsId = _goodsId;
  
  }
  /**
   * @dev Function: updateState
   *      Description: This function is called by a sensor conected to the blockchain via a node.
   *                   It registers the value using its account.
   */
  function updateState( uint _id,int _value ) 
  public 
  propertyExist(_id,true)
  onlyBySensor(_id){

    propertyStructs[_id].value = _value;
    uint updateTime = now;
    propertyStructs[_id].updateTime = updateTime;

    if ( _value > propertyStructs[_id].upperTh ) { // If there is an alarm defined, and the value exceeds it, call the event.

      upperThresholdEvent( _id, _value , updateTime , propertyStructs[_id].upperTh );

    } else if ( _value < propertyStructs[_id].lowerTh ) {

      lowerThresholdEvent( _id, _value , updateTime ,propertyStructs[_id].lowerTh );

    }

  }

  /**@dev Function: getProperty*/
  function getProperty(uint _id) 
  public 
  view
  propertyExist(_id , true)
  returns (bytes16 name,
    bytes16 unit,
    int value,
    uint updateTime,
    int lowerTh,
    int upperTh,
    address sensor,
    uint goodsId,
    uint index){
    PropertyStruct storage property = propertyStructs[_id];
    return (
      property.name,
      property.unit,
      property.value,
      property.updateTime,
      property.lowerTh,
      property.upperTh,
      property.sensor,
      property.goodsId,
      property.index
    );
  }

  /**@dev Function: getPropertyCount */
  function getPropertyCount() 
  public 
  view 
  returns (uint count){
    
    return propertyIndex.length;

  }

  /**@dev Function: getPropertyId*/
  function getPropertyId(uint _index) 
  public 
  view returns (uint id) {
    return propertyIndex[_index];
  }  
  
  /**@dev Function: deleteProperty */
  function deleteProperty( uint _id ) 
  public 
  onlyOwner()
  propertyExist(_id,true)
  returns (uint index){

    uint idToMove = propertyIndex[propertyIndex.length-1];
    uint indexToDelete = propertyStructs[_id].index;
    propertyIndex[indexToDelete] = idToMove;
    propertyStructs[idToMove].index = indexToDelete;
    propertyIndex.length--;
    deletePropertyEvent( _id, indexToDelete);
    return indexToDelete;

  }
  /**@dev Function: kill */
  function kill()
  public 
  onlyOwner(){
    selfdestruct(owner);
  }

}