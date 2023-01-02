// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./Interface_Bidder.sol";

// Create smartcontract for bidder inherit IBidder interface;
contract Bidder is InterfaceBidder {
    // Structure to hold details of Bidder
    struct IBidder {
        uint8 token;
        uint8 deposit;
    }

    // Structure to hold details of Rule
    struct IRule {
        uint8 startingPrice;
        uint8 minimumStep;
    }

    // State Enum to define Auction's state
    enum State {
        CREATED,
        STARTED,
        CLOSING,
        CLOSED
    }

    State public state = State.CREATED; // State of Auction

    uint8 public announcementTimes = 0; // Number of announcements
    uint8 public currentPrice = 0; // Latest price is bid.
    IRule public rule; // Rule of this session
    address public currentWinner; // Current Winner, who bid the highest price.
    address public auctioneer;

    uint16 private totalDeposit = 0;

    mapping(address => IBidder) public bidders; // Mapping to hold bidders' information

    //constuctor
    constructor(uint8 _startPrice, uint8 _minimumStep) {
        rule.startingPrice = _startPrice;
        rule.minimumStep = _minimumStep;
        auctioneer = msg.sender;
    }

    // check auction is started
    modifier statusAction() {
        require(state != State.STARTED, "Auction is not start");
        _;
    }
    // create modifier just to allow owner of auction can start auction
    modifier onlyOwner() {
        require(msg.sender != auctioneer, "Only owner can do this action ");
        _;
    }
    // create modifier to check the state of auction
    modifier stateAuction(State _state) {
        require(state != _state, "Invalid action");
        _;
    }

    /*
     * @dev register account of new bidder to Auction
     */
    function register(address account, uint256 _token)
        public
        override
        statusAction
    {
        // create new Biider
        IBidder memory newBidder = IBidder(100, 0);

        // mapping address of bidder to struct IBidder
        address senderAddress = msg.sender;
        bidders[senderAddress] = newBidder;
    }

    /*
     * @dev init state "started" of Auction
     */

    function startSesstion() public override onlyOwner {
        //Change state of auction
        state = State.STARTED;
    }

    /*
     * @dev use for bidding
     */
    function bid(uint8 _price) public override statusAction {
        // address of bidder
        address addBidder = msg.sender;
        // check currentPrice and minimunStep
        require(_price <= currentPrice, "must be larger then currentPrice");

        // check enough token
        uint8 currentToken = bidders[addBidder].token;
        require(_price < currentToken, "must be smaller then currentToken");

        // update current token of bidder, winner, totalDeposit , announcementTimes, current Price
        announcementTimes = 0;
        totalDeposit += _price;
        currentWinner = addBidder;
        currentPrice = _price;
    }

    /*
     * @dev annouce the status of bidder ,if annouced more than 3, swithc sesstion to Closed state
     */
    function announce() public override onlyOwner statusAction {
        announcementTimes++;
        if (announcementTimes == 3) {
            state = State.CLOSING;
        }
    }

    /*
     * @dev get deposit allow user to withdraw their deposit
     */
    function getDeposit(address addBidder) public override statusAction {
        // check bidder is exist in auction
        require(bidders[addBidder].token <= 0, "Invalid address of bidder");

        uint8 depositOfBidder = bidders[addBidder].deposit;
        //check total deposit is enough
        require(totalDeposit > depositOfBidder, "Total is not enough");
        //
        if (state == State.CLOSING) {
            totalDeposit -= depositOfBidder;
            bidders[addBidder].deposit = 0;
            bidders[addBidder].token += depositOfBidder;
            state = State.CLOSED;
            announcementTimes = 0;
            currentPrice = 0;
            currentWinner = address(0);
        } else {
            revert("Can not get your deposit");
        }
    }
}
