var Ownable = artifacts.require("./zeppelin/ownership/Ownable.sol");
var Killable = artifacts.require("./zeppelin/lifecycle/Killable.sol");
var Authentication = artifacts.require("./Authentication.sol");
var GoodsMgmt = artifacts.require("./GoodsManagement.sol");
var ShipmentMgmt = artifacts.require("./ShipmentManagement.sol");

module.exports = function(deployer, network , accounts) {
  if( network !== "development") return; // End deployment
  deployer.deploy(Ownable);
  deployer.link(Ownable, [ Killable, ShipmentMgmt]);
  deployer.deploy(Killable);
  deployer.link(Killable, Authentication);
  deployer.deploy(Authentication);
  deployer.deploy(GoodsMgmt);
  deployer.link(GoodsMgmt,ShipmentMgmt);
  deployer.deploy(ShipmentMgmt,accounts); // Pass list of authorized addresses
}
