pragma solidity 0.6.2;

/*
tx.origin is not without its proper application, such 
as the following statement that effectively rejects 
the contract call. tx.origin in this contract is innocent.
*/

contract gray_badTxorigin{
    uint256 public visitTimes;
    
    constructor() public{
        visitTimes = 0;
    }
    
    //Only real user access is recorded, not contract access.
    function visitContract() external{
        require(tx.origin == msg.sender);
        visitTimes += 1;
    }
    
    function getTimes() view external returns(uint256){
        return visitTimes;
    }
}