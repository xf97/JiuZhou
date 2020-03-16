pragma solidity 0.5.16;

/*
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
*/
//no inheritance

contract D {
    uint256 public num;
    address public owner;
    
    constructor(uint256 _num) public{
        owner = msg.sender;
        num = _num;
    }
    
    function getNum() view public returns(uint256){
        return num + 10;
    }
}