// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import {BaseSetup} from "./BaseSetup.t.sol";

contract EndBattleTest is BaseSetup {
    function setUp() public virtual override {
        BaseSetup.setUp();
        uint maxEntries = 0;
        uint treasuryFeeInBps = 500; // 5%
        uint weeklyJackpotBattleInBps = 500;
        address[] memory nftCollectionWhitelist;

        startBattle(operator, maxEntries, treasuryFeeInBps, weeklyJackpotBattleInBps, nftCollectionWhitelist);
        multipleEntries();
    }

    function testEndBattle() public {
        this.setUp();

        vm.startPrank(owner);

        linkToken.transfer(address(chainWarzLottery), 1 ether);
        vm.stopPrank();

        vm.startPrank(operator);

        chainWarzLottery.endBattle(0);
        vm.stopPrank();
    }
}
