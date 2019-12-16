pragma solidity 0.5.0;

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
    address owner;

    constructor() public{
        owner = msg.sender;
    }

    function withdraw() external onlyOwner{
        msg.sender.transfer(address(this).balance);
    }
}