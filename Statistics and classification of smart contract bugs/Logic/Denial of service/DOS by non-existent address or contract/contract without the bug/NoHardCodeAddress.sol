pragma solidity 0.6.2;

//based on smartcheck

contract NoHardCodeAddress {
    uint256 private rate;
    uint256 private cap;
    address public owner;
    
    //msg.sender is always existing
    constructor() public  {
        owner = msg.sender;
        rate = 0;
        cap = 0;
    }

    function setRate(uint256 _rate) public  {
        require(owner == msg.sender);
        rate = _rate;
    }

    function setCap(uint256 _cap) public {
        require (msg.sender == owner);
        cap = _cap;
    }
}