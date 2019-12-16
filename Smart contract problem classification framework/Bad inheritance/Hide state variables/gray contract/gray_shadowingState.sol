pragma solidity 0.5.0;

//based on slither

contract gray_FatherContract{
    address owner;
    modifier onlyOwner{
        require(owner == msg.sender);
        _;
    }
}

//Override the onlyOwner in gray_SonContract

contract gray_SonContract is gray_FatherContract{
    address owner;
    constructor() public{
        owner = msg.sender;
    }
    
    modifier onlyOwner{
        require(owner == msg.sender);
        _;
    }

    function withdraw() external onlyOwner{
        msg.sender.transfer(address(this).balance);
    }
}