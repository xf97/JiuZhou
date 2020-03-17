pragma solidity 0.6.2;


contract grayHardCodeAddress {
    uint256 private rate;
    uint256 private cap;
    address public owner;
    address public boss;
    
    //althrough the address is wrong, the contract also can change the owner
    constructor() public  {
        boss = msg.sender;
        owner = 0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed;
        rate = 0;
        cap = 0;
    }
    
    modifier onlyBoss{
        require(msg.sender == boss);
        _;
    }
    
    function changeOwner(address newOwner) external onlyBoss{
        owner = newOwner;
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