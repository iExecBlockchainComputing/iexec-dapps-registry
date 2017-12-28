var IexecOracle = artifacts.require("./IexecOracle.sol");
var IexecOracleAPI = artifacts.require("./IexecOracleAPITest.sol");
var IexecOracleEscrow = artifacts.require("./IexecOracleEscrow.sol");
var TimeClock = artifacts.require("./TimeClock.sol");
var RLC = artifacts.require("../node_modules/rlc-token//contracts/RLC.sol");

const Promise = require("bluebird");
//extensions.js : credit to : https://github.com/coldice/dbh-b9lab-hackathon/blob/development/truffle/utils/extensions.js
const Extensions = require("../utils/extensions.js");
const addEvmFunctions = require("../utils/evmFunctions.js");
addEvmFunctions(web3);
Promise.promisifyAll(web3.eth, {
    suffix: "Promise"
});
Promise.promisifyAll(web3.version, {
    suffix: "Promise"
});
Promise.promisifyAll(web3.evm, {
    suffix: "Promise"
});
Extensions.init(web3, assert);


contract('TimeClock', function(accounts) {

    var dappProvider, dappUser, bridge, rlcCreator;
    var amountGazProvided = 4000000;
    let isTestRPC;
    let testTimemout = 0;
    let aRLCInstance;
    let aIexecOracleEscrowInstance;
    let aTimeClockInstance;

    IexecOracle.Status = {
        UNSET: 0,
        UNAVAILABLE: 1,
        PENDING: 2,
        RUNNING: 3,
        COMPLETED: 4,
        ERROR: 5
    };

    before("should prepare accounts and check TestRPC Mode", function() {
        assert.isAtLeast(accounts.length, 4, "should have at least 4 accounts");
        dappProvider = accounts[0];
        dappUser = accounts[1];
        bridge = accounts[2];
        rlcCreator = accounts[3];

        return Extensions.makeSureAreUnlocked(
            [dappProvider,dappUser, bridge, rlcCreator])
            .then(() => web3.eth.getBalancePromise(dappProvider))
    .then(balance => assert.isTrue(
            web3.toWei(web3.toBigNumber(90), "ether").lessThan(balance),
            "dappProvider should have at least 35 ether, not " + web3.fromWei(balance, "ether")))
    .then(() => Extensions.refillAccount(dappProvider, dappUser, 10))
    .then(() => Extensions.refillAccount(dappProvider, bridge, 10))
    .then(() => Extensions.refillAccount(dappProvider, rlcCreator, 10))
    .then(() => web3.version.getNodePromise())
    .then(node => isTestRPC = node.indexOf("EthereumJS TestRPC") >= 0)
    .then(() => {
            return RLC.new({
                from: rlcCreator,
                gas: amountGazProvided
            });
    })
    .then(instance => {
            aRLCInstance = instance;
        return aRLCInstance.unlock({
            from: rlcCreator,
            gas: amountGazProvided
        });
    })
    .then(txMined => {
            assert.isBelow(txMined.receipt.gasUsed, amountGazProvided, "should not use all gas");
        return IexecOracleEscrow.new(aRLCInstance.address, {
            from: bridge
        });
    })
    .then(instance => {
            aIexecOracleEscrowInstance = instance;

        return IexecOracle.new(aIexecOracleEscrowInstance.address, 0, {
            from: bridge
        });
    })
    .then(instance => {
            aIexecOracleInstance = instance;
        return IexecOracleAPI.new(aIexecOracleInstance.address, 0, "aDappName", {
            from: provider
        });

    })
    .then(instance => {
            aTimeClockInstance = instance;
    });


    });


    it("Test provider and dapp of IexecOracleAPI are set correctly in IexecOracle", function() {
        this.timeout(testTimemout);
        return aIexecOracleInstance.getProvider.call(aTimeClockInstance.address)
            .then(providerStored => {
            assert.strictEqual(dappProvider, providerStored, "dappProvider must be registered in IexecOracle for the aTimeClockInstance contract");
    });
    });

    

});
