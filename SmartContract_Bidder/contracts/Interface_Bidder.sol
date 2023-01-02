// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

interface InterfaceBidder {
    /*
     * @dev register account of new bidder to Auction
     */
    function register(address account, uint256 _token) external;

    /*
     * @dev init state "started" of Auction
     */

    function startSesstion() external;

    /*
     * @dev use for bidding
     */
    function bid(uint8 _price) external;

    /*
     * @dev annouce the status of bidder ,if annouced more than 3, swithc sesstion to Closed state
     */
    function announce() external;

    /*
     * @dev get deposit allow user to withdraw their deposit
     */
    function getDeposit(address addBidder) external;
}
