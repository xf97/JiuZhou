pragma solidity 0.6.2;


contract HardCodeAddress {
    uint256 private rate;
    uint256 private cap;
    address public owner;
    
    //if the address is wrong, the contract fails.
    constructor() public  {
        //The call fails when the address with which it interacts does not exist or when a contract exception occurs.
        owner = 0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed;
        rate = 0;
        cap = 0;
    }

    function setRate(uint256 _rate) external {
        require(owner == msg.sender);
        rate = _rate;
    }

    function setCap(uint256 _cap) external {
        require (msg.sender == owner);
        cap = _cap;
    }
}