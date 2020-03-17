pragma solidity 0.6.2;


contract Proxy {
  address public owner;
  address[] public whiteList;
  bytes public data;

  constructor(bytes memory _data) public payable{
    owner = msg.sender;  
    require(msg.value > 0);
    data = _data;
  }

  modifier isTrusted(address callee){
    bool flag = false;
    uint256 _length = whiteList.length;
    for(uint256 i = 0; i<_length ; i++){
      if(whiteList[i] == callee){
        flag = true;
        break;
      }
    }
    require(flag);
    _;
  }

  modifier onlyOwner{
    require(owner == msg.sender);
    _;
  }

  function addList(address callee) external onlyOwner{
    whiteList.push(callee);
  }

  function forward(address callee) external isTrusted(callee){
    _forward(callee, data);
  }

  function _forward(address callee, bytes memory _data) internal{
    callee.call(_data);
  }
  
  function withdraw() external{
      require(msg.sender == owner);
      msg.sender.transfer(address(this).balance);
  }

}
