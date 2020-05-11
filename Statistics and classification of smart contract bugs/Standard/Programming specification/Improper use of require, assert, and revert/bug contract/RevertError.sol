pragma solidity 0.6.2;

//from Jiuzhou

// Solidity  language provides several statements ( require ,  assert , and  revert ) to handle errors. These statements are slightly different when used, so they need to be used correctly. For example,  require  should be used for input validation,  assert  should be used to validate invariants, and  revert  is used for termination and rollback transactions. In addition, the  require  does not consume any  gas , but  assert  consumes all available  gas .

//line 25

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
