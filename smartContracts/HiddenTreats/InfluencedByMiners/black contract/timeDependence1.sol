pragma solidity 0.5.0;

//from smartcheck

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