pragma solidity 0.6.2;

/*
Let's say Bob solves a problem, and he puts the answer of the problem 
in the contract. Others can get the answer by paying ether to the con-
tract. Bob requires people to pay in round Numbers for ether, so he 
deploys the following contract to Ethereum.
*/

contract BobAnswer{
    uint256 private answer; //miners can see the answer's value
    address public owner;
    
    constructor(uint256 _answer) public{
        owner = msg.sender;
        answer = _answer;
    } 
    
    //Unfortunately, Bob's enemies can force a little bit of ethers 
    //into the contract to disable it.
    function getAnswer() external payable returns(uint256){
        //In Ethereum, you can forced ethers to be sent to an address by self-destructing contracts or mining. Even if that address doesn't want to receive **ethers**, don't make the features of the contract dependent on the contract's balance being at a fixed value (==), where an attacker can affect the features of the contract by sending a little bit of ethers.
        require(address(this).balance % 1 ether == 0); 
        require(msg.value > 0);
        return answer;
    }
    
    function withdraw() external{
        require(msg.sender == owner);
        msg.sender.transfer(address(this).balance);
    }
}