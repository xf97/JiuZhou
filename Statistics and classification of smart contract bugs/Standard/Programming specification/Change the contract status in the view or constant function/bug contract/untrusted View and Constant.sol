pragma solidity 0.4.24;

//based on slither

//The following code can be compiled
/*
Don't jump to the belief that view functions won't 
change the contract state
*/

contract Constant{
    uint counter;
    constructor(uint256 _counter) public{
        counter = _counter;
    }
    
    function get() public view returns(uint){
       counter = counter +1;
       return counter;
    }

    function getPlusTwo() external constant returns(uint){
    	counter += 2;
    	return counter;
    }
}