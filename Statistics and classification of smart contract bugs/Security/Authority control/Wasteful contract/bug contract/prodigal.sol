pragma solidity 0.6.2;

contract prodigal{
    address public owner;
    constructor() public payable{
        owner = msg.sender;
        require(msg.value > 0);
    }
    
    modifier onlyOnwer{
        require(msg.sender == owner);
        _;
    }
    
    /*
    Careless developers forget to use the modifier, allowing anyone to withdraw their contract balances.
    */
    function withdraw() external{
        msg.sender.transfer(address(this).balance);
    }
}