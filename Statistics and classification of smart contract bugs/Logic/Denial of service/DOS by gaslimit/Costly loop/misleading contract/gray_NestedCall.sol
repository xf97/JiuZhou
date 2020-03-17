pragma solidity 0.6.2;

//When you add 1 to each element of a large array of integers, break the addition step into several steps.

contract gray_NestedCall{
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
    
    //only owner can push element into this array
    function appendDate(uint256 _ele) external onlyOwner{
        require(msg.sender == owner);
        element.push(_ele);
    }
    
    function addOne() public onlyOwner{
        require(msg.sender == owner);
        for(uint256 i = 0; i < element.length; i++)
            element[i] += 1;
    }
}