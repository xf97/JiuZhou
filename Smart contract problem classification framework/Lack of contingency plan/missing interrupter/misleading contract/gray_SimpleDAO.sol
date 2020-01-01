pragma solidity 0.5.0;

//warning: the contract contains a re-entrancy vulnerability

contract gray_SimpleDAO {
  mapping (address => uint) public credit;
  bool public flag;
  bytes data;
  address public owner;
    
  function donate(address to) payable public{
    credit[to] += msg.value;
    owner = msg.sender;
  }
  
  //When the emergency operation is successful, return 2. Otherwie return 1. But careless developers 
  //write the return-statement before the selfdestruct-statement, making the selfdestruct-statement 
  //unreachable.
  function emergencyOpe() external returns(uint256){
        if(owner == msg.sender){
            return 2;
            selfdestruct(msg.sender);
        }
        else
            return 1;
  }
    
  function withdraw(uint amount) public{
    if (credit[msg.sender]>= amount) {
        (flag, data) = msg.sender.call.value(amount)("");
        if(flag == true){
             credit[msg.sender]-=amount;
        }
     
    }
 }  

  function queryCredit(address to) view public returns(uint){
    return credit[to];
  }
}
