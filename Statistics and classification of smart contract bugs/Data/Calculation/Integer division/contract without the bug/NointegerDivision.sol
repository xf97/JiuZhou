pragma solidity 0.6.2;

//Use multiplication instead of division

contract NoGetWageNumber {
    uint256 public coefficient_reciprocal;  //The coefficient_reciprocal is the inverse of the coefficient
    uint256 public DailyWage;
    address public boss;
    
    constructor() public{
        DailyWage = 100;
        coefficient_reciprocal = 3;
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
        coefficient_reciprocal = _co;
    }
    
    function calculateWage(uint256 dayNumber) view external onlyOwner returns (uint256) {
        uint256 baseWage = DailyWage * coefficient_reciprocal;
        return baseWage * dayNumber;
    }
}