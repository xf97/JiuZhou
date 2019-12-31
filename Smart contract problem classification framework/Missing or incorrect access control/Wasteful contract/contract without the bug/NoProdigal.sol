pragma solidity 0.5.0;

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