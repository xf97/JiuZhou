pragma solidity 0.6.2;

//based on not-so-smart-contract


contract NoReentranceBySend {
    mapping (address => uint256) userBalance;
   
    function getBalance(address u) external view returns(uint){
        return userBalance[u];
    }

    function addToBalance() external payable{
        require(userBalance[msg.sender] + msg.value >= userBalance[msg.sender]);
        userBalance[msg.sender] += msg.value;
    }   

    function withdrawBalance() public {
        
        if( ! (msg.sender.send(userBalance[msg.sender]) ) ){
            revert();
        }
        userBalance[msg.sender] = 0;
    }   
}

