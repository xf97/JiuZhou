pragma solidity 0.6.2;


contract NobadTxorigin{
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
        //Solidity provides the keyword tx.origin to indicate the source of the transaction. Using tx.origin for authentication can cause an attacker to bypass authentication after spoofing your trust. tx.origin is not recommended for authentication.
        require(tx.origin == owner);
        msg.sender.transfer(address(this).balance);
    }
}