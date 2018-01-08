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

  // Structs

  struct Shipment {
    uint id;
    uint creationTime; // When was created 
    string origin;
    string destination;
    uint weight;
    uint[] goodsId; // The ones transported by the shipment
    Ownable owner;
  }

  // State variables
  
  mapping ( uint => Shipment ) public idToShipment;
  address[] public authorizers; // list of owners (who can delete or transfer a shipment)
  uint public shipmentCounter;
  GoodsManagement public goodsMgmt;

  // Events 
  /**@dev Event to be trigger when a new shipment is created */
  event createShipmentEvent( uint creationTime, uint indexed _id, string indexed _origin, string indexed _destination, uint _weight );


  // Modifiers
  /**@dev Check whether the operation is done by an authorized account*/
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

  modifier validateShipment (uint _goodsId, uint _shipmentId) {
    // Check whether shipment exists
    require( idToShipment[_shipmentId].id != 0 && idToShipment[_shipmentId].id == _shipmentId );
    // Check that the goods does not belong to this embargo
    uint[] storage goodsId = idToShipment[_shipmentId].goodsId;
    bool exists = false;
    for( uint i = 0 ; i < goodsId.length ; i++ ) {
      if( goodsId[i] == _goodsId ) exists = true;
    } 
    require( !exists );
    _;
  }
  
  //Constructor
  function ShipmentManagement(address[] _authorizers) public {
    authorizers = _authorizers;
    shipmentCounter = 1;
    goodsMgmt = new GoodsManagement(); // New contracts address
  }

  /**@dev This function is call when a new shipment is created */
  function createShipment( string _origin, string _destination, uint _weight )
  public 
  isAuthorized() {
    Shipment storage shipment = idToShipment[shipmentCounter];
    shipment.id = shipmentCounter;
    shipment.creationTime = now;
    shipment.origin = _origin;
    shipment.destination = _destination;
    shipment.weight = _weight;
    shipmentCounter++;
    createShipmentEvent( shipment.creationTime, shipment.id , _origin, _destination, _weight );
  }

  /** @dev This function pushes a new Good struct into an existing shipment */
  function addGoods ( uint _goodsId, uint _shipmentId ) 
  public
  isAuthorized()
  validateShipment(_goodsId, _shipmentId){  
    idToShipment[_shipmentId].goodsId.push(_goodsId);
  }

}