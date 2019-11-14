pragma solidity 0.5.0;

contract signednessError{
    mapping(address => bool) public transferred;
    
    constructor() public{
        
    }
    
    function withdrawOnce (int amount ) public {
        if ( amount > 1 ether || transferred [msg.sender]) {
            revert() ;
        }
        msg.sender.transfer(uint(amount));
        transferred [msg.sender] = true ;
    }
}

