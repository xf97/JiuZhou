pragma solidity 0.6.2;


contract disable_stuffyWallet{
	address public owner;

	constructor() public{
		owner = msg.sender;
	}

	function deposit() external payable{
		require(msg.value > 0);
	}

	//However, this function is not available when the contract's balance is greater than 0.
	function zero_withdraw() external{
		require(address(this).balance == 0);
		msg.sender.transfer(address(this).balance);
	}
}