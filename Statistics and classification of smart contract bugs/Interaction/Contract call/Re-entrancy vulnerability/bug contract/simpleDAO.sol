pragma solidity 0.6.2;

//based on swc

/*
A simple model of The DAO contract
*/

contract SimpleDAO {
  mapping (address => uint) public credit;
  bool public flag;
  bytes data;
    
  function donate(address to) payable public{
    credit[to] += msg.value;
  }
    
  function withdraw(uint amount) public{
    if (credit[msg.sender]>= amount) {
        //The re-entrancy vulnerability can lead to the theft of the ethers from the contract. Generally, avoid using the call-statement to transfer ethers. If you have to, you can deduct the money first and then transfer it.
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
