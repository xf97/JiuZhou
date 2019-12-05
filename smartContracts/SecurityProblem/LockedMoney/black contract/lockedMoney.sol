pragma solidity 0.5.0;

//from smartcheck

contract BadMarketPlace {
    function deposit() external payable {
        require(msg.value > 0);
    }
}