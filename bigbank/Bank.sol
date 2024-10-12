// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IBank.sol"; // 确保导入接口

contract Bank is IBank {
    address public admin;

    mapping(address => uint256) public deposits;
    address[3] public topDepositors;
    uint256[3] public topAmounts;

    constructor() {
        admin = msg.sender; // 合约部署者为管理员
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can withdraw");
        _;
    }

    function deposit() external payable override virtual { // 添加 virtual
        require(msg.value > 0, "You must send some ether");
        deposits[msg.sender] += msg.value;
        updateTopDepositors(msg.sender, deposits[msg.sender]);
    }

    function withdraw(uint256 amount) external override onlyAdmin {
        require(amount <= address(this).balance, "Insufficient balance");
        payable(admin).transfer(amount);
    }

    function getContractBalance() external view override returns (uint256) {
        return address(this).balance;
    }

    function updateTopDepositors(address user, uint256 amount) internal {
        for (uint256 i = 0; i < 3; i++) {
            if (amount > topAmounts[i]) {
                for (uint256 j = 2; j > i; j--) {
                    topDepositors[j] = topDepositors[j - 1];
                    topAmounts[j] = topAmounts[j - 1];
                }
                topDepositors[i] = user;
                topAmounts[i] = amount;
                break;
            }
        }
    }
}
