pragma solidity 0.4.26;


contract gray_varIsNotSafe{
    address[] public user;
    uint256[] public balances;
    address public owner;
    
    constructor() public{
        owner = msg.sender;   
    }
    
    function insert() external payable{
        require(msg.value >= 0.1 ether);
        user.push(msg.sender);
        balances.push(msg.value);
    }
    
    function refundAll() external{
        require(msg.sender == owner);
        uint256 _length = user.length;
        for(var i = _length; i < _length; i--){
            bool flag = user[i].send(balances[i]);
            if(flag){
                balances[i] = 0;
            }
        }
    }
}