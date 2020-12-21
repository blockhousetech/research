pragma solidity >=0.4.25 <0.6.0;

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

	function open () public {
		require(accounts[msg.sender].status == Status.None);

		assert(accounts[msg.sender].status == Status.None);

		accounts[msg.sender].status = Status.Open;

		assert(accounts[msg.sender].status == Status.Open);
		assert(accounts[msg.sender].balance == 0);
	}

	function close () public {
		require(accounts[msg.sender].status == Status.Open);
		require(accounts[msg.sender].balance == 0);

		assert(accounts[msg.sender].status == Status.Open);
       assert(accounts[msg.sender].balance == 0);

		accounts[msg.sender].status = Status.Closed;

		assert(accounts[msg.sender].status == Status.Closed);
       assert(accounts[msg.sender].balance == 0);
	}

	function deposit () payable public {
		require(accounts[msg.sender].status == Status.Open);

		assert(accounts[msg.sender].status == Status.Open);

		// spec var
        uint old_balance = accounts[msg.sender].balance;

		Account memory account_mem;
        account_mem = accounts[msg.sender];
        account_mem.balance = account_mem.balance + msg.value;
        accounts[msg.sender] = account_mem;

       assert(old_balance <= old_balance + msg.value);
       assert(accounts[msg.sender].balance == old_balance + msg.value);
       assert(accounts[msg.sender].status == Status.Open);
	}

	function withdraw (uint value) public {
		require(accounts[msg.sender].status == Status.Open);
		require(accounts[msg.sender].balance >= value);

		assert(accounts[msg.sender].status == Status.Open);

		// spec var
        uint old_balance = accounts[msg.sender].balance;

		Account storage account_stor = accounts[msg.sender];
        Account memory account_mem = account_stor;
        account_mem.balance = account_mem.balance - value;
        accounts[msg.sender] = account_mem;
		msg.sender.transfer(value);

		assert(old_balance >= old_balance - value);
        assert(accounts[msg.sender].balance == old_balance - value);
        assert(accounts[msg.sender].status == Status.Open);
	}
}