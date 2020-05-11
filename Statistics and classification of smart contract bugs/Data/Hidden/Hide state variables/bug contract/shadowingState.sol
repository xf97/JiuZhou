pragma solidity 0.5.16;

//based on slither

//The owner of FatherContract is overridden 
//and not assigned. So the onlyOwner doesn't work.

contract FatherContract{
    address owner;
    modifier onlyOwner{
        require(owner == msg.sender);
        _;
    }
}

contract SonContract is FatherContract{
    //Inheritance makes a common bug that causes variables in subclasses to hide variables with the same name in the base class. And in smart contracts, the impact of this bug is magnified, and hidden base-class state variables are assigned to default values, which can be harmful in some cases.
    address owner;

    constructor() public payable{
        owner = msg.sender;
    }

    function withdraw() external onlyOwner{
        msg.sender.transfer(address(this).balance);
    }
}
