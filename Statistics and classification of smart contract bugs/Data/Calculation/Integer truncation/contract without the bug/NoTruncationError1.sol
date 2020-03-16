pragma solidity 0.6.2;

//based on Osiris'paper


contract gray_truncationError2{
    mapping(address => uint256) public balances;
    
    constructor() public{
        
    }    
    
    function receiveEther() public payable{
 		//same length
        require(balances[msg.sender] + uint256(msg.value) >= balances[msg.sender]);
        balances[msg.sender] += uint32(msg.value);
    }
}