// SPDX-License-Identifier: MIT
pragma solidity >=0.7.6;

import "./interfaces/ICryptFyRouter_Ref.sol";

contract CryptFyRouter_Ref is ICryptFyRouter_Ref {

    address public override owner;
    uint256 public override fee; // 10 = 1%
    address public override blast;
    
    address public signer;

    struct SignatureVerifyParams {
        address user;
        uint256 amount;
        uint256 deadline;
        uint8 v;
        bytes32 r;
        bytes32 s;
    }

    constructor(address _owner, uint256 _fee, address _signer, address _blast) {
        owner = _owner;
        fee = _fee;
        signer = _signer;
        blast = _blast;
    }

    function setOwner(address _owner) external {
        require(msg.sender == owner, "CryptFyRouter_Ref: NO");
        owner = _owner;
    }

    function setFee(uint256 _fee) external {
        require(msg.sender == owner, "CryptFyRouter_Ref: NO");
        fee = _fee;
    }

    function setSigner(address _signer) external {
        require(msg.sender == owner, "CryptFyRouter_Ref: NO");
        signer = _signer;
    }

    function setBlast(address _blast) external {
        require(msg.sender == owner, "CryptFyRouter_Ref: NO");
        blast = _blast;
    }

    function getFeeAmountForValue(uint256 value) public override view returns (uint256) {
        return (value * fee) / 1000;
    }

    function getBodyWithoutFee(uint256 value) external override view returns (uint256) {
        return value - getFeeAmountForValue(value);
    }

    function getFullAmount(uint256 value) external override view returns (uint256) {
        return value / (1000 - fee) * 1000;
    }

    receive() external payable {}

    function withdraw(uint256 _amount) external {
        require(msg.sender == owner, "CryptFyRouter_Ref: NO");
        payable(owner).transfer(_amount);
    }

    function _validSignature(SignatureVerifyParams memory input) internal view {
        bytes32 prefixedHashMessage = keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", keccak256(abi.encodePacked(
            input.user,
            input.amount,
            input.deadline
        ))));

        require(ecrecover(prefixedHashMessage, input.v, input.r, input.s) == signer, "CryptFyRouter_Ref: INVALID_SIGNATURE");
        require(input.deadline >= block.timestamp, "CryptFyRouter_Ref: DEADLINE");

    }

    function claimFees(
        uint256 _amount,
        uint256 _deadline,
        uint8 _v,
        bytes32 _r,
        bytes32 _s
    ) external {
        _validSignature(SignatureVerifyParams({
            user: msg.sender,
            amount: _amount,
            deadline: _deadline,
            v: _v,
            r: _r,
            s: _s
        }));

        payable(msg.sender).transfer(_amount);
    }

}