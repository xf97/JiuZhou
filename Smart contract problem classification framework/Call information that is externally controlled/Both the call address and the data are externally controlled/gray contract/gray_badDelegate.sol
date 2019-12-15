pragma solidity 0.4.24;

//based on swc

/*
The address and parameters of the delegate call are controlled by 
external input, which is dangerous, meaning that an attacker can 
load any piece of code that is executed in this contract.
*/

//One solution is to add the white list of delegate addresses

contract gray_Proxy {
  address public owner;
  address[] public whiteList;
  bytes public data;

  constructor(bytes memory _data) public payable{
    owner = msg.sender;  
    require(msg.value > 0);
    data = _data;
  }
  
  modifier onlyOwner{
      require(msg.sender == owner);
      _;
  }
  
  modifier isTrusted(address _addr){
      uint256 _length = whiteList.length;
      bool flag = false;
      for(uint256 i = 0; i < _length; i++){
          if(whiteList[i] == _addr){
              flag = true;
          }
      }
      require(flag);
      _;   
  }
  
  function addTurstAddr(address _addr) external onlyOwner{
      whiteList.push(_addr);
  }

  function forward(address callee) public isTrusted(callee){
    require(callee.delegatecall(data));
  }
  
  function withdraw() external{
      require(msg.sender == owner);
      msg.sender.transfer(address(this).balance);
  }

}
