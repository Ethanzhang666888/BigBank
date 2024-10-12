// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Bank.sol"; // 确保导入 Bank 合约

contract BigBank is Bank {
    modifier minDeposit() {
        require(msg.value > 0.001 ether, "Minimum deposit is 0.001 ether");
        _;
    }

    // function deposit1() external payable override minDeposit { // 添加 minDeposit 修饰符
    //     deposit(); // 调用父合约的 deposit 方法
    // }

    receive() external payable {} // 支持直接转账到 BigBank 合约


    function transferAdmin(address newAdmin) external onlyAdmin {
        require(newAdmin != address(0), "Invalid address");
        admin = newAdmin;
    }
}
