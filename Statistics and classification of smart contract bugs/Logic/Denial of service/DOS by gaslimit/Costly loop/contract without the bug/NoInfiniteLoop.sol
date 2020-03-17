pragma solidity 0.6.2;

//When you add 1 to each element of a large array of integers, break the addition step into several steps.

contract gray_ConstlyLoop{
    uint256[] public element;   //a dynamic array
    uint256 public constant addNum = 1;
    address public owner;
    uint256 public index;
    
    constructor() public{
        owner = msg.sender;
        index = 0;
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
    //Use index to break down steps that add 1
    //I'm going to add 1 to _length elements at a time
    function addOne(uint256 _length) public{
        require(msg.sender == owner);
        uint256 boundary = index + _length;
        if(boundary > element.length)
            boundary = element.length;
        for(uint256 i = index; i < boundary; i++)
            element[i] += 1;
        if(boundary == element.length)
            index = 0;  //reset index
        else
            index += _length;   //update index
    }
}