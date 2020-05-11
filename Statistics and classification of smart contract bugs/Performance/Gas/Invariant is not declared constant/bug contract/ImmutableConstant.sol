pragma solidity 0.6.2;

//If you give me 1 ether, you can take 0.1 ether from everyone
//This contract seems illegal

contract waste4{
    //By declaring invariants as constant, that can reduce the gas consumption of deployment contracts. Try to declare all invariants as constant.
    uint256 public ticket = 1 ether;    //Should be declared constant
    uint256 public earnings = 0.1 ether;    //Should be declared constant
    uint256 public number = 0;
    address[] public participants;
    
    constructor() public payable{
        //Start-up capital
        require(msg.value == ticket);
        participants.push(msg.sender);
    }
    
    
    function join() external payable{
        require(msg.value == ticket);
        //Calculation amount
        uint256 money = participants.length * earnings;
        msg.sender.transfer(money);
        number += 1;
    }

    function getNumber() view external returns(uint256){
        return number;
    }
}