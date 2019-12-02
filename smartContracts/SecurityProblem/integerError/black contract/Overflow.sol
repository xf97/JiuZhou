pragma solidity 0.4.21;

//From not-so-smart-contract

contract Overflow {
    uint private sellerBalance=0;
    
  function Overflow() public{
      
  }
    
    function add(uint value) public returns (bool){
        sellerBalance += value; 
    } 
}