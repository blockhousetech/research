pragma solidity >=0.4.25 <0.6.0;

contract ItemListing
{
    enum StateType { ItemAvailable, ItemSold }

    StateType State;

    address Seller;
    address InstanceBuyer;
    address ParentContract;
    uint ItemId;
    int ItemPrice;
    address PartyA;
    address PartyB;

    constructor(uint itemId, int itemPrice, address seller, address parentContractAddress, address partyA, address partyB) public {
        Seller = seller;
        ParentContract = parentContractAddress;
        ItemId = itemId;
        ItemPrice = itemPrice;

        PartyA = partyA;
        PartyB = partyB;

        State = StateType.ItemAvailable;

       assert(State == StateType.ItemAvailable);
    }

    function BuyItem() public
    {
        //FIX: Add precondition
        if (State != StateType.ItemAvailable) {
            revert();
        }

       assert(State == StateType.ItemAvailable);

        InstanceBuyer = msg.sender;

        // ensure that the buyer is not the seller
        if (Seller == InstanceBuyer) {
            revert();
        }

        Bazaar bazaar = Bazaar(ParentContract);

        // check Buyer's balance
        if (!bazaar.HasBalance(InstanceBuyer, ItemPrice)) {
            revert();
        }

        // indicate item bought by updating seller and buyer balances
        bazaar.UpdateBalance(Seller, InstanceBuyer, ItemPrice);

        State = StateType.ItemSold;

       assert(State == StateType.ItemSold);
    }
}

contract Bazaar
{
    enum StateType { PartyProvisioned, ItemListed, CurrentSaleFinalized}

    StateType State;

    address InstancePartyA;
    int PartyABalance;

    address InstancePartyB;
    int PartyBBalance;

    address InstanceBazaarMaintainer;
    address CurrentSeller;

    uint ItemId;
    int ItemPrice;

    ItemListing currentItemListing;
    address CurrentContractAddress;

    constructor(address partyA, int balanceA, address partyB, int balanceB) public {
        InstanceBazaarMaintainer = msg.sender;

        // ensure the two parties are different
        if (partyA == partyB) {
            revert();
        }

        InstancePartyA = partyA;
        PartyABalance = balanceA;

        InstancePartyB = partyB;
        PartyBBalance = balanceB;

        CurrentContractAddress = address(this);

        State = StateType.PartyProvisioned;

       assert(State == StateType.PartyProvisioned);
    }

    function HasBalance(address buyer, int itemPrice) public view returns (bool) {
        if (buyer == InstancePartyA) {
            return (PartyABalance >= itemPrice);
        }

        if (buyer == InstancePartyB) {
            return (PartyBBalance >= itemPrice);
        }

        return false;
    }

    function UpdateBalance(address sellerParty, address buyerParty, int itemPrice) public {

        //FIX: Add precondition
        if (State != StateType.ItemListed) {
            revert();
        }

       assert(State == StateType.ItemListed);

        ChangeBalance(sellerParty, itemPrice);
        ChangeBalance(buyerParty, -itemPrice);

        State = StateType.CurrentSaleFinalized;

       assert(State == StateType.CurrentSaleFinalized);
    }

    function ChangeBalance(address party, int balance) public {
        if (party == InstancePartyA) {
            PartyABalance += balance;
        }

        if (party == InstancePartyB) {
            PartyBBalance += balance;
        }
    }

    function ListItem(uint itemId, int itemPrice) public
    {
        require(State != StateType.ItemListed);

       assert(State == StateType.PartyProvisioned ||
                            State == StateType.CurrentSaleFinalized);

        CurrentSeller = msg.sender;

        currentItemListing = new ItemListing(itemId, itemPrice, CurrentSeller, CurrentContractAddress, InstancePartyA, InstancePartyB);

        State = StateType.ItemListed;

       assert(State == StateType.ItemListed);
    }
}
