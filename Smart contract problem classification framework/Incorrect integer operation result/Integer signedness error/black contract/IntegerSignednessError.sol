pragma solidity 0.5.0;

//based on Osiris

/*
If A is less than 0, the value of B will be large when A is converted to an 
unsigned integer B of the same width. Consider withdrawOnce function in this 
example, enter a negative value will lead to the contract when the balance 
of a roll out more than 1 ether.
*/

contract signednessError{
    mapping(address => bool) public transferred;
    
    constructor() public{
        
    }
    
    function withdrawOnce (int amount) public {
        if ( amount > 1 ether || transferred [msg.sender]) {
            revert() ;
        }
        msg.sender.transfer(uint(amount));
        transferred [msg.sender] = true ;
    }
}
