pragma solidity 0.6.2;

//based https://github.com/quantstamp/solidity-analyzer/blob/master/test/inputs/input1.sol

//line 15

contract privatePass {

  uint private owner;
  constructor(uint i_owner) public {
    owner = i_owner;
  }
  
  //external function accesses private variable
  function resetOwner() external {
  	owner = 0;
  }
}