pragma solidity 0.5.0;


contract stuffyWallet{
	address public owner;

	constructor() public{
		owner = msg.sender;
	}

	function deposit() external payable{
		require(msg.value > 0);
	}

	//Although this function can be used, the careless developer wrote the wrong amount of withdraw, so the ether remains locked.
	function zero_withdraw() external{
		require(msg.sender == owner);
		msg.sender.transfer(0);
	}
}