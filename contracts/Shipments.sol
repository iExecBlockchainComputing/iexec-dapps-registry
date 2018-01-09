pragma solidity ^0.4.18;


import "./zeppelin/ownership/Ownable.sol";
import "./GoodsManagement.sol";


/**
 *@title Shipment
 *@author Gastón Rial
 *@dev This contacts represent assets in the supply chain with given properties.
 * It would be derived by others more specific 
 */
contract ShipmentManagement {

  /**@dev Struct definitions */
  /**@dev Struct: Shipment
   * Description: This holds the features of every shipment 
   */
  struct Shipment {
    uint id;
    uint creationTime; // When was created 
    string origin;
    string destination;
    uint weight;
    Ownable owner;
  }

  /**@dev State variables */
  mapping ( uint => Shipment ) public idToShipment;
  mapping ( uint => uint[]) public shipmentIdToGoodsId;
  address[] public authorizers; // list of owners (who can delete or transfer a shipment)
  uint public shipmentCounter;

  /**@dev Events */
  /**@dev Description: event to be trigger when a new shipment is created */
  event createShipmentEvent( uint creationTime, uint indexed _id, string indexed _origin, string indexed _destination, uint _weight );

  
  /**@dev Modifiers */
  /**
   *@dev Check whether the operation is done by an authorized account
   */
  modifier isAuthorized () {
    // Check if the address is not null
    require(msg.sender != 0x0);
    // Check if the address is authorized
    bool isAuthorized = false;
    for ( uint i = 0 ; i < authorizers.length ; i++ ) {
      if( authorizers[i] == msg.sender ) isAuthorized = true;
    }
    require(isAuthorized);
    _;
  }
  
  /**
   *@dev Check whether the goods to push are not already loaded
   * and if there is enough space to add more
   */
  modifier validateShipment (uint _goodsId, uint _shipmentId) {
    // Check whether shipment exists
    require( idToShipment[_shipmentId].id != 0 && idToShipment[_shipmentId].id == _shipmentId );
    // Check that the goods does not belong to this embargo
    uint[] storage goodsId = shipmentIdToGoodsId[_shipmentId];
    bool exists = false;
    for( uint i = 0 ; i < goodsId.length ; i++ ) {
      if( goodsId[i] == _goodsId ) exists = true;
    } 
    require( !exists );
    _;
  }
  
  /**@dev Constructor */
  function ShipmentManagement(address[] _authorizers) public {
    authorizers = _authorizers;
    shipmentCounter = 1;
  }

  /**@dev Function: createShipment
   * Description: This function is call when a new shipment is created 
   */
  function createShipment( string _origin, string _destination, uint _weight )
  public 
  isAuthorized() {
    Shipment memory shipment = Shipment( shipmentCounter, now, _origin, _destination, _weight, new Ownable());
    idToShipment[shipmentCounter] = shipment;
    shipmentCounter++;
    createShipmentEvent( shipment.creationTime, shipment.id , _origin, _destination, _weight );
  }

  /**@dev Function: addGoods
  *Description: This function pushes a new Good struct into an existing shipment 
  */
  function addGoods ( uint _goodsId, uint _shipmentId ) 
  public
  isAuthorized()
  validateShipment(_goodsId, _shipmentId){  
    shipmentIdToGoodsId[_shipmentId].push(_goodsId);
  }

}