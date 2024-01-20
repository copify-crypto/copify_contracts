const {
  time,
  loadFixture,
} = require("@nomicfoundation/hardhat-network-helpers");
const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Lock", function () {

  let owner, users
  let contract
  let router

  this.beforeAll(async function () {
    [owner, ...users] = await ethers.getSigners();
    router = await ethers.getContractFactory("UniswapV2Router02").then(f => f.deploy(owner.address, owner.address))
  })

  it("main test", async function () {
    console.log((await ethers.getContractFactory("TokenWithCommission")).bytecode)
    console.log("router address", router.address)
  });

});
