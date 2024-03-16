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

  const newContract = await ethers.getContractFactory("CryptFyRouterV2Router02").then(f => f.deploy(
    '0x4200000000000000000000000000000000000023', // weth
    '0x4552427848C3741022Fe695439Ad2EF630f84Db7' // ref contract
  ))

  // const newContract = await ethers.getContractFactory("CryptFySwapRouter").then(f => f.deploy(
  //   '0x4200000000000000000000000000000000000023', // weth
  //   '0x4552427848C3741022Fe695439Ad2EF630f84Db7' // ref contract
  // ))

  // const newContract = await ethers.getContractFactory("Quoter").then(f => f.deploy())

  // const newContract = await ethers.getContractFactory("MultiCall").then(f => f.deploy())

  console.log("\n---------------------------DONE!-----------------------------")

  console.log(`new contract = '${newContract.address}'`)
}

module.exports.tags = ['all']

