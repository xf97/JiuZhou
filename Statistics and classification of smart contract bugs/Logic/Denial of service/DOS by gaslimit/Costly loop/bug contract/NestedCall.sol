pragma solidity 0.5.0;

//When you add 1 to each element of a large array of integers, break the addition step into several steps.

contract NestedCall{
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
    
    //anyone can push element into this array
    function appendDate(uint256 _ele) public {
        require(msg.sender == owner);
        element.push(_ele);
    }
    
    //When the loop is executed, an attacker can keep adding array elements, causing the loop to keep running.
    function addOne() public onlyOwner{
        require(msg.sender == owner);
        for(uint256 i = 0; i < element.length; i++)
            element[i] += 1;
    }
}