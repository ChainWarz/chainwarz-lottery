// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "forge-std/Test.sol";
import "../../contracts/test/LinkToken.sol";
import "../../contracts/Lottery/BlackListManager.sol";
import "../../contracts/test/MockOracle.sol";
import "../../contracts/Lottery/ChainWarzLottery.sol";
import "../../contracts/test/VRFCoordinatorMock.sol";

contract BaseSetup is Test {
    ChainWarzLottery public chainWarzLottery;
    LinkToken public linkToken;
    BlackListManager public blacklistManager;
    MockOracle public mockOracle;
    VRFCoordinatorMock public vrfCoordinatorMock;

    address public owner = address(0x1);
    address public operator = address(0x2);
    address public treasuryWallet = address(0x3);
    address public injector = address(0x4);
    address public user = address(0x5);
    address public user2 = address(0x6);
    address public user3 = address(0x7);
    address public user4 = address(0x8);
    address public user5 = address(0x9);
    address public user6 = address(0x10);

    bytes32 public keyHash = 0x6c3699283bda56ad74f6b855546325b68d482e983852a7a82979cc4807b641f4;
    bool public mainnetFee = false;

    function setUp() public virtual {
        vm.startPrank(owner);
        linkToken = new LinkToken();
        mockOracle = new MockOracle(address(linkToken));
        vrfCoordinatorMock = new VRFCoordinatorMock(address(linkToken));
        blacklistManager = new BlackListManager();
        chainWarzLottery = new ChainWarzLottery(
            address(blacklistManager),
            address(vrfCoordinatorMock),
            address(linkToken),
            treasuryWallet,
            operator,
            injector,
            keyHash,
            mainnetFee
        );

        vm.stopPrank();
    }

    function startBattle(
        address _user,
        uint maxEntries,
        uint treasuryFeeInBps,
        uint weeklyJackpotBattleInBps,
        address[] memory nftCollectionWhitelist
    ) public {
        vm.startPrank(_user);

        ChainWarzLottery.PriceStructure[5] memory fixedArray = [
            ChainWarzLottery.PriceStructure({id: 1, numEntries: 1, price: 0.008 ether}),
            ChainWarzLottery.PriceStructure({id: 2, numEntries: 5, price: 0.08 ether}),
            ChainWarzLottery.PriceStructure({id: 3, numEntries: 15, price: 0.1 ether}),
            ChainWarzLottery.PriceStructure({id: 4, numEntries: 50, price: 0.5 ether}),
            ChainWarzLottery.PriceStructure({id: 5, numEntries: 100, price: 0.8 ether})
        ];
        ChainWarzLottery.PriceStructure[] memory prices = new ChainWarzLottery.PriceStructure[](fixedArray.length);
        for (uint i = 0; i < fixedArray.length; i++) {
            prices[i] = fixedArray[i];
        }

        chainWarzLottery.startBattle(
            maxEntries,
            prices,
            treasuryFeeInBps,
            weeklyJackpotBattleInBps,
            nftCollectionWhitelist
        );
        vm.stopPrank();
    }

    function buyFighter(address _user, uint battleId, uint priceId, address collection, uint tokenIdUsed) public {
        vm.startPrank(_user);
        vm.deal(_user, 1 ether);

        chainWarzLottery.buyFighter{value: 0.008 ether}(battleId, priceId, collection, tokenIdUsed);
        vm.stopPrank();
    }

    function multipleEntries() public {
        uint battleId = 0;
        uint priceId = 1;
        address collection = address(0);
        uint tokenIdUsed = 0;

        buyFighter(user,  battleId, priceId, collection, tokenIdUsed);
        buyFighter(user2, battleId, priceId, collection, tokenIdUsed);
        buyFighter(user3, battleId, priceId, collection, tokenIdUsed);
        buyFighter(user4, battleId, priceId, collection, tokenIdUsed);
        buyFighter(user5, battleId, priceId, collection, tokenIdUsed);
        buyFighter(user6, battleId, priceId, collection, tokenIdUsed);
    }

    //create users with 100 ether balance
    function createUsers(uint256 userNum) public returns (address payable[] memory) {
        address payable[] memory _users = new address payable[](userNum);
        for (uint256 i = 0; i < userNum; i++) {
            address payable _user = this.getNextUserAddress();
            vm.deal(_user, 100 ether);
            _users[i] = _user;
        }
        return _users;
    }

    bytes32 internal nextUser = keccak256(abi.encodePacked("user address"));

    function getNextUserAddress() public returns (address payable) {
        //bytes32 to address conversion
        address payable user = payable(address(uint160(uint256(nextUser))));
        nextUser = keccak256(abi.encodePacked(nextUser));
        return user;
    }
}
