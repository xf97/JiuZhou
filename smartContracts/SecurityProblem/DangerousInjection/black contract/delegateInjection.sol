pragma solidity 0.4.24;


/*
Although the contract specifies the whitelist for the delegate call, 
the data for the delegate call is externally controlled. The principal 
can call any function he specifies.
*/

//One solution is to add the white list of delegate addresses

contract delegateInjection {
  address public owner;
  address[] public whiteList;

  constructor() public payable{
    owner = msg.sender;  
    require(msg.value > 0);
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

  function forward(address callee, bytes memory data) public isTrusted(callee){
    require(callee.delegatecall(data));
  }
  
  function withdraw() external{
      require(msg.sender == owner);
      msg.sender.transfer(address(this).balance);
  }

}
