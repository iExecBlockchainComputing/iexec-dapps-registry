'use strict';

var PowContract = artifacts.require("../contracts/PowContract.sol");

contract('PowContract', function(accounts) {

  it("should mint a new block", function() {
    return PowContract.deployed()
      .then(function(instance) {
        return instance.mint.call('0x01', '1');
      }).then(function(result){
        assert(result.toNumber()===655267856);
      });
  });

});
