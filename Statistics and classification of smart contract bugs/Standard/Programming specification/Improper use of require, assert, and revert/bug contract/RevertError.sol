pragma solidity 0.6.4;

//from Jiuzhou

//line 22

contract alwaysFalse{
    address public owner;
    
    constructor() public payable{
        owner = msg.sender;
        require(msg.value == 1 ether);
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    function withdrawMoney() onlyOwner external{
        //always false
        if(msg.sender == owner){
            revert();
        }
        msg.sender.transfer(address(this).balance);
    }
}
