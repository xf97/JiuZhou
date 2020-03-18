pragma solidity 0.6.2;

//from Jiuzhou


contract NoalwaysFalse{
    address public owner;
    
    constructor() public payable{
        owner = msg.sender;
        require(msg.value == 1 ether);
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    function withdrawMoney() external{
        if(msg.sender != owner){
            revert();
        }
        else
            msg.sender.transfer(address(this).balance);
    }
}
