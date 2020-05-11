pragma solidity 0.6.2;

//Solidity specifies the standard naming style, which makes the source code easier to understand. Try naming using the standard naming style.

contract WrongName{
    uint256 public constant betprice = 0.1 ether;   //should be uppercase and use _ to connect two words
    address[] public users;
    event bet(address indexed _user);   //the 1st char should be uppercase 
    
    //the 1st char should be lowercase
    function Bet() external payable{
        require(msg.value == betprice);
        users.push(msg.sender);
        emit bet(msg.sender);
    }
}