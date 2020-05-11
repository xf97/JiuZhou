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
        //We call a contract in which anyone can withdraw balance a prodigal contract, and the reason for this bug is that the contract does not have access control for withdrawals, allowing anyone to withdraw ethers from the contract.
        msg.sender.transfer(address(this).balance);
    }
}