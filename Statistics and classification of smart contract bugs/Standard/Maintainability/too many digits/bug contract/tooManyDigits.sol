pragma solidity 0.6.2;

//based on slither

contract tooManyDigits{
    //In Solidity, scientific counting method is provided to represent big numbers and small numbers, and ether unit is also provided to represent the amount of ether. Trying to write multiple digits in succession with these substitutions, these effectively reduce the chance of making mistakes and make the code easier to understand.
    uint256 public oncePrice = 1000000000000000000; //10^18 
    address[] public users;
    address payable owner;
    
    constructor() public{
        owner = msg.sender;
    }
    
    function withdraw() external{
        require(msg.sender == owner);
        owner.transfer(address(this).balance);
    }
    
    function pay() external payable{
        require(msg.value == oncePrice);    //1 ether 1 time
        users.push(msg.sender);
    }
}