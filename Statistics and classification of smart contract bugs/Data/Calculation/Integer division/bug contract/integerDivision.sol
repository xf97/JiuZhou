pragma solidity 0.6.2;


/*
Solidity doesn't support floating point Numbers very well, and all integers 
that are divided are rounded down. The use of integer division to calcul-
ate the amount of ethers may cause economic losses.
*/

contract getWageNumber {
    uint256 public coefficient;
    uint256 public DailyWage;
    address public boss;
    
    constructor() public{
        DailyWage = 100;
        coefficient = 3;
        boss = msg.sender;
    }
    
    modifier onlyOwner{
        require(msg.sender == boss);
        _;
    }
    
    function setDailyWage(uint256 _wage) external onlyOwner{
        DailyWage = _wage;
    }
    
    function setCoefficient(uint256 _co) external onlyOwner{
        coefficient = _co;
    }
    
    function calculateWage(uint256 dayNumber) external view onlyOwner returns (uint256) {
        uint256 baseWage = DailyWage / coefficient;
        return baseWage * dayNumber;
    }
}