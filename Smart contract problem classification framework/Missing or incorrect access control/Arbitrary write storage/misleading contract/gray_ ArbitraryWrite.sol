pragma solidity 0.5.0;

//based on swc 

contract Wallet {
    uint[] private bonusCodes;
    address private owner;

    constructor() public {
        bonusCodes = new uint[](0);
        owner = msg.sender;
    }

    function () external payable {
    }

    //only someone or some members of organization can write data into this array.
    function PushBonusCode(uint c) public {
        require(msg.sender == owner);
        bonusCodes.push(c);
    }
	
    //only someone or some members of organization can write data into this array.
    function PopBonusCode() public {
        require(msg.sender == owner);
        require(0 < bonusCodes.length);	//now, the minimum value of length is zeor, not -1
        bonusCodes.length--;
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
