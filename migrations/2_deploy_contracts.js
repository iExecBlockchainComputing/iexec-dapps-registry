var TF_on_Iexec = artifacts.require("./TensorflowOnIexec.sol")

module.exports = function(deployer) {
    deployer.deploy(TF_on_Iexec);
};
