pragma solidity 0.6.2;



contract gray_Proxy {
  address public owner;
  bytes data;

  constructor(bytes memory _data) public payable{
    owner = msg.sender;  
    require(msg.value > 0);
    data = _data;
  }
  
  modifier onlyOwner{
      require(msg.sender == owner);
      _;
  }
  
  function forward() external {
    owner.delegatecall(data);
  }
  
  function withdraw() external{
      require(msg.sender == owner);
      msg.sender.transfer(address(this).balance);
  }

}
