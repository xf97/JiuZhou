pragma solidity 0.5.0;
//From Osiris

contract truncationError{
    mapping(address => uint32) public balances;
    
    function receiveEther() public payable{
        require(balances[msg.sender] + uint32(msg.value) >= balances[msg.sender]);
        balances[msg.sender] += uint32(msg.value);
    }
}