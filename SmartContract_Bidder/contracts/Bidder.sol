// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./Interface_Bidder.sol";

// Create smartcontract for bidder inherit IBidder interface;
contract Bidder is IFBidder {
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

    // create modifier just to allow owner of auction can start auction
    modifier onlyOwner() {
        require(msg.sender == auctioneer, "Only owner can do this action ");
        _;
    }
    // create modifier to check the state of acution started
    modifier isStarted(State _state) {
        require(_state == State.STARTED, "Auction must start");
        _;
    }

    // create modifier to check the state of auction closing 
    modifier isClosing(State _state){
        require(_state==State.CLOSING,"Auction must closing");
        _;
    }
    /*
     * @dev register account of new bidder to Auction
     */
    function register(uint8 _token) public override isStarted(state){
        // create new Biider
        IBidder memory newBidder = IBidder(_token, 0);

        // mapping address of bidder to struct IBidder
        address senderAddress = msg.sender;
        bidders[senderAddress] = newBidder;
    }

    /*
     * @dev init state "started" of Auction
     */

    function startSesstion() public override onlyOwner{
        //Change state of auction
        state = State.STARTED;
    }

    /*
     * @dev use for bidding
     */
    function bid(uint8 _price) public override isStarted(state){
        // address of bidder
        address addBidder = msg.sender;
        // check currentPrice and minimunStep
        require(_price >= currentPrice, "must be larger then currentPrice");
        
        // check enough token
        uint8 currentToken = bidders[addBidder].token;
        require(currentToken > _price, "must be smaller then currentToken");

        // check minimum steps 
        uint8 stepOfBidder=_price-currentPrice; 
        require(stepOfBidder >= rule.minimumStep , "must greater than ministep");

        // update current token of bidder, winner, totalDeposit , announcementTimes, current Price
        announcementTimes = 0;
        totalDeposit += _price;
        currentWinner = addBidder;
        currentPrice = _price;
        currentToken-=_price; 
        bidders[addBidder].token=currentToken;
    }

    /*
     * @dev annouce the status of bidder ,if annouced more than 3, swithc sesstion to Closed state
     */
    function announce() public override onlyOwner isStarted(state){
        announcementTimes++;
        if (announcementTimes == 3) {
            state = State.CLOSING;
        }
    }

    /*
     * @dev get deposit allow user to withdraw their deposit
     */
    function getDeposit(address addBidder) public override isClosing(state){
        // check bidder is exist in auction
        require(bidders[addBidder].token <= 0, "Invalid address of bidder");

        uint8 depositOfBidder = bidders[addBidder].deposit;
        //check total deposit is enough
        require(totalDeposit > depositOfBidder, "Total is not enough");
        
        // Solve to return deposit to the bidder , not winner 
        if(addBidder!=currentWinner){
            totalDeposit -= depositOfBidder;
            bidders[addBidder].deposit = 0;
            bidders[addBidder].token += depositOfBidder;
        }
        else{
            revert("Can not get your deposit");
        }
    }

    
    function stopAuction() public onlyOwner{
         state = State.CLOSED; 
         announcementTimes = 0;
         currentPrice = 0;
         currentWinner = address(0);
    }
}
