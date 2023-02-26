type NetworkConfigItem = {
    name: string;
    vrfCoordinator: string;
    treasuryWallet: string;
    linkToken: string;
    keyHash: string;
    operatorAddress: string;
    blacklistManager: string;
    mainnetFee: boolean;
};

type NetworkConfigMap = {
    [chainId: string]: NetworkConfigItem;
};

// https://docs.chain.link/vrf/v2/subscription/supported-networks

export const networkConfig: NetworkConfigMap = {
    default: {
        name: "hardhat",
        vrfCoordinator: "",
        treasuryWallet: "",
        linkToken: "",
        keyHash: "0x6c3699283bda56ad74f6b855546325b68d482e983852a7a82979cc4807b641f4",
        operatorAddress: "",
        blacklistManager: "",
        mainnetFee: false,
    },
    31337: {
        name: "localhost",
        vrfCoordinator: "",
        treasuryWallet: "",
        linkToken: "",
        keyHash: "0x6c3699283bda56ad74f6b855546325b68d482e983852a7a82979cc4807b641f4",
        operatorAddress: "",
        blacklistManager: "",
        mainnetFee: false,
    },
    5: {
        name: "goerli",
        vrfCoordinator: "0x2Ca8E0C643bDe4C2E08ab1fA0da3401AdAD7734D",
        treasuryWallet: "",
        linkToken: "0x326C977E6efc84E512bB9C30f76E30c160eD06FBSwitch network and add to wallet",
        keyHash: "0x79d3d8832d904592c0bf9818b621522c988bb8b0c05cdc3b15aea1b6e8db0c15",
        operatorAddress: "",
        blacklistManager: "",
        mainnetFee: false,
    },
    1: {
        name: "mainnet",
        vrfCoordinator: "0x271682DEB8C4E0901D1a1550aD2e64D568E69909",
        treasuryWallet: "",
        linkToken: "0x514910771AF9Ca656af840dff83E8264EcF986CA",
        keyHash: "0x9fe0eebf5e446e3c998ec9bb19951541aee00bb90ea201ae456421a2ded86805",
        operatorAddress: "",
        blacklistManager: "",
        mainnetFee: true,
    },
};

export const developmentChains: string[] = ["hardhat", "localhost"];
export const VERIFICATION_BLOCK_CONFIRMATIONS = 6;
