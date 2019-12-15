pragma solidity 0.5.0;

//based on Osiris

/*
Or, if there is no loss of accuracy when truncation occurs, it can be truncated.
*/

contract truncationError{
    mapping(address => uint32) public balances;
    
    function receiveEther() public payable{
        require(msg.value == uint32(msg.value));
        require(balances[msg.sender] + uint32(msg.value) >= balances[msg.sender]);
        balances[msg.sender] += uint32(msg.value);
    }
}