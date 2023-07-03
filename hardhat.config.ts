import * as dotenv from "dotenv";

import { HardhatUserConfig, task } from "hardhat/config";
import "@nomiclabs/hardhat-etherscan";
import "@typechain/hardhat";
import "hardhat-gas-reporter";
import "solidity-coverage";
/* import "@openzeppelin/hardhat-upgrades"; */

dotenv.config();

const chainIds = {
  eth_sepolia_id: 11155111,
  eth_goerli_id: 5,
  polygon_mumbai_id: 80001,
  bsc_testnet_id: 97
};

// const { //This variables must be in the .env file, in order to work (like .env.example)
//   SIGNER_PRIVATE_KEY,
//   ETH_SEPOLIA_TESTNET_RPC,
//   ETH_GOERLI_TESTNET_RPC,
//   ETH_SCAN_API_KEY,
//   ETH_GOERLI_SCAN_WEB,
//   POLYGON_MUMBAI_TESTNET_RPC,
//   POLYGON_SCAN_API_KEY,
//   POLYGON_MUMBAI_SCAN_WEB,
//   BSC_TESTNET_RPC,
//   BSC_SCAN_API_KEY,
//   BSC_TESTNET_SCAN_WEB
// } = process.env;


// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

const config: HardhatUserConfig = {
  solidity: {
    version: "0.8.1",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      }
    }
  },
  networks: {
    localhost: {
      url: 'http://127.0.0.1:8545',
      gas: 8000000,
      forking: {
        url: "https://mainnet.infura.io/v3/3f0bb1548f9b47958ae43c7abb2caf3d"
      }
    },
    // ethereum_sepolia_testnet: {
    //   url: ETH_SEPOLIA_TESTNET_RPC,
    //   chainId: chainIds.eth_sepolia_id,
    //   accounts: SIGNER_PRIVATE_KEY !== undefined ? [SIGNER_PRIVATE_KEY] : []
    // }
  },
  // etherscan: {
  //   apiKey: {
  //     sepolia: ETH_SCAN_API_KEY
  //   }
  // },
  mocha: {
    timeout: 40000
  }
};

export default config;
