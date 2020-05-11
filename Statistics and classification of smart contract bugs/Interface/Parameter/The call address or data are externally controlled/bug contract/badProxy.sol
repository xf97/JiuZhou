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
    //If both the call data and the call address are externally controlled, this is a great danger. This means that the attacker can specify the call address (which can be the attacking contract he developed), the call function and the parameters (which can be the attacking function in the contract and the appropriate parameters) at will, making the contract very dangerous.
    callee.delegatecall(data);
  }
  
  function withdraw() external{
      require(msg.sender == owner);
      msg.sender.transfer(address(this).balance);
  }

}
