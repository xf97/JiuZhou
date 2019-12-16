pragma solidity 0.5.0;

//When you add 1 to each element of a large array of integers, break the addition step into several steps.

contract CostlyLoop{
    uint256[] public element;   //a dynamic array
    uint256 public constant addNum = 1;
    address public owner;
    
    constructor() public{
        owner = msg.sender;
    }
    
    //only owner can write data into this array
    function appendDate(uint256 _ele) public{
        require(msg.sender == owner);
        element.push(_ele);
    }
    
    /*
    Assuming the array size is already large, adding 1 to each element 
    of the array at one time will result in a large gas consumption and 
    may be DOS with the gaslimit
    */
    function addOne() public{
        require(msg.sender == owner);
        uint256 _length = element.length;
        for(uint256 i = 0; i < _length; i++)
            element[i] += 1;
    }
}