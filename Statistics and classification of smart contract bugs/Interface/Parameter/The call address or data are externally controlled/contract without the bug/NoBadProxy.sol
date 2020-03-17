pragma solidity 0.6.2;

//based on swc


contract gray_Proxy {
  address public owner;
  bytes public data;

  constructor(bytes memory _data) public payable{
    owner = msg.sender;  
    require(msg.value > 0);
    data = _data;
  }

  function forward() external {
    owner.call(data);
  }
  
  function withdraw() external{
      require(msg.sender == owner);
      msg.sender.transfer(address(this).balance);
  }

}
