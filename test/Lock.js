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

  this.beforeAll(async function () {
    [owner, ...users] = await ethers.getSigners();
  })

  it("main test", async function () {
    console.log((await ethers.getContractFactory("TokenWithCommission")).bytecode)
  });

});
