pragma solidity 0.6.2;


contract NoNestedCall1{
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
    function appendDate(uint256 _ele) public onlyOwner{
        require(msg.sender == owner);
        element.push(_ele);
    }
    
   //One way to fix this is to record the length before the loop begins and only owner can add new element
    function addOne() public onlyOwner{
        require(msg.sender == owner);
        uint256 _length = element.length;
        for(uint256 i = 0; i < _length; i++)
            element[i] += 1;
    }
}