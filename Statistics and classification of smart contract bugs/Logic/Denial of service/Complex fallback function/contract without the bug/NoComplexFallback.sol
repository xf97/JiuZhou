pragma solidity 0.6.2;

/*
The fallback function should
be kept as simple as possible to 
remove unwanted statements from
the function
*/

contract gray_complexFallback{
    address[] public payer;
    uint256[] public money;
    address public owner;
    
    constructor() public{
        owner = msg.sender;
    }
    
    function addNewPayer(address _payer) external{
        require(msg.sender == owner);
        payer.push(_payer);
        money.push(0);
    }
    
    function getOwnerMoney() external{
        require(msg.sender == owner);
        msg.sender.transfer(address(this).balance);
    }
    
    /*
    If you have to perform a complex operation, 
    set up a separate function to perform the operation.
    So the user can only call your function through the 
    call-statement, he can specify the carrying gas.
    */
    function recordPaid() external payable{
        require(msg.value > 0);
        for(uint256 i = 0; i < payer.length; i++){
            if(msg.sender == payer[i])
                money[i] += msg.value;
        }
    }
    
    fallback() external payable{
        
    }
}