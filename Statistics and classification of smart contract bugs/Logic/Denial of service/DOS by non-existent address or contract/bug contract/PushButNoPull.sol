pragma solidity 0.6.2;

//based SWC

contract Refunder {
    
address payable[] private refundAddresses;
mapping (address => uint) public refunds;

    constructor() public{
        refundAddresses.push(0xfB6916095ca1df60bB79Ce92cE3Ea74c37c5d359);
        refundAddresses.push(0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed);
    }

    // bad
    function refundAll() public {
        for(uint256 x = 0; x < refundAddresses.length; x++) { // arbitrary length iteration based on how many addresses participated
            //The call fails when the address with which it interacts does not exist or when a contract exception occurs.
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