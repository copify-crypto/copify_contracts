// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

interface IUniswapV2Router {
    function factory() external pure returns (address);
    function WETH() external pure returns (address);

    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;

    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
}

interface IUniswapV2Factory {
    function createPair(address tokenA, address tokenB) external returns (address pair);
}

contract TokenWithCommission is ERC20, Ownable {

    address public immutable uniswapV2Pair;

    uint256 public buyFee; // 100 = 10%
    uint256 public sellFee; // 100 = 10%

    constructor(
        string memory _name,
        string memory _symbol,
        address _uniswapV2RouterAddress,
        uint256 _totalSupply,
        uint256 _buyFee,
        uint256 _sellFee
    ) ERC20(_name, _symbol) {

        IUniswapV2Router _uniswapV2Router = IUniswapV2Router(_uniswapV2RouterAddress);
        uniswapV2Pair = IUniswapV2Factory(_uniswapV2Router.factory()).createPair(address(this), _uniswapV2Router.WETH());
        buyFee = _buyFee;
        sellFee = _sellFee;

        _mint(msg.sender, _totalSupply);

    }

    receive() external payable {}

    function withdrawETH() external onlyOwner returns (bool) {
        (bool success, ) = owner().call{value: address(this).balance}("");
        return success;
    }

    function mint(uint256 _amount) external onlyOwner {
        _mint(msg.sender, _amount);
    }

    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal override {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");

        if (amount == 0) {
            super._transfer(from, to, 0);
            return;
        }

        // only take fees on buys/sells, do not take on wallet transfers
        if (address(uniswapV2Pair) == to || address(uniswapV2Pair) == from) {
            uint256 fees = 0;
            // on sell
            if (address(uniswapV2Pair) == to && sellFee > 0) {
                fees = amount * buyFee / 1000;
            }
            // on buy
            else if (address(uniswapV2Pair) == from && buyFee > 0) {
                fees = amount * sellFee / 1000;
            }

            if (fees > 0) {
                super._transfer(from, owner(), fees);
            }

            amount -= fees;
        }

        super._transfer(from, to, amount);

    }

}
