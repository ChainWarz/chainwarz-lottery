// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import {BaseSetup} from "./BaseSetup.t.sol";
import "forge-std/Test.sol";

contract CancelEntryTest is BaseSetup {
    function setUp() public virtual override {
        BaseSetup.setUp();
        uint maxEntries = 0;
        uint treasuryFeeInBps = 500; // 5%
        uint weeklyJackpotBattleInBps = 500;
        address[] memory nftCollectionWhitelist;

        startBattle(operator, maxEntries, treasuryFeeInBps, weeklyJackpotBattleInBps, nftCollectionWhitelist);
        multipleEntries();
    }

    function testCancelEntry() public {
        this.setUp();

        vm.startPrank(owner);

        linkToken.transfer(address(chainWarzLottery), 1 ether);
        vm.stopPrank();

        vm.startPrank(operator);

        uint8[] memory fixedArray = new uint8[](1);
        fixedArray[0] = 2;

        uint256[] memory entriesToCancel = new uint256[](fixedArray.length);

        for (uint256 i = 0; i < fixedArray.length; i++) {
            entriesToCancel[i] = uint256(fixedArray[i]);
        }

        uint256 battleId = 0;
        chainWarzLottery.cancelEntry(battleId, entriesToCancel, user3);
        vm.stopPrank();
    }
}
