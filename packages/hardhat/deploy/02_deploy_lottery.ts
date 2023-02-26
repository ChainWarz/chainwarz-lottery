import { HardhatRuntimeEnvironment } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/types";
import { ethers } from "hardhat";
const { networkConfig } = require("../helper-hardhat-config");

const deployChainWarzLottery: DeployFunction = async function ({ getNamedAccounts, deployments, getChainId }) {
    const { deploy, get, log } = deployments;
    const { deployer } = await getNamedAccounts();
    const chainId = await getChainId();
    const OPERATOR_ADDRESS = process.env.OPERATOR_ADDRESS;
    const INJECTOR_ADDRESS = process.env.INJECTOR_ADDRESS;
    const TREASURY_ADDRESS = process.env.TREASURY_ADDRESS;
    let operatorAddress;
    let injectorAddress;
    let treasuryWallet;
    let linkToken;
    let VRFCoordinatorMock;
    let linkTokenAddress;
    let vrfCoordinatorAddress;
    let additionalMessage = "";

    log("ChainId: ", chainId);

    if (chainId == undefined) {
        log("Chain id is undefined. Returning");
        return;
    }

    if (+chainId == 31337) {
        linkToken = await get("LinkToken");
        VRFCoordinatorMock = await get("VRFCoordinatorMock");
        linkTokenAddress = linkToken.address;
        vrfCoordinatorAddress = VRFCoordinatorMock.address;
        additionalMessage = " --linkaddress " + linkTokenAddress;
        operatorAddress = deployer;
        injectorAddress = deployer;
        treasuryWallet = deployer;
    } else {
        if (OPERATOR_ADDRESS == undefined || INJECTOR_ADDRESS == undefined || TREASURY_ADDRESS == undefined) {
            log("Addresses in Evn are not setup");
            return;
        }
        linkTokenAddress = networkConfig[chainId]["linkToken"];
        vrfCoordinatorAddress = networkConfig[chainId]["vrfCoordinator"];
        operatorAddress = OPERATOR_ADDRESS;
        injectorAddress = INJECTOR_ADDRESS;
        treasuryWallet = TREASURY_ADDRESS;
    }
    const keyHash = networkConfig[chainId]["keyHash"];
    const isMainnet = networkConfig[chainId]["mainnetFee"];

    const BlackListManager = await get("BlackListManager");

    log("BlackListManager", BlackListManager.address);

    const args = [
        BlackListManager.address,
        vrfCoordinatorAddress,
        linkTokenAddress,
        treasuryWallet,
        operatorAddress,
        injectorAddress,
        keyHash,
        isMainnet,
    ];

    const lottery = await deploy("ChainWarzLottery", {
        from: deployer,
        args: args,
        log: true,
    });

    log("args:", args);

    log("Run the following command to fund contract with LINK:");
    log(
        "npx hardhat fund-link --contract " +
            lottery.address +
            " --network " +
            networkConfig[chainId]["name"] +
            additionalMessage,
    );
    log("Then run RandomNumberConsumer contract with the following command");
    log(
        "npx hardhat request-random-number --contract " +
            lottery.address +
            " --network " +
            networkConfig[chainId]["name"],
    );
    log("----------------------------------------------------");
};

export default deployChainWarzLottery;

// Tags are useful if you have multiple deploy files and only want to run one of them.
// e.g. yarn deploy --tags YourContract
deployChainWarzLottery.tags = ["all", "lottery"];
