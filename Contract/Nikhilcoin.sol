// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Nikhilcoin is IERC20{
    string private _name;
    string private _symbol;
    address private _owner;
    mapping(address => uint256) private _balances;
    uint256 private _totalSupply = 0;


    event Burn(address from, uint256 value);
    event Mint(address to, uint256 value);

    constructor(string memory name, string memory symbol) {
        _name = name;
        _symbol = symbol;
        _owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == _owner, "Only owner is allowed to perform this operation");
        _;
    }

    function totalSupply() external view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) external view returns (uint256) {
        return _balances[account];
    }

    function transfer(address to, uint256 value) public returns (bool) {
        
        if (to == address(0)) {
            revert InvalidReceiver(address(0));
        }
        address sender = msg.sender;
        uint256 senderBalance = _balances[sender]; 
        if (_balances[sender] < value) {
            revert InsufficientBalance(sender, senderBalance, value);
        } 
        _balances[sender] -= value;
        _balances[to] += value;
        emit Transfer(sender, to, value);
        return true;
    }


    function burn(uint256 value) public returns(bool) {
        address sender = msg.sender;
        uint256 senderBalance = _balances[sender];
        if(_balances[sender] < value) {
            revert InsufficientBalance(sender, senderBalance, value);
        }
        _balances[sender] -= value;
        _totalSupply -= value;
        emit Burn(sender, value);
        return true;
    }

    function mint(address to, uint256 value) public onlyOwner returns(bool) {
        _balances[to] += value;
        _totalSupply += value;
        emit Mint(to, value);
        return true;
    }

    mapping(address => mapping(address => uint256)) private _allowances;
    function allowance(address owner, address spender) external view returns (uint256) {
        return _allowances[owner][spender];
    }
    function approve(address spender, uint256 value) external returns (bool) {
        address owner = msg.sender;
        uint256 ownerBalance = _balances[owner];
        if (spender == address(0)) {
            revert InvalidReceiver(spender);
        }
        if (ownerBalance < value) {
            revert InsufficientBalance(owner, ownerBalance, value);
        }
        _balances[owner] -= value;
        _allowances[owner][spender] += value;
        emit Approval(owner, spender, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) external returns (bool) {
        address spender = msg.sender;
        uint256 allowanceBalance =  _allowances[from][spender];

        if (to == address(0)) {
            revert InvalidReceiver(to);
        }
        if (allowanceBalance < value) {
            revert InsufficientAllowance(spender, from, allowanceBalance, value);
        }
        _allowances[from][spender] -= value;
        _balances[to] += value;
        emit Transfer(from, to, value);
        return true;
    }

    error InvalidReceiver(address _to);

    error InsufficientBalance(address from,uint256 fromBalance,uint256 value);

    error InsufficientAllowance(address spender, address from, uint256 currentAllowance, uint256 value);

}
