pragma solidity 0.5.16;

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

//right order

contract D is B, C{
    address public owner;
    constructor() public{
        owner = msg.sender;
    }
}