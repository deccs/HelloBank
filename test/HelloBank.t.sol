// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {HelloBank} from "../src/HelloBank.sol";

contract HelloBankTest is Test {
    HelloBank public helloBank;
    address public owner = address(this);
    address public user1 = address(0x1);
    address public user2 = address(0x2);

    function setUp() public {
        helloBank = new HelloBank();
        
        // Fund test accounts with Ether
        vm.deal(user1, 10 ether);
        vm.deal(user2, 10 ether);
    }
    
    // Fallback function to receive Ether during tests
    receive() external payable {}

    function test_GetHelloWorld() public {
        // Test that getHelloWorld returns the correct message
        string memory expected = "Hello World!";
        string memory actual = helloBank.getHelloWorld();
        assertEq(actual, expected, "Incorrect greeting message");
        
        // Verify that the GreetingRequested event was emitted
        vm.expectEmit(true, false, false, true);
        emit HelloBank.GreetingRequested(owner, "Hello World!");
        helloBank.getHelloWorld();
    }

    function test_Deposit() public {
        // Test deposit with valid amount
        uint256 depositAmount = 1 ether;
        
        // Expect FundsReceived event to be emitted
        vm.expectEmit(true, false, false, true);
        emit HelloBank.FundsReceived(owner, depositAmount, "Funds received successfully");
        
        // Deposit funds
        helloBank.deposit{value: depositAmount}();
        
        // Check that contract balance increased
        assertEq(helloBank.getBalance(), depositAmount, "Contract balance incorrect after deposit");
    }

    function test_DepositZeroAmount() public {
        // Test that deposit with zero amount reverts
        vm.expectRevert(HelloBank.NoFundsSent.selector);
        helloBank.deposit{value: 0}();
    }

    function test_Receive() public {
        // Test receive function with direct transfer
        uint256 transferAmount = 1 ether;
        
        // Expect FundsReceived event to be emitted
        vm.expectEmit(true, false, false, true);
        emit HelloBank.FundsReceived(user1, transferAmount, "Funds received via fallback");
        
        // Direct transfer to contract
        vm.prank(user1);
        (bool success, ) = address(helloBank).call{value: transferAmount}("");
        assertTrue(success, "Direct transfer failed");
        
        // Check that contract balance increased
        assertEq(helloBank.getBalance(), transferAmount, "Contract balance incorrect after direct transfer");
    }

    function test_GetBalance() public {
        // Test getBalance with zero balance
        assertEq(helloBank.getBalance(), 0, "Initial balance should be zero");
        
        // Deposit some funds and check balance again
        uint256 depositAmount = 1 ether;
        helloBank.deposit{value: depositAmount}();
        assertEq(helloBank.getBalance(), depositAmount, "Balance incorrect after deposit");
    }

    function test_Withdraw() public {
        // Deposit funds first
        uint256 depositAmount = 1 ether;
        helloBank.deposit{value: depositAmount}();
        
        // Get balance before withdrawal
        uint256 balanceBefore = address(helloBank).balance;
        
        // Expect FundsWithdrawn event to be emitted
        vm.expectEmit(true, false, false, true);
        emit HelloBank.FundsWithdrawn(owner, balanceBefore);
        
        // Withdraw funds
        helloBank.withdraw();
        
        // Check that contract balance is zero
        assertEq(helloBank.getBalance(), 0, "Contract balance should be zero after withdrawal");
    }

    function test_WithdrawWithZeroBalance() public {
        // Test that withdraw with zero balance reverts
        vm.expectRevert(HelloBank.NoFundsSent.selector);
        helloBank.withdraw();
    }

    function test_MultipleDepositsAndWithdrawals() public {
        // Test multiple deposits from different users
        uint256 amount1 = 1 ether;
        uint256 amount2 = 2 ether;
        
        // User 1 deposits
        vm.prank(user1);
        helloBank.deposit{value: amount1}();
        assertEq(helloBank.getBalance(), amount1, "Balance incorrect after user1 deposit");
        
        // User 2 deposits
        vm.prank(user2);
        helloBank.deposit{value: amount2}();
        assertEq(helloBank.getBalance(), amount1 + amount2, "Balance incorrect after user2 deposit");
        
        // Owner withdraws all funds
        uint256 ownerBalanceBefore = owner.balance;
        helloBank.withdraw();
        
        // Check that contract balance is zero
        assertEq(helloBank.getBalance(), 0, "Contract balance should be zero after withdrawal");
        
        // Check that owner received the funds
        assertEq(owner.balance, ownerBalanceBefore + amount1 + amount2, "Owner did not receive correct amount");
    }

    function test_DepositAndReceiveTogether() public {
        // Test mixing deposit and receive functions
        uint256 depositAmount = 1 ether;
        uint256 receiveAmount = 2 ether;
        
        // Use deposit function
        helloBank.deposit{value: depositAmount}();
        
        // Use receive function
        vm.prank(user1);
        (bool success, ) = address(helloBank).call{value: receiveAmount}("");
        assertTrue(success, "Direct transfer failed");
        
        // Check total balance
        assertEq(helloBank.getBalance(), depositAmount + receiveAmount, "Balance incorrect after mixed deposits");
        
        // Withdraw all funds
        helloBank.withdraw();
        assertEq(helloBank.getBalance(), 0, "Contract balance should be zero after withdrawal");
    }
}