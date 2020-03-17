pragma solidity 0.6.2;

//based on swc 

contract Wallet {
    uint[] private bonusCodes;
    address private owner;

    constructor() public {
        bonusCodes = new uint[](0);
        owner = msg.sender;
    }

    fallback () external payable {
    }

    //only owner can write data into this array.
    function PushBonusCode(uint c) public {
        require(msg.sender == owner);
        bonusCodes.push(c);
    }
    
    //only owner can write data into this array.
    function PopBonusCode() public {
        require(msg.sender == owner);
        require(0 < bonusCodes.length); //now, the minimum value of length is zero, not -1
        bonusCodes.pop();
    }

    function UpdateBonusCodeAt(uint256 idx, uint c) public {
        require(idx < bonusCodes.length); 
        bonusCodes[idx] = c;
    }

    function Destroy() public {
        require(msg.sender == owner);
        selfdestruct(msg.sender);
    }
}
