pragma solidity 0.5.0;

//based on smartcheck

contract gray_Crowdsale {
    bytes32 private password;
    uint256 private rate;
    uint256 private cap;
    address public owner;

    constructor(address _user, bytes memory _password) public  {
        owner = _user;
        rate = 0;
        cap = 0;
        password = keccak256(_password);
    }
    
    //When the overwhelming role fails, change the role address
    function changeOwner(bytes memory _password) public{
        if(password == keccak256(_password)){
            owner = msg.sender;
        }
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