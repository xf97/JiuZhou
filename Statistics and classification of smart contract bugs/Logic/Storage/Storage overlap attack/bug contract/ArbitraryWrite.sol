pragma solidity 0.6.2;

//based on swc
//Unsafe array manipulation and arbitrary write storage locations

contract Wallet {
    uint[] private bonusCodes;
    address private owner;

    constructor() public {
        bonusCodes = new uint[](0);
        owner = msg.sender;
    }

    fallback () external payable {
    }
    
    //anyone can write data into this array
    function PushBonusCode(uint c) external {
        //All data in a smart contract share a single storage space, and if data is arbitrarily written to the storage, it can cause data to overwrite each other. There is no problem writing to the store, but authentication is required and only a few people can write to the store.
        bonusCodes.push(c);
    }

    //bonusCodes.length can be underflow
    function PopBonusCode() external {
        require(0 <= bonusCodes.length);
        bonusCodes.pop();
    }
    
    //when bonusCodes.length can be underflow, the require-statement is always true.
    //anyone can write data into this contract
    function UpdateBonusCodeAt(uint idx, uint c) external {
        require(idx < bonusCodes.length);
        bonusCodes[idx] = c;
    }

    function Destroy() public {
        require(msg.sender == owner);
        selfdestruct(msg.sender);
    }
}

