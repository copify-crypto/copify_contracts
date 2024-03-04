const { run, ethers } = require('hardhat');

module.exports = async () => {

  await run('clean');
  await run('compile');

  console.log("----------------------Deployment stage------------------------")

  // const newContract = await ethers.getContractFactory("CryptFyRouter_Ref").then(f => f.deploy(
  //   '0xD79f479f56Dac4E4102f4189Ae550adc391eb167', // owner
  //   10, // fee
  //   ethers.constants.AddressZero, // signer
  //   "0x4300000000000000000000000000000000000002" // blast
  // ))

  // const newContract = await ethers.getContractFactory("CryptFyRouterV2Router02").then(f => f.deploy(
  //   '0x1d7c894F0a2DBFfB9c8A1B854Fa26bfAdb95a7DF', // factory
  //   '0x4200000000000000000000000000000000000023', // weth
  //   '0xAE8668dc89e7e8A2918D7Eb9ff59aBD9E883B9fD' // ref contract
  // ))

  // const newContract = await ethers.getContractFactory("CryptFySwapRouter").then(f => f.deploy(
  //   '0xe05c310A68F0D3A30069A20cB6fAeD5612C70c88', // factory
  //   '0x4200000000000000000000000000000000000023', // weth
  //   '0xAE8668dc89e7e8A2918D7Eb9ff59aBD9E883B9fD' // ref contract
  // ))

  const newContract = await ethers.getContractFactory("Quoter").then(f => f.deploy())

  console.log("\n---------------------------DONE!-----------------------------")

  console.log(`new contract = '${newContract.address}'`)
}

module.exports.tags = ['all']

