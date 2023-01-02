// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.6.0) (token/ERC20/IERC20.sol)
pragma solidity >=0.8.9 <0.9.0;

interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns of the amount of tokens of users
     */
    function balanceOf(address indiv) external view returns (uint256);

    /**
     * @dev Transfer of a specified number of token to a specified account
     */
    function transfer(address receiver, uint256 token) external returns (bool);

    /**
     * @dev Transfer from a specified address with specified number of token to a specified account
     */
    function transferFrom(
        address owner,
        address receiver,
        uint256 token
    ) external returns (bool);

    /**
     * @dev Allow a spender to withdraw  a set number  of tokens from a specified account
     */
    function Approve(address spender, uint256 amountToken)
        external
        returns (bool);

    /**
     * @dev Return a set number of token from spender to owner
     */
    function Allowance(address spender, address owner)
        external
        view
        returns (uint256);
}
