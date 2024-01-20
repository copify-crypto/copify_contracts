const { run, ethers, upgrades } = require('hardhat');

module.exports = async () => {

  const factory = "0x8E45E698dc79E6ca3689C076eC1AF49DFdc73748"
  const weth = "0x4200000000000000000000000000000000000023"
  const univ2Router = "0xc242c1aDc66b60ee1146D7d7Ef55545b99B6Bc6a"

  const verify = async (address, args) => {
    await sleep(30);

    try {
      await run('verify', {
        address: address,
        constructorArguments: args.toString().replace(/,/g, " ")
      });
    } catch (e) {console.log(e)}
  };

  await run('clean');
  await run('compile');

  console.log("----------------------Deployment stage------------------------")

  const uniswapRouter = await ethers.getContractFactory("CryptFyRouter").then(f => f.deploy(univ2Router))

  console.log("\n---------------------------DONE!-----------------------------")

  console.log(`uniswapRouter    = '${uniswapRouter.address}'`)
}

module.exports.tags = ['all']

