/**
 * @author Gastón Rial
 * @description To run this test: 1) Start testrpc (v6.0.3)
 *                                2) $ Truffle test ${PWD}/goodsManagementTest.js
 */
const ShipmentManagement = artifacts.require('ShipmentManagement.sol');
const GoodsManagement = artifacts.require('GoodsManagement.sol');

/**
 * @description Start a new test enviroment
*/
contract( 'Testing shipment contract interaction with js' , function (accounts) {

  let shipmentOrigin;
  let shipmentDestination;
  let shipmentWeight;
  let goodsPrice;
  let ShipmentManagementInstance;
  let GoodsManagementInstance;
  let goodsId;
  let shipementId;

  /** @description Initialize variables */
  before( 'Initializing variables' , function () {
    
    goodsPrice = web3.toWei(0.001,'ether'); // get Price in Wei
    goodsId = 1;
    shipmentId = 1;
    shipmentOrigin = web3.toHex('Montevideo');
    shipmentDestination = web3.toHex('Salto');
    shipmentWeight = 45; /// Kg    

  } );

  /** @description This is the first test */
  it( 'Creation of a new shipment' , function () {
    
    return ShipmentManagement.deployed().then( function (instance) { 

      ShipmentManagementInstance = instance;
      return ShipmentManagementInstance.createShipment( shipmentOrigin , shipmentDestination , shipmentWeight , 
        {

            from : accounts[0],
            gas : 4712388

      } );

    } ).then( function (receipt) { // Check event logs

      
      assert.equal(receipt.logs.length, 1 , 'The name of the event should be 1' );
      assert.equal(receipt.logs[0].event, 'createShipmentEvent' , 'The name of the event should be createShipmentEvent' );
      const currentTime = Date.now(); // Unix time in milliseconds
      assert.isAtMost(receipt.logs[0].args._creationTime.toNumber() , currentTime/1000 , `The creation time must be less or equal to ${new Date(currentTime)}` );
      assert.equal(web3.toAscii(receipt.logs[0].args._origin).replace(/[\u0000]/ig,'') , web3.toAscii(shipmentOrigin) , `The shipment origin should be ${web3.toAscii(shipmentOrigin).replace(/[\u0000]/ig,'')}` );
      assert.equal(web3.toAscii(receipt.logs[0].args._destination).replace(/[\u0000]/ig,'') , web3.toAscii(shipmentDestination) , `The shipment destination should be ${web3.toAscii(shipmentDestination).replace(/[\u0000]/ig,'')}` );
      assert.equal(receipt.logs[0].args._weight, shipmentWeight , `The shipment weight should be ${shipmentWeight} Kg` );
      assert.equal(receipt.logs[0].args._owner , accounts[0] , `The owner should be ${accounts[0]}`);

    } );

  } );

  /** @description This is the second test */
  it( 'Add new goods to the shipment' , function () {

    return GoodsManagement.deployed().then( function (instance) {

      GoodsManagementInstance = instance;
      GoodsManagementInstance.createGoods( goodsPrice , {
           
        from : accounts[0],
        gas: 4712388
      
      } );
    
    }).then( function ( receipt ) {
    /** Do not attempt to use the tx receipt */

      /** Add new goods to shipment */
      return ShipmentManagementInstance.addGoods( goodsId, shipmentId ,{
           
        from : accounts[0],
        gas: 4712388
      
      });
    
    } ).then( function ( receipt ) {

      return ShipmentManagementInstance.shipmentIdToGoodsId(1,0).then( function ( id ) {

        assert.equal(goodsId , id , `Goods id is ${id}`);
        return GoodsManagementInstance.idToGoods(id).then( function ( goods ) {

            assert.equal(goods[0], goodsId , `Goods id is saved as ${goodsId}` );
            assert.equal(goods[1], 1 , `There are no properties associated` );
            assert.equal(goods[2], goodsPrice , `The price of the goods are ${goodsPrice}` );
            assert.equal(goods[3], accounts[0], `The owner is ${accounts[0]}` );

        } );

      } );

    } )

  } );

} );