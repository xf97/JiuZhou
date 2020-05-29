pragma solidity 0.4.26;

contract MissConstructor{
    address public owner;
    
    /*
    Misspelled constructor name, anyone can now become the 
    owner of the contract and pay a small amount of ethers,
    he is going to be able to withdraw all of deposits from 
    the contract.
    */
    //In some cases, the lack of constructors can be dangerous. If the developer is not going to write a constructor for the contract, the harm of the lack of a constructor is limited to the structural incompleteness of the contract. If the developer intends to write a constructor for the contract, but misspells the function name due to the developer's own negligence, the contract is at great risk. Because in contracts, constructors are often tasked with assigning values to key state variables.
    function missConstructor() public payable{
        owner = msg.sender;
        require(msg.value > 0);
    }
    
    function getMyBalance() external{
        require(msg.sender == owner);
        msg.sender.transfer(address(this).balance);
    }
}