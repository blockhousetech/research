pragma solidity ^0.4.25;

library Verification {
    function Assert(bool b) public;
    function Assume(bool b) public;
    function CexPrintui(uint i) public;
    function CexPrintb(bool b) public;
    function CexPrintad(address ad) public;
}

contract Ballot {

    struct Voter {
        uint weight;
        bool registered;
        bool voted;
        address delegate;
        uint vote;
    }


    struct Proposal {
        uint id;
        uint voteCount;
    }

    address chairperson;

    enum VotingState {Registration, Voting, Ended}

    VotingState state;

    mapping(address => Voter) voters;

    Proposal winningProposal;

    Proposal[] proposals;
    address[] votersAddresses;

    // spec var
    uint votingWeight;

    constructor(uint[] memory proposalIds) public {
        chairperson = msg.sender;

        voters[chairperson].weight = 1;
        voters[chairperson].registered = true;
        votersAddresses.push(chairperson);

        votingWeight = 1;

        for (uint i = 0; i < proposalIds.length; i++) {
            Proposal memory p;
            p.id = proposalIds[i];
            p.voteCount = 0;
            proposals.push(p);
        }

        state = VotingState.Registration;
    }

    function giveRightToVote(address voter) public {

        require(msg.sender == chairperson);
        require(!voters[voter].voted);
        require(voters[voter].weight == 0);
        require(state == VotingState.Registration);

        voters[voter].weight = 1;
        voters[voter].registered = true;
        votersAddresses.push(voter);

        votingWeight += 1;
    }

    function openVote() public {
        require(state == VotingState.Registration);
        require(msg.sender == chairperson);

        state = VotingState.Voting;
    }

    function delegate(address to_) public {

        address to = to_;
        Voter storage sender = voters[msg.sender];

        require(state == VotingState.Registration);
        require(!sender.voted);
        require(to != msg.sender);

        while (voters[to].delegate != address(0)) {
            to = voters[to].delegate;

            require(to != msg.sender);
        }

        sender.voted = true;
        sender.delegate = to;
        Voter storage delegate_ = voters[to];

        require(delegate_.registered);

        if (delegate_.voted) {
            proposals[delegate_.vote].voteCount += sender.weight;
        } else {
            delegate_.weight += sender.weight;
        }
        sender.weight = 0;

    }

    function vote(uint proposal) public {

        Voter storage sender = voters[msg.sender];

        require(state == VotingState.Voting);
        require(sender.weight != 0);
        require(!sender.voted);

        sender.voted = true;
        sender.vote = proposal;

        Verification.CexPrintui(proposals.length);
        Verification.CexPrintui(proposal);

        proposals[proposal].voteCount += sender.weight;

        sender.weight = 0;

    }

    function invariantCheck() public
    {

        require(state != VotingState.Registration);

        uint sumOfWeightsAndCounts;

        for(uint i =0; i < votersAddresses.length; i++){
            sumOfWeightsAndCounts += voters[votersAddresses[i]].weight;
        }
        for (uint p = 0; p < proposals.length; p++) {
            sumOfWeightsAndCounts += proposals[p].voteCount;
        }

        Verification.CexPrintui(sumOfWeightsAndCounts);
        Verification.CexPrintui(votingWeight);

        Verification.Assert(sumOfWeightsAndCounts == votingWeight);
    }

    function endVote() public
    {
        require(state == VotingState.Voting);
        require(msg.sender == chairperson);

        state = VotingState.Ended;

        uint winningVoteCount = 0;
        for (uint p = 0; p < proposals.length; p++) {
            if (proposals[p].voteCount > winningVoteCount) {
                winningVoteCount = proposals[p].voteCount;
                winningProposal = proposals[p];
            }
        }

    }
}