pragma solidity 0.6.2;

//Happy birthday to contract for the first twenty weeks. Give him money

contract NoWaste3{
    uint256 public contractBirthday;
    address public owner;
    
    constructor() public payable{
        require(msg.value >= 2 ether);
        contractBirthday = now;
        owner = msg.sender;
    }

    function sayHappyBirthday() external{
        if(now <= contractBirthday + 1 weeks)
            msg.sender.transfer(0.1 ether);
    }
    
    function refund() external{
        require(msg.sender == owner);
        if(now > contractBirthday + 1 weeks)
            selfdestruct(msg.sender);
    }
}