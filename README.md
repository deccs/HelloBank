# Hello World Payable Contract

This project is a step-by-step implementation of a hello world payable contract using Solidity and Foundry.

## Project Status

- [x] Initialize Foundry project
- [x] Create hello world payable Solidity contract
- [x] Write tests for the contract
- [x] Verify the contract works correctly

## HelloBank Contract

The HelloBank contract is a simple hello world payable contract implemented in Solidity. It demonstrates basic functionality for receiving and managing Ether within a smart contract.

### Features

- **Payable Functions**: The contract includes a `deposit()` function and a `receive()` fallback function to accept Ether transfers.
- **Hello World Message**: The `getHelloWorld()` function returns a greeting message.
- **Balance Check**: The `getBalance()` function allows checking the contract's current Ether balance.
- **Withdraw Function**: The `withdraw()` function allows users to withdraw their funds from the contract.
- **Event Logging**: The contract emits events for important actions like receiving funds and requesting greetings.
- **Error Handling**: Custom errors are implemented for better error handling and gas efficiency.

### Contract Details

- **File Location**: [`src/HelloBank.sol`](src/HelloBank.sol)
- **Solidity Version**: ^0.8.19
- **License**: MIT

### Test Suite

The HelloBank contract has a comprehensive test suite written in Solidity using Foundry's testing framework. The tests cover all functions and edge cases:

- **File Location**: [`test/HelloBank.t.sol`](test/HelloBank.t.sol)
- **Test Coverage**:
  - `getHelloWorld()`: Verifies the function returns the correct greeting message and emits the appropriate event
  - `deposit()`: Tests that the function correctly receives Ether and updates the balance, including error handling for zero amounts
  - `receive()`: Tests the fallback function correctly handles direct Ether transfers
  - `getBalance()`: Verifies the function returns the correct contract balance
  - `withdraw()`: Tests that the function correctly transfers funds to the owner and handles zero balance scenarios
  - **Event Testing**: All events are tested to ensure they're emitted with the correct parameters
  - **Integration Tests**: Tests multiple deposits and withdrawals to ensure the contract works correctly in complex scenarios

## Verification Results

The HelloBank contract has been thoroughly tested and verified to work correctly. Here's a summary of the verification process:

### Test Results

- **Total Tests**: 9 tests for HelloBank contract + 2 tests for Counter contract
- **Passing Tests**: 11 tests (100% pass rate)
- **Failing Tests**: 0
- **Test Coverage**: All functions and edge cases covered

### Issues Fixed

During verification, the following issues were identified and fixed:

1. **Test Account Funding**: Test accounts (user1, user2) were not funded with Ether, causing "OutOfFunds" errors in tests involving transfers.
   - **Solution**: Added `vm.deal()` calls in the `setUp()` function to fund test accounts with 10 Ether each.

2. **Missing Fallback Function**: The test contract didn't have a fallback function to receive Ether during withdrawal tests.
   - **Solution**: Added a `receive()` external payable function to the test contract.

3. **Access Control Vulnerability**: The `withdraw()` function allowed anyone to withdraw funds, not just the owner, despite the comment stating only the owner could withdraw.
   - **Solution**: Implemented proper access control with:
     - Added an `owner` state variable
     - Added an `onlyOwner` modifier
     - Added an `Unauthorized` custom error
     - Added a constructor to set the owner
     - Applied the `onlyOwner` modifier to the `withdraw()` function

### Best Practices Verification

The contract has been verified to follow Solidity best practices:

- ✅ SPDX License Identifier included
- ✅ Specific pragma version used
- ✅ Proper NatSpec documentation
- ✅ Custom errors instead of string messages for revert conditions
- ✅ Events for important actions
- ✅ Explicit function visibility specifiers
- ✅ Proper state mutability markings
- ✅ Checks-Effects-Interactions pattern followed
- ✅ Safe transfer with `.call()` and return value check
- ✅ Access control implemented for sensitive functions

### Compilation

The contract compiles successfully without any errors using Solidity 0.8.30.

## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
