pragma solidity 0.4.24;

//based on swc

/*
The address and parameters of the delegate call are controlled by 
external input, which is dangerous, meaning that an attacker can 
load any piece of code that is executed in this contract.
*/

contract Proxy {
  address public owner;
  bytes data;

  constructor(bytes memory _data) public payable{
    owner = msg.sender;  
    require(msg.value > 0);
    data = _data;
  }

  function forward(address callee) public {
    require(callee.delegatecall(data));
  }
  
  function withdraw() external{
      require(msg.sender == owner);
      msg.sender.transfer(address(this).balance);
  }

}
pragma solidity 0.4.24;

//based on swc

/*
The address and parameters of the delegate call are controlled by 
external input, which is dangerous, meaning that an attacker can 
load any piece of code that is executed in this contract.
*/

contract Proxy {
  address public owner;
  bytes data;

  constructor(bytes memory _data) public payable{
    owner = msg.sender;  
    require(msg.value > 0);
    data = _data;
  }

  function forward(address callee) public {
    require(callee.delegatecall(data));
  }
  
  function withdraw() external{
      require(msg.sender == owner);
      msg.sender.transfer(address(this).balance);
  }

}
