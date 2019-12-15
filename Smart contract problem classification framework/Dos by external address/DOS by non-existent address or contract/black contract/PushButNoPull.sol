pragma solidity 0.4.26;

//from SWC

contract Refunder {
    
address[] private refundAddresses;
mapping (address => uint) public refunds;

    constructor() public{
        refundAddresses.push(0x79B483371E87d664cd39491b5F06250165e4b184);
        refundAddresses.push(0x79B483371E87d664cd39491b5F06250165e4b185);
    }

    // bad
    function refundAll() public {
        for(uint256 x = 0; x < refundAddresses.length; x++) { // arbitrary length iteration based on how many addresses participated
            require(refundAddresses[x].send(refunds[refundAddresses[x]])); // doubly bad, now a single failure on send will hold up all funds
        }
    }

    //bad too
    function refundAll_1() public {
        for(uint256 x = 0; x < refundAddresses.length; x++) { // arbitrary length iteration based on how many addresses participated
            refundAddresses[x].transfer(refunds[refundAddresses[x]]); // doubly bad, now a single failure on send will hold up all funds
        }
    }
}