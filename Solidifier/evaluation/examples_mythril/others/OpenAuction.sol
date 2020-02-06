pragma solidity >=0.4.25 <0.5.16;

contract SimpleAuction {

    address beneficiary;
    uint auctionEndTime;

    address highestBidder;
    uint highestBid;

    mapping(address => uint) pendingReturns;

    bool ended;

    constructor(
        uint _biddingTime,
        address _beneficiary
    ) public {
        beneficiary = _beneficiary;
        auctionEndTime = now + _biddingTime;
    }

    function bid() public payable {
        require(now <= auctionEndTime);
        require(msg.value > highestBid);

        if (highestBid != 0) {
            pendingReturns[highestBidder] += highestBid;
        }

        highestBidder = msg.sender;
        highestBid = msg.value;

    }

    function withdraw() public returns (bool) {
        // spec vars
        uint beforeSenderBalance = msg.sender.balance;
        uint beforeSenderPendingReturn = pendingReturns[msg.sender];
        uint beforeAuctionBalance = address(this).balance;


        uint amount = pendingReturns[msg.sender];
        bool sendSuccess = false;

        if (amount > 0) {

            pendingReturns[msg.sender] = 0;
            sendSuccess = msg.sender.send(amount);

            if (!sendSuccess) {
                pendingReturns[msg.sender] = amount;
            }
        }

        // Verification.CexPrintui(msg.sender.balance);
        // Verification.CexPrintui(pendingReturns[msg.sender]);
        // Verification.CexPrintui(beforeSenderBalance);
        // Verification.CexPrintui(beforeSenderPendingReturn);
        // Verification.CexPrintui(amount);


        // Verification.CexPrintad(address(this));
        // Verification.CexPrintad(msg.sender);

        // If sending succeeds the balances must reflect the appropriate transfer of currency
       assert(!sendSuccess || msg.sender == address(this) || msg.sender.balance == beforeSenderBalance + amount);
       assert(!sendSuccess || msg.sender == address(this) || address(this).balance == beforeAuctionBalance - amount);

        // If sending does not succeed balance must remain the same
       assert(sendSuccess || msg.sender == address(this) || msg.sender.balance == beforeSenderBalance);
       assert(sendSuccess || msg.sender == address(this) || address(this).balance == beforeAuctionBalance);

        // Whether the sending succeeds or not, the sum msg.sender.balance + pendingReturns[msg.sender] must be a function invariant
       assert(msg.sender == address(this) || msg.sender.balance + pendingReturns[msg.sender] == beforeSenderBalance + beforeSenderPendingReturn);

        return sendSuccess;
    }

    function auctionEnd() public {
        require(now >= auctionEndTime);
        require(!ended);

        ended = true;

        beneficiary.transfer(highestBid);
    }
}