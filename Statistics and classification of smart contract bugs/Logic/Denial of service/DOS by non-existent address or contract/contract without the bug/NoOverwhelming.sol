pragma solidity 0.6.2;

//based on smartcheck

contract Crowdsale {
    uint256 private rate;
    uint256 private cap;
    address public owner1;
    address public owner2;
    
    //There is little chance that both addresses will fail
    constructor(address _user1, address _user2) public  {
        owner1 = _user1;
        owner2 = _user2;
        rate = 0;
        cap = 0;
    }

    function setRate(uint256 _rate) public  {
        require(owner1 == msg.sender || owner2 == msg.sender);
        rate = _rate;
    }

    function setCap(uint256 _cap) public {
        require (msg.sender == owner1 || msg.sender == owner2);
        cap = _cap;
    }
}