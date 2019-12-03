pragma solidity 0.5.0;

//from swc
//Unsafe array manipulation and arbitrary write storage locations

contract Wallet {
    uint[] private bonusCodes;
    address private owner;

    constructor() public {
        bonusCodes = new uint[](0);
        owner = msg.sender;
    }

    function () external payable {
    }
    
    //anyone can write data into this array
    function PushBonusCode(uint c) public {
        bonusCodes.push(c);
    }

    //bonusCodes.length can be -1
    function PopBonusCode() public {
        require(0 <= bonusCodes.length);
        bonusCodes.length--;
    }
    
    //when bonusCodes.length = -1, the require-statement is always true.
    //anyone can write data into this contract
    function UpdateBonusCodeAt(uint idx, uint c) public {
        require(idx < bonusCodes.length);
        bonusCodes[idx] = c;
    }

    function Destroy() public {
        require(msg.sender == owner);
        selfdestruct(msg.sender);
    }
}

