pragma solidity 0.6.2;

contract SplitReentrancy{
    mapping(address => uint256) public tokenBalance;
    address public owner;
    
    constructor() public{
        owner = msg.sender;
    }
    
    function deposit() external payable{
        require(msg.value > 0);
        tokenBalance[msg.sender] = msg.value;
    }
    
    function withdraw_step1(uint256 _money) external{
        require(_money <= tokenBalance[msg.sender]);
        bool flag;
        bytes memory data;
        //The re-entrancy vulnerability can lead to the theft of the ethers from the contract. Generally, avoid using the call-statement to transfer ethers. If you have to, you can deduct the money first and then transfer it.
        (flag, data) = msg.sender.call.value(_money)("");
        if(flag == true){
            withdraw_step2(_money);
        }
    }
    
    function withdraw_step2(uint256 _money) internal{
        tokenBalance[msg.sender] -= _money;
    }
}