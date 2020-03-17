pragma solidity 0.6.2;

/*
Using a mutex can effectively evade re-entrancy attacks
*/

contract EtherStore{
    
    bool reEntrancyMutex = false;
    uint256 public withdrawLimit = 1 ether;
    mapping( address => uint256) public lastWithdrawTime;
    mapping( address => uint256) public balances;
    bool public flag;
    bytes public data;
    
    constructor() public{
        
    }
    
    function depositFunds() public payable{
        balances[msg.sender] += msg.value;
    }
    
    function withdrawFunds(uint256 _weiToWithdraw) public{
        require(!reEntrancyMutex);
        require(balances[msg.sender] >= _weiToWithdraw);
        require(_weiToWithdraw <= withdrawLimit);
        require(now >= lastWithdrawTime[msg.sender] + 1 weeks);
        balances[msg.sender] -= _weiToWithdraw;
        lastWithdrawTime[msg.sender] = now;
        reEntrancyMutex = true;
        (flag, data) = msg.sender.call.value(_weiToWithdraw)("");
        require(flag);
        reEntrancyMutex =false;
    }
}
