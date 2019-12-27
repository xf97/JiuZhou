pragma solidity 0.5.0;


//One possible solution is for the contract owner to specify msg.data

contract gray_DelegateInjection {
  address public owner;
  address[] public whiteList;
  bytes public data;

  constructor() public payable{
    owner = msg.sender;  
    require(msg.value > 0);
  }
  
  function setData(bytes calldata   _data) external onlyOwner{
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
    callee.delegatecall(data);
  }
  
  function withdraw() external{
      require(msg.sender == owner);
      msg.sender.transfer(address(this).balance);
  }

}
