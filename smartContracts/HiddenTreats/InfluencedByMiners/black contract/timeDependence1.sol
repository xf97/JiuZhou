pragma solidity 0.5.0;

//from smartcheck

/*
The global variables that are most easily controlled by the miner are timestamp(now) and block.number. Try to avoid the influence of these two variables on the execution result of the contract.
*/


contract Game {
    
    constructor() public{
        
    }

    function oddOrEven(bool yourGuess) external payable {
        if (yourGuess == block.timestamp % 2 > 0) {
            uint fee = msg.value / 10;
            msg.sender.transfer(msg.value * 2 - fee);
        }
    }

    function () external payable {}
}