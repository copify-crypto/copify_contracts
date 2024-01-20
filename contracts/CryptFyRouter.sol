// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";

contract CryptFyRouter is Ownable {
    address public immutable uniswapV2Router;

    constructor(address _uniswapV2RouterAddress) {
        uniswapV2Router = _uniswapV2RouterAddress;
    }

    function callRouter(
        bytes memory _data
    ) external payable returns (bytes memory) {
        (bool success, bytes memory returnData) = uniswapV2Router.call{value: msg.value}(_data);
        require(success);
        return returnData;
    }

    function withdraw() external onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }
} 