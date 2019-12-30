pragma solidity 0.5.0;


contract gray_delegateInjection {
  address public owner;
  bytes data;
  address[] public whiteList;

  constructor(bytes memory _data) public payable{
    owner = msg.sender;  
    require(msg.value > 0);
    data = _data;
  }
  
  modifier onlyOwner{
      require(msg.sender == owner);
      _;
  }
  
  modifier onlyList(address _addr){
      bool flag = false;
      uint256 _length = whiteList.length;
      for(uint256 i = 0; i<_length; i++){
          if(whiteList[i] == _addr){
              flag = true;
              break;
          }
      }
      require(flag);
      _;
  }
  
  function addNewOne(address _addr) external onlyOwner{
      whiteList.push(_addr);
  }
  

  function forward(address callee) public onlyList(callee){
    callee.delegatecall(data);
  }
  
  function withdraw() external{
      require(msg.sender == owner);
      msg.sender.transfer(address(this).balance);
  }
}
