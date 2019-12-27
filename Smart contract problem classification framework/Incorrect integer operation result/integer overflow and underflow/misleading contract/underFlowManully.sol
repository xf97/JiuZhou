pragma solidity 0.5.0;

//based on knowsec404

contract Token {
    mapping(address => uint) public balances;
    uint public totalSupply;

    constructor(uint _initialSupply) public{
    balances[msg.sender] = totalSupply = _initialSupply;
    }

    function transfer(address _to, uint _value) public returns (bool) {
        //The following code can bypass the judgment by integer underflow
        require(balances[msg.sender] > _value); 
        balances[msg.sender] -= _value;
        require(balances[_to] + _value >= balances[_to]);
        balances[_to] += _value;
        return true;
    }

    function balanceOf(address _owner) public view returns (uint balance) {
        return balances[_owner];
    }
}