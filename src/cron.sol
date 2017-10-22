// Copyright (C) 2017 dc@log-ix.com

// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND (express or implied).

pragma solidity ^0.4.17;

// Note: Code is incomplete and un-tested and should be treated as
// descriptive only.

import "iexec-oracle-contract/contracts/IexecOracleAPI.sol";
import "ds-thing/thing.sol";

contract Cron is DSAuth, DSNote, IexecOracleAPI {

  uint public constant DAPP_PRICE = 0;

  struct Task {
      address src;  // msg.sender
      address dst;  // target contract
      bytes32 sig;  // function signature
      string code;  // ipfs hash
      uint rpt;     // block interval
  }

  Task[] public tasks;

  function Cron (address _iexec) IexecOracleAPI(_iexec, DAPP_PRICE) {
      owner = msg.sender;
  }

  function schedule(
    address dst_,
    string  sig_,
    string  code_,
    uint    rpt_
  ) public note returns (uint) {
      Task storage t = Task({src: msg.sender, dst: dst_, code: code_, rpt: rpt_});
      tasks.push(t);
      iexecSubmit("cron", t);
      return tasks.length-1;
  }

  function unschedule(uint id) public note returns (bool) {
      Task storage t = tasks[id];
      require(t.owner == msg.sender);
      tasks[id] = "";
      // flush iExec task
      // etc.
  }

  function execute(address dst_, bytes32 sig_) auth returns (bool) {
    dst_.call(bytes4(keccak256(sig_)));
  }

}
