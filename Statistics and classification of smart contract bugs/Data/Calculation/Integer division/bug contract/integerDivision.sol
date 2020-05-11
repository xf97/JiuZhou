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
    //Until now, Solidity doesn't support decimals or fixed-point numbers, and all integer division results are rounded down, which can lead to a loss of accuracy. Avoid using integer division to calculate the amount of ethers. If you have to, try multiplying before dividing to offset the loss of accuracy.
        uint256 baseWage = DailyWage / coefficient;
        return baseWage * dayNumber;
    }
}