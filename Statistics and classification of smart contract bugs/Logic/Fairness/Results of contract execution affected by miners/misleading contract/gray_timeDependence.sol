pragma solidity 0.6.2;

//based on swc

/*
The global variables that are most easily controlled by the miner are timestamp(now) and block.number. Try to avoid the influence of these two variables on the execution result of the contract.
*/

contract gray_TimeDependce {
    uint256 public myNumber;
    address private owner;
    
    constructor() public payable{
        owner = msg.sender;
        require(msg.value > 0);
        myNumber = msg.value;
    }
    
    function guess() external payable{
        uint256 time = now; //use timestamp but it is unused
        require(msg.value > 0);
        if(msg.value > myNumber)
            msg.sender.transfer(myNumber);
    }
}