import { HardhatRuntimeEnvironment } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/types";
import { ethers } from "hardhat";
const { networkConfig } = require("../helper-hardhat-config");

const deployBlackListManager: DeployFunction = async function ({ getNamedAccounts, deployments, getChainId }) {
    const { deploy, get, log } = deployments;
    const { deployer } = await getNamedAccounts();
    const chainId = await getChainId();

    const lottery = await deploy("BlackListManager", {
        from: deployer,
        args: [],
        log: true,
    });

    log("----------------------------------------------------");
    log("BlackListManager contract address is: ", lottery.address);
    log("----------------------------------------------------");
};

export default deployBlackListManager;

// Tags are useful if you have multiple deploy files and only want to run one of them.
// e.g. yarn deploy --tags YourContract
deployBlackListManager.tags = ["all", "blacklist"];
