pragma solidity 0.6.2;

//Happy birthday to contract for the first twenty in a week. Give him money
//the gas consumption can be saved by declaring the public function not used in the contract as external.

contract waste3{
    uint256 public contractBirthday;
    address public owner;
    
    constructor() public payable{
        require(msg.value >= 2 ether);
        contractBirthday = now;
        owner = msg.sender;
    }
    
    //This function is only called externally, and declaring it as an external saves gas consumption
    function sayHappyBirthday() public{
        if(now <= contractBirthday + 1 weeks)
            msg.sender.transfer(0.1 ether);
    }
    
    //This function is only called externally, and declaring it as an external saves gas consumption
    function refund() public{
        require(msg.sender == owner);
        if(now > contractBirthday + 1 weeks)
            selfdestruct(msg.sender);
    }
}