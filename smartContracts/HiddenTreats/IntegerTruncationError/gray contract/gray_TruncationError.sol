pragma solidity 0.5.0;

//based on Osiris

/*
A rare integer error is the truncation error, which occurs when a longer 
type is truncated to a shorter type, potentially resulting in a loss of 
accuracy.
*/

//However, when converting a shorter type to a longer type, no truncation 
//error occurs.

contract gray_truncationError{
    uint256 public myNumber;
    
    constructor(uint256 _myNumber) public{
        myNumber = _myNumber;
    }    
    
    function shortToLong(uint32 _yourNumber) external{
        //uint32 -> uint256
        require(myNumber + uint256(_yourNumber) >= myNumber);
        myNumber += uint256(_yourNumber);
    }
}