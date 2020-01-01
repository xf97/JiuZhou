pragma solidity 0.5.0;

//based on swc

/*
A simple model of The DAO contract
*/

//warning: the contract contains a re-entrancy vulnerability

contract NoSimpleDAO {
  mapping (address => uint) public credit;
  bool public flag;
  bytes data;
  address payable owner;
  
  constructor() public{
      owner = msg.sender;
  }
  modifier onlyOwner{
      require(owner == msg.sender);
      _;
  }
  
  function emergency() external onlyOwner{
      selfdestruct(owner);
  }
    
  function donate(address to) payable public{
    credit[to] += msg.value;
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
