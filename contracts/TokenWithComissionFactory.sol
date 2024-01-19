// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./TokenWithCommission.sol";

import "hardhat/console.sol";

contract TokenWithCommissionFactory {

    IUniswapV2Router public immutable uniswapV2Router;

    constructor(address _uniswapV2RouterAddress) {
        uniswapV2Router = IUniswapV2Router(_uniswapV2RouterAddress);
    }

    function deployToken(
        string memory _name,
        string memory _symbol,
        uint256 _totalSupply,
        address _treasuryWallet,
        address _refSystemWallet,
        uint256 _tokensForLiquidity
    ) external payable returns (address) {
        TokenWithCommission token = new TokenWithCommission(
            _name,
            _symbol,
            address(uniswapV2Router),
            _totalSupply,
            _treasuryWallet,
            _refSystemWallet
        );

        token.approve(address(uniswapV2Router), _tokensForLiquidity);
        uniswapV2Router.addLiquidityETH{value: msg.value}(
            address(token),
            _tokensForLiquidity,
            0,
            0,
            msg.sender,
            block.timestamp
        );

        (bool success, ) = address(token).call(abi.encodeWithSelector(IERC20.transfer.selector, msg.sender, _totalSupply - _tokensForLiquidity));
        require(success);

        return address(token);
    }
}