pragma solidity 0.5.0;

/*
One way to prevent overflow is to manually 
verify the results of each integer operation
*/

contract gray_Token {

  mapping(address => uint) balances;
  uint public totalSupply;
  event Transfer(address _sender, address _reveiver, uint256 _amount);

  constructor(uint _initialSupply) public {
    balances[msg.sender] = totalSupply = _initialSupply;
  }

  function transfer(address _to, uint256 _amount)  public returns (bool success) {
    require(_to != address(0));
    require(_amount <= balances[msg.sender]);
    balances[msg.sender] -= _amount;
    require(balances[_to] + _amount >= balances[_to]);
    balances[_to] += _amount;
    emit Transfer(msg.sender, _to, _amount);
    return true;
}

  function balanceOf(address _owner) public view returns (uint balance) {
    return balances[_owner];
  }
}