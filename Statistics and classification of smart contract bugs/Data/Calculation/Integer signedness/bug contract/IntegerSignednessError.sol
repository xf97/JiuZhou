pragma solidity 0.6.2;

//based on Osiris

/*
If A is less than 0, the value of B will be large when A is converted to an 
unsigned integer B of the same width. Consider withdrawOnce function in this 
example, enter a negative value will lead to the contract when the balance 
of a roll out more than 1 ether.
*/

contract signednessError{
    mapping(address => bool) public transferred;
    address public owner;
    
    constructor() public payable{
        owner = msg.sender;
        require(msg.value > 0 && msg.value % 1 ether == 0);
    }
    
    function withdrawOnce (int amount) public {
        if ( amount > 1 ether || transferred [msg.sender]) {
            revert() ;
        }
        //In Solidity, casting a negative integer to an unsigned integer results in an error and does not throw an exception. Avoid such conversions.
        msg.sender.transfer(uint(amount));
        transferred [msg.sender] = true ;
    }
}
