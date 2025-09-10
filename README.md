# Hello World Payable Contract

This project is a step-by-step implementation of a hello world payable contract using Solidity and Foundry.

## Project Status

- [x] Initialize Foundry project
- [x] Create hello world payable Solidity contract
- [ ] Write tests for the contract
- [ ] Verify the contract works correctly

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
