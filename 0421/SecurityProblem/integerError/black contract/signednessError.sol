pragma solidity 0.4.21;

contract signednessError{
    mapping(address => bool) public transferred;
    
    function signednessError() public{
        
    }
    
    function withdrawOnce (int amount ) public {
        if ( amount > 1 ether || transferred [msg.sender]) {
            revert() ;
        }
        msg.sender.transfer(uint(amount));
        transferred [msg.sender] = true ;
    }
}
