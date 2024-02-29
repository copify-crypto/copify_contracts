// SPDX-License-Identifier: MIT
pragma solidity >=0.7.6;

interface ICryptFyRouter_Ref {

    function owner() external view returns (address);
    function fee() external view returns (uint256);
    function blast() external view returns (address);
    function getFeeAmountForValue(uint256 value) external view returns (uint256);
    function getBodyWithoutFee(uint256 value) external view returns (uint256);
    function getFullAmount(uint256 value) external view returns (uint256);

}