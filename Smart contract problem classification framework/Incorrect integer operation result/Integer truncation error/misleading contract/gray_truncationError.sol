pragma solidity 0.5.0;


contract gray_truncationError{
    mapping(address => uint32) public balances;
    
    constructor() public{
        
    }    
    
    function receiveEther() public payable{
        //There is no loss of accuracy if truncation occurs
        require(msg.value == uint32(msg.value));
        require(balances[msg.sender] + uint32(msg.value) >= balances[msg.sender]);
        balances[msg.sender] += uint32(msg.value);
    }
}