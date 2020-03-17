pragma solidity 0.4.26;


contract varIsNotSafe{
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
    
    //Error:When the length of the user array is greater than 255, the refund loop is an infinite loop and the 
    //refund operation never takes effect. Because the type i is inferred to be uint8, the maximum value is 255.
    function refundAll() external{
        require(msg.sender == owner);
        uint256 _length = user.length;
        for(var i = 0; i < _length; i++){
            bool flag = user[i].send(balances[i]);
            if(flag){
                balances[i] = 0;
            }
        }
    }
}