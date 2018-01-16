var IexecOracle = artifacts.require("./IexecOracle.sol");
var IexecOracleEscrow = artifacts.require("./IexecOracleEscrow.sol");
var Ffmpeg = artifacts.require("./Ffmpeg.sol");
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

contract('Ffmpeg', function(accounts) {

  var dappProvider, dappUser, bridge, rlcCreator;
  var amountGazProvided = 4000000;
  let isTestRPC;
  let testTimemout = 0;
  let aRLCInstance;
  let aIexecOracleEscrowInstance;
  let aFfmpegInstance;

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
        web3.toWei(web3.toBigNumber(40), "ether").lessThan(balance),
        "dappProvider should have at least 40 ether, not " + web3.fromWei(balance, "ether")))
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
        return Ffmpeg.new(aIexecOracleInstance.address, {
          from: dappProvider
        });
      })
      .then(instance => {
        aFfmpegInstance = instance;
        console.log("aFfmpegInstance.address is ");
        console.log(aFfmpegInstance.address);
      });
  });

  it("Geth mode example : test only launch when geth is used", function() {
    if (isTestRPC) this.skip("This test is only for geth");
  });

  it("TestRPC mode example : test only launch when testrpc is used", function() {
    if (!isTestRPC) this.skip("This test is only for TestRPC");
  });



  it("Test iexecSubmit function", function() {
    let previousBlockNumber;
    let submitTxHash;
    return Extensions.getCurrentBlockNumber()
      .then(block => {
        previousBlockNumber = block;
        return aFfmpegInstance.iexecSubmit("{ \"cmdline\": \"-i small.mp4 small.avi\", \"dirinuri\": \"http://techslides.com/demos/sample-videos/small.mp4\" }", {
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
        assert.strictEqual(events[0].args.dapp, aFfmpegInstance.address, "dapp address is wrong");
        assert.strictEqual(events[0].args.provider, dappProvider, "dappProvider address is wrong ");
        assert.strictEqual(events[0].args.args, "{ \"cmdline\": \"-i small.mp4 small.avi\", \"dirinuri\": \"http://techslides.com/demos/sample-videos/small.mp4\" }", "submit task params");
        //simulate bridge callback after off-chain computation done
        // function submitCallback(bytes32 submitTxHash, address user, address dapp, IexecLib.StatusEnum status, string stdout, string stderr, string uri) stopInEmergency public {
        return aIexecOracleInstance.submitCallback(submitTxHash, dappUser, aFfmpegInstance.address, IexecOracle.Status.COMPLETED, "", "", "uri_with_the_result_to_download", {
          from: bridge,
          gas: amountGazProvided
        });
      })
      .then(txMined => {
        assert.isBelow(txMined.receipt.gasUsed, amountGazProvided, "should not use all gas");
        return Extensions.getEventsPromise(aIexecOracleInstance.SubmitCallback({}, {
          fromBlock: previousBlockNumber
        }));
      })
      .then(events => {
        //check event IexecSubmitCallback is well triggered in IexecOracle
        // the Log is composed of : SubmitCallback(submitTxHash,user,stdout,uri);
        assert.strictEqual(events[0].args.submitTxHash, submitTxHash, "submitTxHash is wrong");
        assert.strictEqual(events[0].args.user, dappUser, "dappUser address is wrong");
        assert.strictEqual(events[0].args.stdout, "", " ");
        assert.strictEqual(events[0].args.uri, "uri_with_the_result_to_download", "uri_with_the_result_to_download");
        return Extensions.getEventsPromise(aFfmpegInstance.IexecSubmitCallback({}, {
          fromBlock: previousBlockNumber
        }));
      })
      .then(events => {
        //check event IexecSubmitCallback is well triggered in the dapp aFfmpegInstance
        // the Log is composed of : IexecSubmitCallback(submitTxHash,user,stdout,uri);
        assert.strictEqual(events[0].args.submitTxHash, submitTxHash, "submitTxHash is wrong");
        assert.strictEqual(events[0].args.user, dappUser, "dappUser address is wrong");
        assert.strictEqual(events[0].args.stdout, "", " ");
        assert.strictEqual(events[0].args.uri, "uri_with_the_result_to_download", "uri_with_the_result_to_download");
      });
  });


});
