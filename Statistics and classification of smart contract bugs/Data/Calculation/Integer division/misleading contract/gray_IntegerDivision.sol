pragma solidity 0.6.2;

//If you have to use integer division, multiplication before division can effectively reduce the loss of accuracy.


contract gray_getWageNumber {
    uint256 public coefficient;
    uint256 public DailyWage;
    address public boss;
    uint256 public dayNumber;
    
    constructor() public{
        DailyWage = 100;
        coefficient = 3;
        boss = msg.sender;
        dayNumber = 30;
    }
    
    modifier onlyOwner{
        require(msg.sender == boss);
        _;
    }
    
    function setDayNumber(uint256 _number) external onlyOwner{
        dayNumber = _number;
    }
    
    function setDailyWage(uint256 _wage) external onlyOwner{
        DailyWage = _wage;
    }
    
    function setCoefficient(uint256 _co) external onlyOwner{
        coefficient = _co;
    }
    
    function calculateWage() view external onlyOwner returns (uint256) {
        return dayNumber * DailyWage / coefficient;
    }
}