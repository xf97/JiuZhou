pragma solidity 0.4.26;

contract NoMissContructor{
    address public owner;
    
    function NoMissContructor() public payable{
        owner = msg.sender;
        require(msg.value > 0);
    }
    
    function getMyBalance() external{
        require(msg.sender == owner);
        msg.sender.transfer(address(this).balance);
    }
}