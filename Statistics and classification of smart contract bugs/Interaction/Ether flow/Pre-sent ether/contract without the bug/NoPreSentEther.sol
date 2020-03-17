pragma solidity 0.6.2;

//from Jiuzhou


contract No_PreSentEther{
    address public owner;
    uint256 public money;
    bool public flag;
    constructor() public{
        owner == msg.sender;
        money = 0;
        flag = false;
    }
    
    function depositOnce() external payable{
        //require(address(this).balance == 0);
        require(flag == false);
        money += msg.value;
        flag = true;
    }
    
    function withdraw() external{
        require(msg.sender == owner);
        msg.sender.transfer(money);
    }
}