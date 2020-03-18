pragma solidity 0.6.2;

contract NoProdigal{
    address public owner;
    constructor() public payable{
        owner = msg.sender;
        require(msg.value > 0);
    }
    
    modifier onlyOnwer{
        require(msg.sender == owner);
        _;
    }
    
    function withdraw() external onlyOnwer{
        msg.sender.transfer(address(this).balance);
    }
}