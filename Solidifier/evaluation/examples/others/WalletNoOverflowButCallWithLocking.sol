pragma solidity ^0.4.25;

library Verification {
    function Assert(bool b) public;
    function Assume(bool b) public;
    function CexPrintui(uint i) public;
}

contract Wallet {

	enum Status {
		None,
		Open,
		Closed
	}

	struct Account {
		uint id;
		uint balance;
		Status status;
	}

	mapping (address => Account) accounts;
	bool lock;

	function open () public {
	    if(lock){
	        revert();
	    } else {
	        lock = true;
	    }

        require(accounts[msg.sender].status == Status.None);

        Verification.Assert(accounts[msg.sender].status == Status.None);

        accounts[msg.sender].status = Status.Open;

        Verification.Assert(accounts[msg.sender].status == Status.Open);
        Verification.Assert(accounts[msg.sender].balance == 0);

        lock = false;
	}

	function close () public {
	    if(lock){
            revert();
        } else {
            lock = true;
        }

        require(accounts[msg.sender].status == Status.Open);
        require(accounts[msg.sender].balance == 0);

        Verification.Assert(accounts[msg.sender].status == Status.Open);
        Verification.Assert(accounts[msg.sender].balance == 0);

        accounts[msg.sender].status = Status.Closed;

        Verification.Assert(accounts[msg.sender].status == Status.Closed);
        Verification.Assert(accounts[msg.sender].balance == 0);

        lock = false;
	}

	function deposit () payable public {
        if(lock){
	        revert();
	    } else {
	        lock = true;
	    }

		require(accounts[msg.sender].status == Status.Open);

		Verification.Assert(accounts[msg.sender].status == Status.Open);

		// spec var
        uint old_balance = accounts[msg.sender].balance;

        require(accounts[msg.sender].balance <= accounts[msg.sender].balance + msg.value);

		accounts[msg.sender].balance =
			accounts[msg.sender].balance + msg.value;

		Verification.CexPrintui(old_balance);
		Verification.CexPrintui(msg.value);
		Verification.CexPrintui(msg.value + old_balance);

        Verification.Assert(old_balance <= old_balance + msg.value);
        Verification.Assert(accounts[msg.sender].balance == old_balance + msg.value);
        Verification.Assert(accounts[msg.sender].status == Status.Open);

        lock = false;
	}

	function withdraw (uint value) public {
        if(lock){
	        revert();
	    } else {
	        lock = true;
	    }

		require(accounts[msg.sender].status == Status.Open);
		require(accounts[msg.sender].balance >= value);

		Verification.Assert(accounts[msg.sender].status == Status.Open);

		// spec var
        uint old_balance = accounts[msg.sender].balance;

        require(accounts[msg.sender].balance >= accounts[msg.sender].balance - value);

		accounts[msg.sender].balance = accounts[msg.sender].balance - value;
		bool callSuccess = msg.sender.call.value(value)();

		if (!callSuccess) {
            accounts[msg.sender].balance = accounts[msg.sender].balance + value;
        }

		Verification.CexPrintui(old_balance);
        Verification.CexPrintui(value);
        Verification.CexPrintui(accounts[msg.sender].balance);

		Verification.Assert(old_balance >= old_balance - value);
        Verification.Assert(!callSuccess || accounts[msg.sender].balance == old_balance - value);
        Verification.Assert(accounts[msg.sender].status == Status.Open);

        lock = false;
	}
}