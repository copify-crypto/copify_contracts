/**
 * @type import('hardhat/config').HardhatUserConfig
 */

require("@nomicfoundation/hardhat-toolbox")
require('@openzeppelin/hardhat-upgrades');
require("hardhat-deploy");
require("hardhat-gas-reporter");
require('hardhat-contract-sizer');
require("@nomicfoundation/hardhat-network-helpers");
require("hardhat-tracer");
require("solidity-coverage");

require("dotenv").config();

const CUSTOM_RPC_URL = process.env.CUSTOM_RPC_URL || "";
const ETHERSCAN_API_KEY = process.env.ETHERSCAN_API_KEY || "";
const PRIVATE_KEY = process.env.PRIVATE_KEY || "";

module.exports = {
    defaultNetwork: "hardhat",
    networks: {
        hardhat: {},
        goerli: {
            url: CUSTOM_RPC_URL,
            accounts: [PRIVATE_KEY]
         },
         eth: {
            url: CUSTOM_RPC_URL,
            accounts: [PRIVATE_KEY]
         },
         arb: {
            url: CUSTOM_RPC_URL,
            accounts: [PRIVATE_KEY]
         },
         blast_sepolia: {
          url: CUSTOM_RPC_URL,
          accounts: [PRIVATE_KEY]
       }
    },
    etherscan: {
      apiKey: {
        blast_sepolia: "blast_sepolia", // apiKey is not required, just set a placeholder
      },
      customChains: [
        {
          network: "blast_sepolia",
          chainId: 168587773,
          urls: {
            apiURL: "https://api.routescan.io/v2/network/testnet/evm/168587773/etherscan",
            browserURL: "https://testnet.blastscan.io"
          }
        }
      ]
    },
    solidity: {
        compilers: [
          {
            version: "0.8.22",
        },
            {
                version: "0.8.13",
            },
            {
                version: "0.8.10",
            },
            {
                version: "0.8.9",
            },
            {
                version: "0.8.4",
            },
            {
                version: "0.8.0",
            },
            {
              version: "0.6.11",
            },
            {
              version: "0.6.6",
            },
        ],
        settings: {
          optimizer: {
            enabled: true,
            runs: 999999,
          },
         }
    },
    mocha: {
        timeout: 10000000,
    },

    gasReporter: {
       enabled: true,
       gasPrice: 10,
       currency: 'USD',
       coinmarketcap: '2f0fe43a-0f3d-40a6-8558-ddd3625bfd6b',
   },
};
