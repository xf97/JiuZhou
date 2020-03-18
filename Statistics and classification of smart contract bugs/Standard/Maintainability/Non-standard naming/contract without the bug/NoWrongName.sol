pragma solidity 0.6.2;

contract NoWrongName{
    uint256 public constant BET_PRICE = 0.1 ether;   //should be uppercase and use _ to connect two words
    address[] public users;
    event Bet(address indexed _user);   //the 1st char should be uppercase 
    
    //the 1st char should be lowercase
    function bet() external payable{
        require(msg.value == BET_PRICE);
        users.push(msg.sender);
        emit Bet(msg.sender);
    }
}