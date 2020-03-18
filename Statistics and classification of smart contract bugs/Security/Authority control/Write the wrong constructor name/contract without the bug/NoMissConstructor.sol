pragma solidity 0.6.2;

/*
One possible solution is to use a compiler above version 0.5.0 to compile the contract, so you'll have to declare the constructor keyword instead of having to spell the constructor name.
*/

contract NoMissContructor{
    address public owner;
    constructor() public payable{
        owner = msg.sender;
        require(msg.value > 0);
    }
    
    function getMyBalance() external{
        require(msg.sender == owner);
        msg.sender.transfer(address(this).balance);
    }
}