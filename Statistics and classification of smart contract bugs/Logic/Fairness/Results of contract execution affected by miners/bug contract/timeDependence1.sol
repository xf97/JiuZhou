pragma solidity 0.6.2;

//based on smartcheck

/*
The global variables that are most easily controlled by the miner are timestamp(now) and block.number. Try to avoid the influence of these two variables on the execution result of the contract.
*/


contract Game {
    
    constructor() public{
        
    }

    function oddOrEven(bool yourGuess) external payable {
    	//Miners can control attributes such as mining time, and then control the attributes of blocks in smart contracts. For example, if the features of a contract depend on block.timestamp, miners can gain a competitive advantage by controlling the time of mining. At present, the most affected by this bug is block.timestamp (now). Try to avoid using block attributes controlled by miners. If you have to, you can use block attributes that make miners pay a huge price.
        if (yourGuess == now % 2 > 0) {
            uint fee = msg.value / 10;
            msg.sender.transfer(msg.value * 2 - fee);
        }
    }

    fallback () external payable {}
}