pragma solidity 0.6.2;

//based on SWC

contract Gray_refunder {
    mapping (address => uint) public refunds;
    address public owner;

    constructor() public payable{
        require(msg.value > 0);
        owner = msg.sender;
    }

    function giveMeMoney() external payable{
        require(msg.value > 0);
        refunds[msg.sender] = msg.value;
    }
    
    //good 
    //Let the user pick it up instead of us delivering it
    function refundOne() external{
        require(refunds[msg.sender] != 0);
        msg.sender.transfer(refunds[msg.sender]);
    }
}