pragma solidity 0.5.0;


contract disable_stuffyWallet{
	address public owner;

	constructor() public{
		owner = msg.sender;
	}

	function deposit() external payable{
		require(msg.value > 0);
	}

	//disabled
	function zero_withdraw() external{
		require(address(this).balance == 0);
		msg.sender.transfer(address(this).balance);
	}
}