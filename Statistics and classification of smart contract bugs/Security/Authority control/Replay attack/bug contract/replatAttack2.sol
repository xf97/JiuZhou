pragma solidity 0.6.2;

contract proxy{
    mapping(address => uint256) public balances;
    mapping(address => uint256) public nonces;
    event Transfer(address indexed _from, address indexed _to, uint256 _v);
    address public owner;
    
    constructor() public{
        owner = msg.sender;
    }
    
    function addMan(address _addr, uint256 _mon, uint256 _non) external{
        require(msg.sender == owner);
        balances[_addr] = _mon;
        balances[_addr] = _non;
    }

    //Nonce can be prevented and eventually verified
    function transferProxy(address _from, address _to, uint256 _value, uint256 _fee,
        uint8 _v, bytes32 _r, bytes32 _s) public returns (bool){

        if(balances[_from] < _fee + _value 
            || _fee > _fee + _value) revert();

        uint256 nonce = nonces[_from];
        //As Ethereum has been divided many times, there are many chains in Ethereum now. Therefore, confirm the non repeatability of the verification to avoid the attacker replaying the transaction on another chain.
        bytes32 h = keccak256(abi.encode(_from,_to,_value,_fee,nonce,address(this)));
        if(_from != ecrecover(h,_v,_r,_s)) revert();

        if(balances[_to] + _value < balances[_to]
            || balances[msg.sender] + _fee < balances[msg.sender]) revert();
        balances[_to] += _value;
        emit Transfer(_from, _to, _value);

        balances[msg.sender] += _fee;
        emit Transfer(_from, msg.sender, _fee);

        balances[_from] -= _value + _fee;
        nonces[_from] = nonce + 1;
        return true;
    }
}