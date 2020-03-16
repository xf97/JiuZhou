pragma solidity 0.6.2;

//based on Osiris'paper

/*
A rare integer error is the truncation error, which occurs when a longer 
type is truncated to a shorter type, potentially resulting in a loss of 
accuracy.
*/

contract truncationError{
    mapping(address => uint32) public balances;
    
    constructor() public{
        
    }    
    
    function receiveEther() public payable{
        //truncation Error
        require(balances[msg.sender] + uint32(msg.value) >= balances[msg.sender]);
        balances[msg.sender] += uint32(msg.value);
    }
}