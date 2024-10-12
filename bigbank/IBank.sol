// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IBank {
    function deposit() external payable;
    function withdraw(uint256 amount) external;
    function getContractBalance() external view returns (uint256);
    function deposits(address user) external view returns (uint256);
}
