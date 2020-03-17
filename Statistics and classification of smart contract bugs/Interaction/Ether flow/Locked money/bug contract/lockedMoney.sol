pragma solidity 0.6.2;

//based on smartcheck

contract BadMarketPlace {
    function deposit() external payable {
        require(msg.value > 0);
    }
}