pragma solidity 0.6.2;

contract gray_BobAnswer{
    uint256 private answer; //miners can see the answer's value
    address payable public owner;
    
    constructor(uint256 _answer) public{
        owner = msg.sender;
        answer = _answer;
    }
    
    //This function returns the ethers
    function whyYouAttackMe() internal{
        uint256 money = address(this).balance % 1 ether;
        owner.transfer(money);
    }
    
    //Attacking the contract is just a waste of ether
    function getAnswer() external payable returns(uint256){
        whyYouAttackMe();
        require(address(this).balance % 1 ether == 0); 
        require(msg.value > 0);
        return answer;
    }
    
    function withdraw() external{
        require(msg.sender == owner);
        msg.sender.transfer(address(this).balance);
    }
}