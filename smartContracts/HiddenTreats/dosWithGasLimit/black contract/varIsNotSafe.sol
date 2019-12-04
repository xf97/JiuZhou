pragma solidity 0.4.24;


contract varIsNotSafe{
    addresses[] public user;
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
    
    //warning: Do not use the following loop for a refund because you do not know who did not receive a refund.
    //Error:When the length of the user array is greater than 255, the refund loop is an infinite loop and the 
    //refund operation never takes effect. Because the type i is inferred to be uint8, the maximum value is 255.
    function refundAll() external{
        require(msg.sender == owner);
        _length = user.length;
        for(var i = 0; i < _length; i++){
            user[i].send(balances[i]);
        }
    }
}