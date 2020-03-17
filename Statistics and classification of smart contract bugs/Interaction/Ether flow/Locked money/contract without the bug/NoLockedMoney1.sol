pragma solidity 0.6.2;


contract gray_stuffyWallet{
	address public owner;

	constructor() public{
		owner = msg.sender;
	}

	function deposit() external payable{
		require(msg.value > 0);
	}

	function withdraw() external{
		require(msg.sender == owner);
		msg.sender.transfer(address(this).balance);
	}
}