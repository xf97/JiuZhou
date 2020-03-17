pragma solidity 0.6.2;

//based on swc

/*
The address and parameters of the delegate call are controlled by 
external input, which is dangerous, meaning that an attacker can 
load any piece of code that is executed in this contract.
*/

contract Proxy {
  address public owner;

  constructor() public payable{
    owner = msg.sender;  
    require(msg.value > 0);
  }

  function forward(address callee, bytes calldata data) external {
    callee.delegatecall(data);
  }
  
  function withdraw() external{
      require(msg.sender == owner);
      msg.sender.transfer(address(this).balance);
  }

}
