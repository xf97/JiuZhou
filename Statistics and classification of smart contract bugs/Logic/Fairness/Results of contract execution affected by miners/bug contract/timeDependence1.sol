pragma solidity 0.6.2;

//based on smartcheck

/*
The global variables that are most easily controlled by the miner are timestamp(now) and block.number. Try to avoid the influence of these two variables on the execution result of the contract.
*/


contract Game {
    
    constructor() public{
        
    }

    function oddOrEven(bool yourGuess) external payable {
        if (yourGuess == now % 2 > 0) {
            uint fee = msg.value / 10;
            msg.sender.transfer(msg.value * 2 - fee);
        }
    }

    fallback () external payable {}
}