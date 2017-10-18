pragma solidity ^0.4.17;

import "ds-test/test.sol";

import "./cron.sol";

contract CronTest is DSTest {
    Cron cron;

    function setUp() {
        cron = new Cron();
    }

    function testFail_basic_sanity() {
        assertTrue(false);
    }

    function test_basic_sanity() {
        assertTrue(true);
    }
}
