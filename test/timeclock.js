var IexecOracle = artifacts.require("./IexecOracle.sol");
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
        [dappProvider, dappUser, bridge, rlcCreator])
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
        console.log("aRLCInstance.address is ");
        console.log(aRLCInstance.address);
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
        console.log("aIexecOracleEscrowInstance.address is ");
        console.log(aIexecOracleEscrowInstance.address);
        return IexecOracle.new(aIexecOracleEscrowInstance.address, 0, {
          from: bridge
        });
      })
      .then(instance => {
        aIexecOracleInstance = instance;
        console.log("aIexecOracleInstance.address is ");
        console.log(aIexecOracleInstance.address);
        return TimeClock.new(aIexecOracleInstance.address, {
          from: dappProvider
        });
      })
      .then(instance => {
        aTimeClockInstance = instance;
        console.log("aTimeClockInstance.address is ");
        console.log(aTimeClockInstance.address);
      });
  });

  it("Geth mode example : test only launch when geth is used", function() {
    if (isTestRPC) this.skip("This test is only for geth");
  });

  it("TestRPC mode example : test only launch when testrpc is used", function() {
    if (!isTestRPC) this.skip("This test is only for TestRPC");
  });

  it("Test provider and dapp of TimeClock are set correctly in IexecOracle", function() {
    return aIexecOracleInstance.getProvider.call(aTimeClockInstance.address)
      .then(providerStored => {
        assert.strictEqual(dappProvider, providerStored, "dappProvider must be registered in IexecOracle for the aTimeClockInstance contract");
      });
  });

  it("Test initial employeeAtOffice ", function() {
    return aTimeClockInstance.employeeAtOffice.call()
      .then(employeeAtOfficeCall => {
        assert.strictEqual(employeeAtOfficeCall.toNumber(), 0, 'no employee at office at start');
      });
  });

  it("Test initial alarm state ", function() {
    return aTimeClockInstance.alarmActivated.call()
      .then(alarmActivatedCall => {
        assert.isTrue(alarmActivatedCall, 'alarm is activated by default');
      });
  });

  it("Test badgeIn function by dappUser", function() {
    let previousBlockNumber;
    let submitTxHash;
    return Extensions.getCurrentBlockNumber()
      .then(block => {
        previousBlockNumber = block;
        return aTimeClockInstance.badgeIn({
          from: dappUser,
          gas: amountGazProvided
        });
      })
      .then(txMined => {
        submitTxHash = txMined.tx;
        assert.isBelow(txMined.receipt.gasUsed, amountGazProvided, "should not use all gas");
        return Extensions.getEventsPromise(aIexecOracleInstance.Submit({}, {
          fromBlock: previousBlockNumber
        }));
      })
      .then(events => {
        //check event Submit for off-chain computing is well triggered
        //the Log is composed of : Submit(tx.origin, msg.sender,dappRegistry[msg.sender].provider, param);
        assert.strictEqual(events[0].args.user, dappUser, "dapp user address is wrong");
        assert.strictEqual(events[0].args.dapp, aTimeClockInstance.address, "dapp address is wrong");
        assert.strictEqual(events[0].args.provider, dappProvider, "dappProvider address is wrong ");
        assert.strictEqual(events[0].args.args, "--desactivate", " with first badge in a --desactivate action is sent to the alarm");
        return aTimeClockInstance.employeeAtOffice.call();
      })
      .then(employeeAtOfficeCall => {
        // check employee is now 1
        assert.strictEqual(employeeAtOfficeCall.toNumber(), 1, '1 employee present at office');
        //simulate bridge callback after off-chain computation done
        // function submitCallback(bytes32 submitTxHash, address user, address dapp, IexecLib.StatusEnum status, string stdout, string stderr, string uri) stopInEmergency public {
        return aIexecOracleInstance.submitCallback(submitTxHash, dappUser, aTimeClockInstance.address, IexecOracle.Status.COMPLETED, "OFF", "", "uri unused here", {
          from: bridge,
          gas: amountGazProvided
        });
      })
      .then(txMined => {
        assert.isBelow(txMined.receipt.gasUsed, amountGazProvided, "should not use all gas");
        return Extensions.getEventsPromise(aTimeClockInstance.IexecSubmitCallback({}, {
          fromBlock: previousBlockNumber
        }));
      })
      .then(events => {
        //check event IexecSubmitCallback is well triggered
        // the Log is composed of : IexecSubmitCallback(submitTxHash,user,stdout,uri);
        assert.strictEqual(events[0].args.submitTxHash, submitTxHash, "submitTxHash is wrong");
        assert.strictEqual(events[0].args.user, dappUser, "dappUser address is wrong");
        assert.strictEqual(events[0].args.stdout, "OFF", " OFF stdout must be generated by the off-chain app see the code here apps/TimeClock.py ");
        assert.strictEqual(events[0].args.uri, "uri unused here", "uri result not used here");
        return aTimeClockInstance.alarmActivated.call();
      })
      .then(alarmActivatedCall => {
        assert.isFalse(alarmActivatedCall, 'alarm has been desactivated thanks to the first badge in');
      });
  });



  describe("Test badgeOut function by dappUser", function() {
    beforeEach("Do a badgeIn call by dappUser before testing the badgeOut function", function() {
      let submitTxHashBadgeIn;
      return TimeClock.new(aIexecOracleInstance.address, {
          from: dappProvider
        })
        .then(instance => {
          aTimeClockInstance = instance;
          console.log("aTimeClockInstance.address is ");
          console.log(aTimeClockInstance.address);
          return aTimeClockInstance.badgeIn({
            from: dappUser,
            gas: amountGazProvided
          });
        })
        .then(txMined => {
          submitTxHashBadgeIn = txMined.tx;
          assert.isBelow(txMined.receipt.gasUsed, amountGazProvided, "should not use all gas");
          return aTimeClockInstance.employeeAtOffice.call();
        })
        .then(employeeAtOfficeCall => {
          assert.strictEqual(employeeAtOfficeCall.toNumber(), 1, '1 employee present at office');
          return aIexecOracleInstance.submitCallback(submitTxHashBadgeIn, dappUser, aTimeClockInstance.address, IexecOracle.Status.COMPLETED, "OFF", "", "uri unused here", {
            from: bridge,
            gas: amountGazProvided
          });
        })
        .then(txMined => {
          assert.isBelow(txMined.receipt.gasUsed, amountGazProvided, "should not use all gas");
          return aTimeClockInstance.alarmActivated.call();
        })
        .then(alarmActivatedCall => {
          assert.isFalse(alarmActivatedCall, 'alarm has been desactivated thanks to the first badge in');
          //load some fund to the aTimeClockInstance smart contract
          return Extensions.refillAccount(dappProvider, aTimeClockInstance.address, 5);
        })
        .then(() => web3.eth.getBalancePromise(aTimeClockInstance.address))
        .then(balance => assert.strictEqual(balance.toString(10), web3.toWei('5', 'ether').toString(10), "aTimeClockInstance has 10 ether to pay employees"));
    });

    it("Test getEmployeeBadgeInTime not null after badge In", function() {
      return aTimeClockInstance.getEmployeeBadgeInTime.call(dappUser)
        .then(dappUserBadgeInTime => {
          console.log("dappUserBadgeInTime is :");
          console.log(dappUserBadgeInTime.toNumber());
          assert.isBelow(0, dappUserBadgeInTime.toNumber(), "badge in time must be valorized");
        });
    });
/*
    it("Test badge out function call", function() {
      return aTimeClockInstance.badgeOut({
        from: dappUser,
        gas: amountGazProvided
      }).then(txMined => {
        assert.isBelow(txMined.receipt.gasUsed, amountGazProvided, "should not use all gas");
      });
    });*/

  });









});
