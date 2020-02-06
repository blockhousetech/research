pragma solidity >=0.4.25 <0.5.16;

contract SimpleMarketplace
{
    enum StateType { 
      ItemAvailable,
      OfferPlaced,
      Accepted
    }

    address InstanceOwner;
    int AskingPrice;
    StateType State;

    address InstanceBuyer;
    int OfferPrice;

    constructor(int price) public
    {
        InstanceOwner = msg.sender;
        AskingPrice = price;
        State = StateType.ItemAvailable;

       assert(State == StateType.ItemAvailable);
    }

    function MakeOffer(int offerPrice) public
    {
        if (offerPrice == 0)
        {
            revert();
        }

        if (State != StateType.ItemAvailable)
        {
            revert();
        }
        
        if (InstanceOwner == msg.sender)
        {
            revert();
        }

       assert(State == StateType.ItemAvailable);

        InstanceBuyer = msg.sender;
        OfferPrice = offerPrice;
        State = StateType.OfferPlaced;

       assert(State == StateType.OfferPlaced);
    }

    function Reject() public
    {
        if ( State != StateType.OfferPlaced )
        {
            revert();
        }

        if (InstanceOwner != msg.sender)
        {
            revert();
        }

       assert(State == StateType.OfferPlaced);

        InstanceBuyer = address(0);
        State = StateType.ItemAvailable;

       assert(State == StateType.ItemAvailable);
    }

    function AcceptOffer() public
    {
        if ( msg.sender != InstanceOwner )
        {
            revert();
        }

       assert(State == StateType.OfferPlaced);

        State = StateType.Accepted;

       assert(State == StateType.Accepted);
    }
}