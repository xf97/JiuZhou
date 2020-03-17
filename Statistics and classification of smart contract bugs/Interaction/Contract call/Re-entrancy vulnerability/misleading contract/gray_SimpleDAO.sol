pragma solidity 0.6.2;

//based on swc

/*
Deduct money first, transfer after, can avoid to re-entrancy attack.
*/

contract gray_SimpleDAO {
  mapping (address => uint) public credit;
  bool public flag;
  bytes data;
    
  function donate(address to) payable public{
    credit[to] += msg.value;
  }
    
  function withdraw(uint amount) public{
    if (credit[msg.sender]>= amount) {
        credit[msg.sender]-=amount;
        (flag, data) = msg.sender.call.value(amount)("");
        if(flag == false){
            credit[msg.sender] += amount;
        }
    }
 }  

  function queryCredit(address to) view public returns(uint){
    return credit[to];
  }
}
