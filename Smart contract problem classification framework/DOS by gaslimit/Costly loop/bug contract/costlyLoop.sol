pragma solidity 0.5.1;

//When you add 1 to each element of a large array of integers, break the addition step into several steps.

contract CostlyLoop{
    uint256[] public element;   //a dynamic array
    uint256 public constant addNum = 1;
    address public owner;
    
    constructor() public{
        owner = msg.sender;
    }
    
    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }
    
    //only owner can write data into this array
    function appendDate(uint256 _ele) public onlyOwner{
        require(msg.sender == owner);
        element.push(_ele);
    }
    
    function addOne() public onlyOwner{
        require(msg.sender == owner);
        uint256 _length = element.length;
        /*
        When the length of the array is greater than or equal to 256, 
        the loop is an infinite loop.
        */
        for(uint8 i = 0; i < _length; i++)
            element[i] += 1;
    }
}