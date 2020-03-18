pragma solidity 0.4.26;

//based on slither

/*
Don't jump to the belief that view functions won't 
change the contract state
*/

contract gray_Constant{
    uint counter;
    constructor(uint256 _counter) public{
        counter = _counter;
    }
    
    function get() external view returns(uint){
       return counter;
    }

    function getPlusTwo() external constant returns(uint){
        return counter;
    }
}