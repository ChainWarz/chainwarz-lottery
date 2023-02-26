// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import {BaseSetup} from "./BaseSetup.t.sol";

contract GiveBatchEntriesForFreeTest is BaseSetup {
    function setUp() public virtual override {
        BaseSetup.setUp();
        
        uint maxEntries = 0;
        uint treasuryFeeInBps = 500; // 5%
        uint weeklyJackpotBattleInBps = 500;
        address[] memory nftCollectionWhitelist;

        startBattle(operator, maxEntries, treasuryFeeInBps, weeklyJackpotBattleInBps, nftCollectionWhitelist);
        multipleEntries();
    }

    function testGiveBatchEntriesForFree() public {
        this.setUp();

        vm.startPrank(operator);

        address[3] memory fixedArray = [user4, user5, user6];

        address[] memory freePlayers = new address[](fixedArray.length);
        for (uint i = 0; i < fixedArray.length; i++) {
            freePlayers[i] = fixedArray[i];
        }

        chainWarzLottery.giveBatchEntriesForFree(0, freePlayers);

        vm.stopPrank();
    }
}
