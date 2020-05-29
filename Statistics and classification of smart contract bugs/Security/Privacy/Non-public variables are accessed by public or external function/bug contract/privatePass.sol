pragma solidity 0.6.2;

//based https://github.com/quantstamp/solidity-analyzer/blob/master/test/inputs/input1.sol

//line 15

contract privatePass {

  uint private owner;
  constructor(uint i_owner) public {
    owner = i_owner;
  }
  
  //external function accesses private variable
  //Solidity language requires visibility of specified state variables, of which internal and private specify that state variables can only be accessed internally. But developers can still use the public or external functions to access the internal and private state variables, which may lead to accidental exposure of privacy.
  function resetOwner() external {
  	owner = 0;
  }

  function getOwner() external returns(uint256){
  	return owner;
  }
}