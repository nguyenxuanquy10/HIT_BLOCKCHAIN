// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract ERC20 {
    address private _owner;
    uint256 _totalSupply;
    mapping(address => uint256) _balance;
    event Transfer(address from, address to, uint256 amount);

    modifier onlyOwner() {
        if (msg.sender != _owner) {
            revert();
        }
        _;
    }

    constructor(uint256 _amount) {
        _owner = msg.sender;
        _totalSupply = _amount;
    }

    function Owner() public view returns (address) {
        return _owner;
    }

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function burn(uint256 _amount) public onlyOwner {}

    // function transfer(address recipient , uint amount){

    // }
    function balanceOf() public view returns (uint256) {
        return _balance[msg.sender];
    }

    function transfer(address receipt, uint256 amount) public {
        require(_balance[msg.sender] < amount, "invalid");
        _balance[msg.sender] = _balance[msg.sender] - amount;
        _balance[receipt] = _balance[receipt] + amount;
    }

    function allowance(address owner, address spender)
        public
        returns (uint256)
    {}
}
