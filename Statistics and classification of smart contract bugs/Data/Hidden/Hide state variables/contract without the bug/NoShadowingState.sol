pragma solidity 0.5.16;


contract gray_FatherContract{
    address owner;
    modifier onlyOwner{
        require(owner == msg.sender);
        _;
    }
}


contract NoSonContract is gray_FatherContract{
    address _owner;     //another name
    constructor() public{
        _owner = msg.sender;
    }
    
    modifier onlyOwner{
        require(_owner == msg.sender);
        _;
    }

    function withdraw() external onlyOwner{
        msg.sender.transfer(address(this).balance);
    }
}