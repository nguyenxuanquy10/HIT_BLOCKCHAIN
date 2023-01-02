// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.6.0) (token/ERC20/IERC20.sol)
pragma solidity >=0.8.9 <0.9.0;

import "./IERC20.sol";

contract ERC20 is IERC20 {
    // totalSupply of token
    uint256 _totalSupply;
    // mapping from address to token of user
    mapping(address => uint256) _balances;

    // mapping include sender, owner, and amount nunmber of token that sender can withdraw form owner
    mapping(address => mapping(address => uint256)) _allowances;

    // Just allow excute when success authorize with addres from agruement
    modifier allowTransfer(address owner) {
        require(msg.sender == owner, "Require authorize");
        _;
    }

    /**
     * @dev See {IERC20-balanceOf}.
     */
    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev See {IERC20- balanceOf}
     */
    function balanceOf(address indiv) public view override returns (uint256) {
        return _balances[indiv];
    }

    /**
     * @dev See {IERC20 - transfer}
     */
    function transfer(address reciever, uint256 token)
        public
        override
        returns (bool)
    {
        address senderAdd = msg.sender;
        uint256 tokenSender = _balances[senderAdd];
        require(tokenSender > token, "Do not enough token in your account");
        _balances[senderAdd] -= token;
        _balances[reciever] += token;
        return true;
    }

    /**
     * @dev See {IERC20 - transferFrom}
     */
    function transferFrom(
        address owner,
        address receiver,
        uint256 amountToken
    ) public override allowTransfer(owner) returns (bool) {
        uint256 tokenOfSender = _balances[owner];
        require(
            tokenOfSender >= amountToken,
            "Do not enough token to transaction"
        );

        _balances[owner] -= amountToken;
        _balances[receiver] += amountToken;
        return true;
    }

    /**
     * @dev See{IERC-Approve}
     */
    function Approve(address spender, uint256 amountToken)
        public
        override
        returns (bool)
    {
        address owner = msg.sender;
        require(
            _balances[owner] > amountToken,
            "Do not enought token exist in you address"
        );
        _allowances[owner][spender] = amountToken;
        return true;
    }

    /**
     * @dev See{IERC-Approve}
     */
    function Allowance(address spender, address owner)
        public
        view
        override
        returns (uint256)
    {
        return _allowances[owner][spender];
    }
}
