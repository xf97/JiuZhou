pragma solidity 0.5.0;

contract A{
    uint256 public num;
    function getNum() view public returns(uint256){
        return num;
    }
}

contract B is A{
    constructor(uint256 _num) public{
        num = _num;
    }
}

contract C is A{
    function getNum() view public returns(uint256){
        return num + 10;
    }
}

/*
Now, you want getNum in C, but you end up with getNum 
in A because you specified the wrong inheritance order.
(A is the last one)
*/

contract D is C, B{
    address public owner;
    constructor() public{
        owner = msg.sender;
    }
}