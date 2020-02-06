pragma solidity >=0.4.25 <0.5.16;

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

       assert(accounts[msg.sender].status == Status.None);

        accounts[msg.sender].status = Status.Open;

       assert(accounts[msg.sender].status == Status.Open);
       assert(accounts[msg.sender].balance == 0);

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

       assert(accounts[msg.sender].status == Status.Open);
       assert(accounts[msg.sender].balance == 0);

        accounts[msg.sender].status = Status.Closed;

       assert(accounts[msg.sender].status == Status.Closed);
       assert(accounts[msg.sender].balance == 0);

        lock = false;
	}

	function deposit () payable public {
        if(lock){
	        revert();
	    } else {
	        lock = true;
	    }

		require(accounts[msg.sender].status == Status.Open);

		assert(accounts[msg.sender].status == Status.Open);

		// spec var
        uint old_balance = accounts[msg.sender].balance;

        require(accounts[msg.sender].balance <= accounts[msg.sender].balance + msg.value);

		accounts[msg.sender].balance =
			accounts[msg.sender].balance + msg.value;

		// Verification.CexPrintui(old_balance);
		// Verification.CexPrintui(msg.value);
		// Verification.CexPrintui(msg.value + old_balance);

       assert(old_balance <= old_balance + msg.value);
       assert(accounts[msg.sender].balance == old_balance + msg.value);
       assert(accounts[msg.sender].status == Status.Open);

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

		assert(accounts[msg.sender].status == Status.Open);

		// spec var
        uint old_balance = accounts[msg.sender].balance;

        require(accounts[msg.sender].balance >= accounts[msg.sender].balance - value);

		accounts[msg.sender].balance = accounts[msg.sender].balance - value;

		bool callSuccess = msg.sender.call.value(value)();

        if (!callSuccess) {
            accounts[msg.sender].balance = accounts[msg.sender].balance + value;
        }

		// Verification.CexPrintui(old_balance);
        // Verification.CexPrintui(value);
        // Verification.CexPrintui(accounts[msg.sender].balance);

	    assert(old_balance >= old_balance - value);
        assert(!callSuccess || accounts[msg.sender].balance == old_balance - value);
        assert(accounts[msg.sender].status == Status.Open);

        lock = false;
	}
}