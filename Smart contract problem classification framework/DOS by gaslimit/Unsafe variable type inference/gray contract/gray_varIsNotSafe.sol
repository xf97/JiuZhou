pragma solidity 0.4.24;

/*
Calling a local state variable through this results in more gas consumption.
*/

contract gray_varIsNotSafe{
    addresses[] public user;
    uint256[] public balances;
    address public owner;
    
    constructor() public{
        owner = msg.sender;   
    }
    
    function insert() external payable{
        require(msg.value >= 0.1 ether);
        user.push(msg.sender);
        balances.push(msg.value);pragma solidity 0.4.24;

/*
Calling a local state variable through this results in more gas consumption.
*/

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
    
    //warning: Do not use the following loop for a refund because you do not know who did not receive a refund.
    //tips: You can specify the type of i manually
    function refundAll() external{
        require(msg.sender == owner);
        uint256 _length = user.length;
        for(uint256 i = 0; i < _length; i++){
            user[i].send(balances[i]);
        }
    }
}
    }
    
    //warning: Do not use the following loop for a refund because you do not know who did not receive a refund.
    //tips: You can specify the type of i manually
    function refundAll() external{
        require(msg.sender == owner);
        _length = user.length;
        for(uint256 i = 0; i < _length; i++){
            user[i].send(balances[i]);
        }
    }
}