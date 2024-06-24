# Nikhilcoin Contract

This repository contains the Solidity code for the Nikhilcoin smart contract. Nikhilcoin is a basic implementation of a custom token with functionalities for minting, burning, and transferring tokens. The contract follows basic principles similar to ERC20 without strictly adhering to the standard.
Nikhilcoin is an ERC20 token contract that allows for the creation, transfer, and management of tokens. It is built on the OpenZeppelin library and follows the ERC20 standard.

## Contract Overview

### SPDX License Identifier

```solidity
// SPDX-License-Identifier: MIT
```

### Pragma

```solidity
pragma solidity ^0.8;
```

### Contract Details

- **Name**: Nikhilcoin
- **Symbol**: Customizable upon deployment
- **Owner**: The deployer of the contract
- **Total Supply**: Tracks the total supply of the token
- **Balances**: Tracks the balance of each address

## Events

- `Burn(address from, uint256 value)`: Emitted when tokens are burned.
- `Mint(address to, uint256 value)`: Emitted when new tokens are minted.
- `Transfer(address sender, address to, uint256 value)`: Emitted when tokens are transferred from one address to another.

## Modifiers

- `onlyOwner`: Ensures that only the contract owner can call the modified function.

## Functions

### Constructor

```solidity
constructor(string memory name, string memory symbol)
```
- Initializes the contract with a name and symbol and sets the owner to the deployer.

### `totalSupply`

```solidity
function totalSupply() external view returns (uint256)
```
- Returns the total supply of the token.

### `balanceOf`

```solidity
function balanceOf(address account) external view returns (uint256)
```
- Returns the balance of a specific address.

### `transfer`

```solidity
function transfer(address to, uint256 value) public returns (bool)
```
- Transfers tokens from the sender's address to another address.
- Emits a `Transfer` event.

### `burn`

```solidity
function burn(uint256 value) public returns (bool)
```
- Burns a specific amount of tokens from the sender's address.
- Emits a `Burn` event.

### `mint`

```solidity
function mint(address to, uint256 value) public onlyOwner returns (bool)
```
- Mints new tokens to a specific address.
- Emits a `Mint` event.

## Errors

- `InvalidReceiver(address _to)`: Thrown when attempting to transfer tokens to the zero address.
- `InsufficientBalance(address from, uint256 fromBalance, uint256 value)`: Thrown when an account has insufficient balance for a transaction.

## Usage

### Deploying the Contract

1. Deploy the contract by providing the name and symbol of the token.

### Interacting with the Contract

1. **Total Supply**: Call `totalSupply()` to get the total supply of tokens.
2. **Balance**: Call `balanceOf(address account)` to check the balance of a specific address.
3. **Transfer**: Call `transfer(address to, uint256 value)` to transfer tokens from the sender's address to another address.
4. **Burn**: Call `burn(uint256 value)` to burn tokens from the sender's address.
5. **Mint**: Call `mint(address to, uint256 value)` to mint new tokens to a specific address. Only the owner can call this function.
