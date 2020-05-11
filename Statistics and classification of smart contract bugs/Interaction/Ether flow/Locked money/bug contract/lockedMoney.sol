pragma solidity 0.6.2;

//based on smartcheck

contract BadMarketPlace {
	//In Ethereum, contracts can receive or send ethers. If you want to receive the ethers, you need to declare at least one function in the contract as payable. There needs to be at least one statement that transfers out of the ether in the contract, and that statement is reachable, otherwise all ethers in the contract are locked up.
    function deposit() external payable {
        require(msg.value > 0);
    }
}