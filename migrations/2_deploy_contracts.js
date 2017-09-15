var IexecOracle = artifacts.require("./IexecOracle.sol");
var Echo = artifacts.require("./Echo.sol");


module.exports = function(deployer) {
    return deployer.deploy(IexecOracle)
            .then(() => IexecOracle.deployed())
    .then(instance => {
        console.log("IexecOracle deployed at address :" + instance.address)
    return deployer.deploy(HelloWorld, instance.address);
})
    .then(() => Echo.deployed())
    .then(instance => console.log("Echo deployed at address :" + instance.address));
};
