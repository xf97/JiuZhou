pragma solidity 0.6.2;


contract gray_varIsNotSafe{
    address payable[] public user;
    uint256[] public balances;
    address public owner;
    uint256 public index;
    
    constructor() public{
        owner = msg.sender; 
        index = 0;  
    }
    
    function insert() external payable{
        require(msg.value >= 0.1 ether);
        user.push(msg.sender);
        balances.push(msg.value);
    }
    
    //tips: You can specify the type of i manually
    function refund(uint256 _length) external{
        require(msg.sender == owner);
        uint256 boundary = index + _length;
        if(boundary > user.length)
            boundary = user.length;
        for(uint256 i = index; i < boundary; i++){
            bool flag = user[i].send(balances[i]);
            if(flag){
                balances[i] = 0; 
            }
        }
        if(boundary == user.length)
            index = 0;  //reset index
        else
            index += _length;   //update index
    }
}
