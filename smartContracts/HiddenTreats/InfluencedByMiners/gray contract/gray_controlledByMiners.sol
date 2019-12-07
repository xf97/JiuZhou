pragma solidity 0.5.0;

//based on smartcheck

/*
The global variables that are most easily controlled by the miner are timestamp(now) and block.number. Try to avoid the influence of these two variables on the execution result of the contract.
*/


/*
If possible, do not use global variables controlled by miners; if you have to, 
you can  choose global variables that make it as costly as possible for miners 
to control.
*/




contract gray_Game {
    
    constructor() public{
        
    }
    //For example, use block.coinbase
    function oddOrEven(bool yourGuess) external payable {
        if (yourGuess == uint256(block.coinbase) % 2 > 0) {
            uint fee = msg.value / 10;
            msg.sender.transfer(msg.value * 2 - fee);
        }
    }

    function () external payable {}
}