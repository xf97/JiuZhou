pragma solidity 0.6.2;

//from Jiuzhou

//line 18

contract PreSentEther{
    address public owner;
    uint256 public money;
    constructor() public{
        owner == msg.sender;
        money = 0;
    }
    
    //If the malicious user predetermines the deployment 
    //address of this contract and sends some Ethers 
    //to the address in advance, this function will fail.
    function depositOnce() external payable{
        require(address(this).balance == 0);
        money += msg.value;
    }
    
    function withdraw() external{
        require(msg.sender == owner);
        msg.sender.transfer(money);
    }
}