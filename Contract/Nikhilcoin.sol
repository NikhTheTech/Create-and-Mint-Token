// SPDX-License-Identifier: MIT
pragma solidity ^0.8;


contract Nikhilcoin {
    string private _name;
    string private _symbol;
    address private _owner;
    mapping(address => uint256) private _balances;
    uint256 private _totalSupply = 0;



    event Burn(address from, uint256 value);
    event Mint(address to, uint256 value);
    event Transfer(address sender,address to, uint256 value);

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

    function transfer(address to, uint256  value) public returns (bool) {
        
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


  

    error InvalidReceiver(address _to);

    error InsufficientBalance(address from,uint256 fromBalance,uint256 value);


}