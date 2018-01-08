pragma solidity ^0.4.18;


/**
 *@title Goods
 *@author Gaston Rial
 *@dev This contract represents goods and asigns it properties
 */
contract GoodsManagement {
  
  // Structs 
  struct Goods {
    uint id;
    
    uint numberOfProperties;
    uint price; // In wei or other currency
    address owner;
  }

  struct Property {
    uint id;
    bytes16 name;
    bytes16 unit;
    uint value;
  }
    
  // State variables
    
  mapping ( uint => Goods ) public idToGoods;
  mapping( uint => mapping( uint => Property) ) public goodsIdToProperties;
  uint public goodsCounter;

  // Events
  event createGoodsEvent( uint indexed _id, uint _price );

  // Modifiers 
  modifier validateGoods(uint _goodsId, bytes16 _propertyName) {
    // Check whether goods exists
    require( idToGoods[_goodsId].id != 0 && idToGoods[_goodsId].id == _goodsId );
    // Check that the property was not defined to this goods
    uint numberOfProperties = idToGoods[_goodsId].numberOfProperties;
    bool exists = false;
    for( uint i = 0 ; i < numberOfProperties ; i++ ) {
      bytes16 name = goodsIdToProperties[_goodsId][i].name;
      if( name ==_propertyName ) exists = true;
    } 
    require(!exists);
    _;
  }

  // Constructor 
  function GoodsManagement() public {
    goodsCounter = 1; // First value
  }

  /**@dev Set new goods */
  function createGoods( uint _price ) public {
    Goods storage newGoods = idToGoods[goodsCounter];
    newGoods.id = goodsCounter;
    newGoods.price = _price;
    newGoods.numberOfProperties = 1;
    newGoods.owner = msg.sender;
    goodsCounter++;
    createGoodsEvent( newGoods.id, _price );
  }

  /**@dev Set new property to an existing good */
  function createProperty(uint _goodsId,bytes16 _name, bytes16 _unit, uint _value)
  public {
    Goods storage goods = idToGoods[_goodsId];
    uint id = goods.numberOfProperties;
    Property memory property = Property(id , _name, _unit, _value);
    goodsIdToProperties[_goodsId][id] = property;
    goods.numberOfProperties++;
  }

  function getPropertiesOfGoods(uint _goodsId, uint _propertyId ) view public returns ( uint id,
    bytes16 name,
    bytes16 unit,
    uint value) {
    
    if (idToGoods[_goodsId].numberOfProperties == 0 || idToGoods[_goodsId].numberOfProperties <= _propertyId) {
      return (0,0x0,0x0,0);
    }
    return (goodsIdToProperties[_goodsId][_propertyId].id,
            goodsIdToProperties[_goodsId][_propertyId].name,
            goodsIdToProperties[_goodsId][_propertyId].unit,
            goodsIdToProperties[_goodsId][_propertyId].value);
  }
}