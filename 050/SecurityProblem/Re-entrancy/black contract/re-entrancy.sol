pragma solidity 0.5.0;

//From project not-so-smart-contract



contract Reentrance {
    mapping (address => uint256) userBalance;
    
    constructor() public{
        
    }
   
    function getBalance(address u) view public returns(uint){
        return userBalance[u];
    }

    function addToBalance() public payable{
        userBalance[msg.sender] += msg.value;
    }   

    function withdrawBalance() public {
        // send userBalance[msg.sender] ethers to msg.sender
        // if mgs.sender is a contract, it will call its fallback function
        require(userBalance[msg.sender] >= 0);
        msg.sender.call.value(userBalance[msg.sender])("");
        userBalance[msg.sender] = 0;
    }   
}
