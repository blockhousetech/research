pragma solidity >=0.4.25 <0.5.16;


contract Wallet {

	enum Status {
		None,
		Open,
		Closed
	}

	struct Account {
		uint id;
		uint bal;
		Status status;
	}

	mapping (address => Account) accounts;

	function open () public {
		require(accounts[msg.sender].status == Status.None);

		assert(accounts[msg.sender].status == Status.None);

		accounts[msg.sender].status = Status.Open;

		assert(accounts[msg.sender].status == Status.Open);
		assert(accounts[msg.sender].bal == 0);
	}

	function close () public {
		require(accounts[msg.sender].status == Status.Open);
		require(accounts[msg.sender].bal == 0);

		assert(accounts[msg.sender].status == Status.Open);
       assert(accounts[msg.sender].bal == 0);

		accounts[msg.sender].status = Status.Closed;

		assert(accounts[msg.sender].status == Status.Closed);
       assert(accounts[msg.sender].bal == 0);
	}

	function deposit () payable public {
		require(accounts[msg.sender].status == Status.Open);

		assert(accounts[msg.sender].status == Status.Open);

		// spec var
        uint old_balance = accounts[msg.sender].bal;

        require(accounts[msg.sender].bal <= accounts[msg.sender].bal + msg.value);

		accounts[msg.sender].bal =
			accounts[msg.sender].bal + msg.value;

		// Verification.CexPrintui(old_balance);
		// Verification.CexPrintui(msg.value);
		// Verification.CexPrintui(msg.value + old_balance);

       assert(old_balance <= old_balance + msg.value);
       assert(accounts[msg.sender].bal == old_balance + msg.value);
       assert(accounts[msg.sender].status == Status.Open);
	}

	function withdraw (uint value) public {
		require(accounts[msg.sender].status == Status.Open);
		require(accounts[msg.sender].bal >= value);

		assert(accounts[msg.sender].status == Status.Open);

		// spec var
        uint old_balance = accounts[msg.sender].bal;

        require(accounts[msg.sender].bal >= accounts[msg.sender].bal - value);

		accounts[msg.sender].bal = accounts[msg.sender].bal - value;
		msg.sender.transfer(value);

		// Verification.CexPrintui(old_balance);
        // Verification.CexPrintui(value);
        // Verification.CexPrintui(accounts[msg.sender].bal);

		assert(old_balance >= old_balance - value);
        assert(accounts[msg.sender].bal == old_balance - value);
        assert(accounts[msg.sender].status == Status.Open);
	}
}