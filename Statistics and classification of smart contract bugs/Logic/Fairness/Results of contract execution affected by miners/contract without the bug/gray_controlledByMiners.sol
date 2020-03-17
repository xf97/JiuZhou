pragma solidity 0.6.2;

//based on smartcheck
/*
If possible, do not use global variables controlled by miners; if you have to, you can  choose global variables that make it as costly as possible for miners to control.
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

    fallback () external payable {}
}