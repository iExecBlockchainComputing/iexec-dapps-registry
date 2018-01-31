var Ownable = artifacts.require("./zeppelin/ownership/Ownable.sol");
var Killable = artifacts.require("./zeppelin/lifecycle/Killable.sol");
var Authentication = artifacts.require("./Authentication.sol");
//var GoodsMgmt = artifacts.require("./GoodsManagement.sol");
//var ShipmentMgmt = artifacts.require("./Shipment.sol");
//var Property = artifacts.require("./Property.sol");
var SupplyChain = artifacts.require("./SupplyChain.sol");

module.exports = function(deployer, network , accounts) {
  
  if( network !== "development") return; // End deployment
  deployer.deploy(Ownable);
  deployer.link(Ownable, [SupplyChain]);
  deployer.deploy(Killable);
  deployer.link(Killable, Authentication);
  deployer.deploy(Authentication);
  //deployer.deploy(Property);
  //deployer.link(Property,GoodsMgmt);
  //deployer.deploy(GoodsMgmt);
  //deployer.link(GoodsMgmt,ShipmentMgmt);
  //deployer.deploy(ShipmentMgmt);
  //deployer.deploy(Chain);
  deployer.deploy(SupplyChain);
}
