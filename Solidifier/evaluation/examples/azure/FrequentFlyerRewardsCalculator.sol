pragma solidity ^0.5.10;

library Verification {
    function Assert  (bool b) public;
    function Assume  (bool b) public;
    function CexPrinti  (uint i) public;
}

contract FrequentFlyerRewardsCalculator
{
     //Set of States
    enum StateType {SetFlyerAndReward, MilesAdded}

    //List of properties
    StateType State;
    address AirlineRepresentative;
    address Flyer;
    uint RewardsPerMile;
    uint[] Miles;
    uint IndexCalculatedUpto;
    uint TotalRewards;

    // constructor function
    constructor(address flyer, uint rewardsPerMile) public
    {
        AirlineRepresentative = msg.sender;
        Flyer = flyer;
        RewardsPerMile = rewardsPerMile;
        IndexCalculatedUpto = 0;
        TotalRewards = 0;
        State = StateType.SetFlyerAndReward;

       Verification.Assert(State == StateType.SetFlyerAndReward);
    }

    // call this function to add miles
    function AddMiles(uint[] memory miles) public
    {
        if (Flyer != msg.sender)
        {
            revert();
        }

       Verification.Assert(State == StateType.SetFlyerAndReward ||
                            State == StateType.MilesAdded);

        for (uint i = 0; i < miles.length; i++)
        {
            Miles.push(miles[i]);
        }

        ComputeTotalRewards();

        State = StateType.MilesAdded;

       Verification.Assert(State == StateType.MilesAdded);
    }

    function ComputeTotalRewards() private
    {
        // make length uint compatible
        uint milesLength = Miles.length;
        for (uint i = IndexCalculatedUpto; i < milesLength; i++)
        {
            TotalRewards += (RewardsPerMile * Miles[i]);
            IndexCalculatedUpto++;
        }
    }

    function GetMiles() public view returns (uint[] memory) {
        return Miles;
    }
}