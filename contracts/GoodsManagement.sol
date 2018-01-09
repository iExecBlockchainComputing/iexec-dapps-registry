pragma solidity ^0.4.18;


/**
 *@title Goods
 *@author Gaston Rial
 *@dev This contract represents goods and asigns it properties
 */
contract GoodsManagement {
  
  /**@dev Struct definitions */
  /**@dev Struct: Goods
   * Description: This holds the features of every good or asset in a shipment 
   */
  struct Goods {
    uint id;
    uint numberOfProperties;
    uint price; // In wei or other currency
    address owner;
  }

  /**@dev Struct: Property
   * Description: This holds the features of every property (to be updated by the sensors)
   *  of the goods
   */
  struct Property {
    bytes16 name; // Has to be unique
    bytes16 unit;
    uint value;
    uint updateTime; // seconds since unix epoch
  }
    
  /**@dev State variables */
  /**@notice public variables have getter declared when the code is compile
   * To use them, call the contract instance with the name of the variable as if it was a function
   */
  mapping ( uint => Goods ) public idToGoods;
  mapping( uint => mapping( bytes16 => Property) ) public goodsIdToProperties; // From the id of a good it gets the id of a property and then the property itself
  uint public goodsCounter; // retains the number of registered goods in the system

  /**@dev Events */
  event createGoodsEvent( uint indexed _id, uint _price );

  /**@dev Modifiers */
  /**@dev Checks whether the goods exists and the property is not defined
   * Use to not oerwrite an existing property
   */
  modifier validateGoodsWithoutProperty(uint _goodsId, bytes16 _propertyName) {
    /**@dev Check whether goods exists */
    require( idToGoods[_goodsId].id != 0 && idToGoods[_goodsId].id == _goodsId );
    /**@dev Check that the property was not defined to this goods */
    require(goodsIdToProperties[_goodsId][_propertyName].name  == 0x0 ); // Has to be the default value
    _;
  }
  
  /**@dev Checks whether the good exists and has the property defined */
  modifier validateGoodsWithProperty(uint _goodsId, bytes16 _propertyName) {
    /**@dev Check whether goods exists */
    require( idToGoods[_goodsId].id != 0 && idToGoods[_goodsId].id == _goodsId );
    /**@dev Check that the property was defined to this goods */
    require(goodsIdToProperties[_goodsId][_propertyName].name != 0x0);
    _;
  }


  /**@dev Constructor */
  function GoodsManagement() public {
    goodsCounter = 1; // First value, update counter with the number of the first goosdsIs
  }

  /**@dev Function: createGoods
   * Description: Set new goods 
   */
  function createGoods( uint _price ) public {
    Goods storage newGoods = idToGoods[goodsCounter];
    newGoods.id = goodsCounter;
    newGoods.price = _price;
    newGoods.numberOfProperties = 1;
    newGoods.owner = msg.sender;
    goodsCounter++;
    createGoodsEvent( newGoods.id, _price );
  }

  /**@dev Function: createProperty
   * Description: Set new property to an existing good
   */
  function createProperty(uint _goodsId,bytes16 _name, bytes16 _unit, uint _value)
  public 
  validateGoodsWithoutProperty( _goodsId , _name ){
    Goods storage goods = idToGoods[_goodsId];
    uint id = goods.numberOfProperties;
    Property memory property = Property( _name, _unit, _value, now);
    goodsIdToProperties[_goodsId][_name] = property;
    goods.numberOfProperties++;
  }

  /**@dev Function: getPropertiesOfGoods
   * Description: Public getter to check the properties of a good
   * Returns: The required property's values 
   */
  function getPropertiesOfGoods(uint _goodsId, bytes16 _propertyName  ) 
  view 
  public 
  validateGoodsWithProperty( _goodsId , _propertyName )
  returns 
  (bytes16 name,
    bytes16 unit,
    uint value,
    uint updateTime) {
    
    return (goodsIdToProperties[_goodsId][_propertyName].name,
            goodsIdToProperties[_goodsId][_propertyName].unit,
            goodsIdToProperties[_goodsId][_propertyName].value,
            goodsIdToProperties[_goodsId][_propertyName].updateTime);
  }

  /**@dev Function: updateProperty
   * Description: Set new property to an existing good
   */
  function updateProperty(uint _goodsId,bytes16 _propertyName, uint _value, uint _unixTime )
  public 
  validateGoodsWithProperty( _goodsId , _propertyName ){
    goodsIdToProperties[_goodsId][_propertyName].value = _value;
    goodsIdToProperties[_goodsId][_propertyName].updateTime = _unixTime;
  }
}