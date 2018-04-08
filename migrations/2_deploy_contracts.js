var PowContract = artifacts.require("./PowContract.sol");

module.exports = function(deployer) {
  deployer.deploy(PowContract);
};
