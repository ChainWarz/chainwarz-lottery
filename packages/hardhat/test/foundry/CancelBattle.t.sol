// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import {BaseSetup} from "./BaseSetup.t.sol";

contract CancelBattleTest is BaseSetup {
    function setUp() public virtual override {
        BaseSetup.setUp();
        uint maxEntries = 0;
        uint treasuryFeeInBps = 500; // 5%
        uint weeklyJackpotBattleInBps = 500;
        address[] memory nftCollectionWhitelist;

        startBattle(operator, maxEntries, treasuryFeeInBps, weeklyJackpotBattleInBps, nftCollectionWhitelist);
    }

    function testCancelBattle() public {
        this.setUp();
        vm.startPrank(operator);
        uint battleId = 0;
        chainWarzLottery.cancelBattle(battleId);
        vm.stopPrank();
    }
}
