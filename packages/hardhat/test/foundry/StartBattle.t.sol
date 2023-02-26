// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import {BaseSetup} from "./BaseSetup.t.sol";
import "../../contracts/Lottery/ChainWarzLottery.sol";

contract StartBattleTest is BaseSetup {
    function setUp() public virtual override {
        BaseSetup.setUp();
    }

    function testStartBattle() public {
        this.setUp();

        uint maxEntries = 0;
        uint treasuryFeeInBps = 500; // 5%
        uint weeklyJackpotBattleInBps = 500;
        address[] memory nftCollectionWhitelist;

        startBattle(operator, maxEntries, treasuryFeeInBps, weeklyJackpotBattleInBps, nftCollectionWhitelist);
    }

    function testOnlyOperatorCanCall() public {
        this.setUp();

        uint maxEntries = 0;
        uint treasuryFeeInBps = 500; // 5%
        uint weeklyJackpotBattleInBps = 500;
        address[] memory nftCollectionWhitelist;

        vm.expectRevert(abi.encodePacked("Not operator"));
        startBattle(owner, maxEntries, treasuryFeeInBps, weeklyJackpotBattleInBps, nftCollectionWhitelist);

        vm.expectRevert(abi.encodePacked("Not operator"));
        startBattle(user, maxEntries, treasuryFeeInBps, weeklyJackpotBattleInBps, nftCollectionWhitelist);
    }

     function testRevertIfMoreThanMaxFee() public {
        this.setUp();

        uint maxEntries = 0;
        uint treasuryFeeInBps = 500; // 5%
        uint weeklyJackpotBattleInBps = 500;
        address[] memory nftCollectionWhitelist;

        vm.expectRevert(abi.encodePacked("treasury fee too high"));
        startBattle(operator, maxEntries, 3000, weeklyJackpotBattleInBps, nftCollectionWhitelist);

        vm.expectRevert(abi.encodePacked("WB contribution too high"));
        startBattle(operator, maxEntries, treasuryFeeInBps, 3000, nftCollectionWhitelist);
    }

    function testInitializesBatlleStruct() public {
        this.setUp();

        uint maxEntries = 0;
        uint treasuryFeeInBps = 500; // 5%
        uint weeklyJackpotBattleInBps = 500;
        address[] memory nftCollectionWhitelist;

        startBattle(operator, maxEntries, treasuryFeeInBps, weeklyJackpotBattleInBps, nftCollectionWhitelist);

        ChainWarzLottery.BattleStruct memory battle = chainWarzLottery.getBattle(0);


        // assertEq(battle.status, ChainWarzLottery.Status.Open);
        
    }
}
