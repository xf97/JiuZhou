pragma solidity 0.4.24;


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
        //Overflow occurs when 'i' is less than 0, 
        //and the overflow value will be greater than or equal to _length,
        //the loop stops.
        for(var i = _length; i < _length; i--){
            user[i].send(balances[i]);
        }
    }
}