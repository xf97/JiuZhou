pragma solidity 0.6.2;

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
        uint256 _length = element.length;
        /*
        When the length of the array is greater than or equal to 256, 
        the loop is an infinite loop.
        */
        //Loops are usually the most executed part of a program, and the more statements are executed, the more gas is consumed. If the transaction contains an infinite loop, the transaction will fail after exhausting the gas paid by the caller, and gas will not be refunded. You should avoid the huge loop in contracts, and if you have to, try breaking the loop into pieces.
        for(uint8 i = 0; i < _length; i++)
            element[i] += 1;
    }
}