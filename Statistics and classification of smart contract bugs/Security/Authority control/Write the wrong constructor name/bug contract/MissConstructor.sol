pragma solidity 0.4.26;

contract MissContructor{
    address public owner;
    
    /*
    Misspelled constructor name, anyone can now become the 
    owner of the contract and pay a small amount of ethers,
    he is going to be able to withdraw all of deposits from 
    the contract.
    */
    function missContructor() public payable{
        owner = msg.sender;
        require(msg.value > 0);
    }
    
    function getMyBalance() external{
        require(msg.sender == owner);
        msg.sender.transfer(address(this).balance);
    }
}