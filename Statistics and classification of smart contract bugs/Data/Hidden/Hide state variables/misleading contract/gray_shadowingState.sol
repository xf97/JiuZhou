pragma solidity 0.5.16;

//based on slither

//The owner of FatherContract is overridden 
//and not assigned. So the onlyOwner doesn't work.

contract gray_FatherContract{
    address owner;
    modifier onlyOwner{
        require(owner == msg.sender);
        _;
    }
}

contract gray_SonContract is gray_FatherContract{
    address owner;  //same name

    constructor() public payable{
        owner = msg.sender;
    }
    
    //but override the modifier
    modifier onlyOwner{
        require(owner == msg.sender);
        _;
    }

    function withdraw() external onlyOwner{
        msg.sender.transfer(address(this).balance);
    }
}
