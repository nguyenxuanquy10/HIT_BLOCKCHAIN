// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Auction {
    // Data

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

    constructor(uint8 _startingPrice, uint8 _minimumStep) {
        // Task #1 - Initialize the Smart contract
        // + Initialize Auctioneer with address of smart contract's owner
        auctioneer = msg.sender;
        // + Set the starting price & minimumStep
        rule.startingPrice = _startingPrice;
        rule.minimumStep = _minimumStep;
        // + Set the current price as the Starting price
        currentPrice = rule.startingPrice;
        // ** Start code here. 4 lines approximately. ** /
        // ** End code here. ** /
    }

    // Register new Bidder
    function register(address _account, uint8 _token) public {
        // Task #2 - Register the bidder
        // + Initialize a Bidder with address and token are given.
        bidders[_account] = IBidder(_token, 0);
        // + Initialize a Bidder's deposit with 0
        // ** Start code here. 3 lines approximately. ** /
        // ** End code here. **/
    }

    // Start the session.
    function startSession() public {
        state = State.STARTED;
    }

    function bid(uint8 _price) public {
        // Task #3 - Bid by Bidders
        // + Check the price with currentPirce and minimumStep. Revert if invalid.
        // + Check if the Bidder has enough token to bid. Revert if invalid.
        // + Move token to Deposit.

        address bidderAddr = msg.sender;
        IBidder storage currentBidder = bidders[bidderAddr];

        // ** Start code here.  ** /
        if (_price < currentPrice || _price - currentPrice < rule.minimumStep) {
            revert(
                "price must be lagger than currentPrice and valid minimumStrep"
            );
        }
        if (currentBidder.token < _price) {
            revert("do not enough to bid");
        }
        currentBidder.deposit = _price;
        // ** End code here. **/

        // Tracking deposit
        totalDeposit += _price;

        // Update the price and the winner after this bid.
        currentPrice = _price;
        currentWinner = bidderAddr;

        // Reset the Annoucements Counter
        announcementTimes = 0;
    }

    function announce() public {
        // Task #4 - Handle announcement.
        // + When Auctioneer annouce, increase the counter.
        // + When Auctioneer annouced more than 3 times, switch session to Closing state.
        // ** Start code here.  ** /
        announcementTimes++;
        if (announcementTimes >= 3) {
            state = State.CLOSED;
        }
        // ** End code here. **/
    }

    function getDeposit() public {
        // Task #5 - Handle get Deposit.
        // + Allow bidders (except Winner) to withdraw their deposit

        // + When all bidders' deposit are withdrew, close the session

        // ** Start code here.  ** /
        // HINT: Remember to decrease totalDeposit.
        //  for (uint256 i = 0; i < bidders.length; i++)
        // ** End code here ** /

        if (totalDeposit <= 0) {
            state = State.CLOSED;
        }
    }
}

// PART 2 - Using Modifier to:
// - Check if the action (startSession, register, bid, annoucement, getDeposit) can be done in current State.
// - Check if the current user can do the action.
