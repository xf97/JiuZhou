pragma solidity 0.4.26;

//based on slither

//The following code can be compiled
/*
Don't jump to the belief that view functions won't 
change the contract state
*/

//The keywords  view  and  constant  (before *Solidity 0.5.0 version*) are provided in *Solidity* to decorate the functions, which means that the functions only read data from the blockchain without modifying the data. However, such a rule is not mandatory, which means that the developer can modify the data in the function declared  view  or  constant . If your contract requires that the other contract's view or  constant  functions cannot modify the data, you should check the other contract manually.

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