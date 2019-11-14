pragma solidity 0.5.0;

//From smartcheck

contract MyContract {

    uint constant BONUS = 500;
    uint constant DELIMITER = 10000;
    
    constructor() public{
        
    }

    function calculateBonus(uint256 amount) public returns (uint256) {
        //If you divide before you multiply, you're going to lose more.
        return amount/DELIMITER*BONUS;
    }
}