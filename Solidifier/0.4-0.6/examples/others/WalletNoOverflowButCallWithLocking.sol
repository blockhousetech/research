pragma solidity ^0.5.10;

library Verification {
    function Assert  (bool b) public;
    function Assume  (bool b) public;
    function CexPrinti  (uint i) public;
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

		Account memory account_mem;
        account_mem = accounts[msg.sender];
        account_mem.balance = account_mem.balance + msg.value;
        accounts[msg.sender] = account_mem;

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

		Account storage account_stor = accounts[msg.sender];
        Account memory account_mem = account_stor;
        account_mem.balance = account_mem.balance - value;
        accounts[msg.sender] = account_mem;

		bool callSuccess;
		(callSuccess,) = msg.sender.call.value(value)("");

        if (!callSuccess) {
            accounts[msg.sender].balance = accounts[msg.sender].balance + value;
        }

        Verification.Assert(old_balance >= old_balance - value);
        Verification.Assert(!callSuccess || accounts[msg.sender].balance == old_balance - value);
        Verification.Assert(accounts[msg.sender].status == Status.Open);

        lock = false;
	}
}