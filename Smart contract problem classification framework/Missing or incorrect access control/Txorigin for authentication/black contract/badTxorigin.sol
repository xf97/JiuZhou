pragma solidity 0.5.0;

/*
Authentication using tx.origin is
always dangerous, and attackers can 
gain your trust by forwarding your 
calls.
*/


/*
I use this contract to store the ethers, 
and then I withdraw the money when the ether increase in price
*/
contract badTxorigin{
    address public owner;
    
    constructor() public payable{
        owner = msg.sender;
        require(msg.value > 0);
    }
    
    /*
    But I had a bad friend who offered to pay me if I 
    called a function of his contract. I believed him, 
    and he forwarded my call to this contract and 
    eventually withdrew all my money.
    */
    function withdraw() external{
        require(tx.origin == owner);
        msg.sender.transfer(address(this).balance);
    }
}