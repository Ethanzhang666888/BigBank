// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IBank.sol";

contract Admin {
    address public owner;

    constructor() {
        owner = msg.sender; // 合约部署者为拥有者
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    receive() external payable {} // 支持直接转账到 BigBank 合约


    function adminWithdraw(IBank bank) external onlyOwner {
        uint256 balance = bank.getContractBalance();
        bank.withdraw(balance); // 调用 IBank 接口的 withdraw 方法
    }

    // 转移 Admin 合约的拥有者
    function transferOwnership(address newOwner) external onlyOwner {
        owner = newOwner;
    }
}
