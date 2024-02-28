const { run, ethers, upgrades } = require('hardhat');

module.exports = async () => {

  await run('clean');
  await run('compile');

  console.log("----------------------Deployment stage------------------------")

  const newContract = await ethers.getContractFactory("contract_name").then(f => f.deploy())

  console.log("\n---------------------------DONE!-----------------------------")

  console.log(`new contract = '${newContract.address}'`)
}

module.exports.tags = ['all']

