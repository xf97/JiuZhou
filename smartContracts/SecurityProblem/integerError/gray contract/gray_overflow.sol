pragma solidity 0.5.0;

contract Overflow {
    uint private sellerBalance=0;
    
    constructor() public{
        
    }

    function safe_add(uint value) public returns (bool){
        require(value + sellerBalance >= sellerBalance);
        sellerBalance += value; 
    } 
}