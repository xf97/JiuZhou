pragma solidity 0.5.0;

//based on smartcheck

contract BadMarketPlace {
    function deposit() external payable {
        require(msg.value > 0);
    }
}