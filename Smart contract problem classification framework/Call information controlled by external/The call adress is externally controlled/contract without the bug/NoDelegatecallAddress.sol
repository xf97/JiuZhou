pragma solidity 0.5.0;


contract gray_DelegateInjection {
  address public owner;
  address[] public whiteList;
  bytes public data;

  constructor() public payable{
    owner = msg.sender;  
    require(msg.value > 0);
  }
  
  function setData(bytes calldata _data) external onlyOwner{
      data = _data;
  }
  
  modifier onlyOwner{
      require(msg.sender == owner);
      _;
  }

  function forward() public{
    owner.delegatecall(data);
  }
  
  function withdraw() external{
      require(msg.sender == owner);
      msg.sender.transfer(address(this).balance);
  }

}
