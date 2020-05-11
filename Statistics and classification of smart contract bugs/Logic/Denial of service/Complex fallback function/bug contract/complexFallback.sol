pragma solidity 0.6.2;

/*
The fallback function should
be kept as simple as possible to 
remove unwanted statements from
the function
*/

contract complexFallback{
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
    
    //If you paid, record that you paid.
    /*
    In the worst case, this will traverse the entire array, 
    and when the array size is large, it will consume a large 
    amount of gas.
    */
    //In Ethereum, the contract always uses the fallback function by default to respond to transfers. In general, most contracts use send-statements or transfer-statements to send ethers, both of which carry only 2300 gas. When the fallback function of the contract consumes more than 2300 gas, the transfer will fail. In exceptional circumstances, this will render the external contract dysfunctional and the contract unable to receive transfers.
    fallback() external payable{
        require(msg.value > 0);
        for(uint256 i = 0; i < payer.length; i++){
            if(msg.sender == payer[i])
                money[i] += msg.value;
        }
    }
}