// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title HelloBank
 * @dev A simple hello world payable contract
 */
contract HelloBank {
    // Event to log when funds are received
    event FundsReceived(address indexed sender, uint256 amount, string message);
    
    // Event to log when a greeting is requested
    event GreetingRequested(address indexed requester, string message);
    
    // Error for when no funds are sent to payable function
    error NoFundsSent();
    
    // Error for when a zero address is provided
    error InvalidAddress();
    
    /**
     * @dev Payable function to receive Ether
     * Emits FundsReceived event
     */
    function deposit() public payable {
        if (msg.value == 0) {
            revert NoFundsSent();
        }
        
        emit FundsReceived(msg.sender, msg.value, "Funds received successfully");
    }
    
    /**
     * @dev Fallback function to receive Ether
     */
    receive() external payable {
        emit FundsReceived(msg.sender, msg.value, "Funds received via fallback");
    }
    
    /**
     * @dev Function to return a hello world message
     * Emits GreetingRequested event
     * @return string containing hello world message
     */
    function getHelloWorld() public returns (string memory) {
        string memory greeting = "Hello World!";
        emit GreetingRequested(msg.sender, greeting);
        return greeting;
    }
    
    /**
     * @dev Function to check the contract's balance
     * @return uint256 representing the contract's balance in wei
     */
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
    
    /**
     * @dev Function to withdraw all funds from the contract
     * Only the contract owner can withdraw
     * Emits FundsWithdrawn event
     */
    event FundsWithdrawn(address indexed to, uint256 amount);
    
    function withdraw() public {
        uint256 amount = address(this).balance;
        if (amount == 0) {
            revert NoFundsSent();
        }
        
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");
        
        emit FundsWithdrawn(msg.sender, amount);
    }
}