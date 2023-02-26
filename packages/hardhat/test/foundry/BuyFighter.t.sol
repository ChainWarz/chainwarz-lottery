// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import {BaseSetup} from "./BaseSetup.t.sol";
import "../../contracts/Lottery/ChainWarzLottery.sol";

contract BuyFighterTest is BaseSetup {
    function setUp() public virtual override {
        BaseSetup.setUp();
        uint maxEntries = 0;
        uint treasuryFeeInBps = 500; // 5%
        uint weeklyJackpotBattleInBps = 500;
        address[] memory nftCollectionWhitelist;

        startBattle(operator, maxEntries, treasuryFeeInBps, weeklyJackpotBattleInBps, nftCollectionWhitelist);
    }

    function testBuyFighter() public {
        this.setUp();
        vm.startPrank(user);
        vm.deal(user, 1 ether);
        uint battleId = 0;
        uint id = 1;
        address collection = address(0);
        uint tokenIdUsed = 0;
        chainWarzLottery.buyFighter{value: 0.008 ether}(battleId, id, collection, tokenIdUsed);
        vm.stopPrank();
    }
}
