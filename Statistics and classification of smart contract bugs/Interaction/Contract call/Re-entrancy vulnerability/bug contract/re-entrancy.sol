pragma solidity 0.6.2;

//based on not-so-smart-contract


//line 24

contract Reentrance {
    mapping (address => uint256) userBalance;
   
    function getBalance(address u) public view returns(uint){
        return userBalance[u];
    }

    function addToBalance() public payable{
        userBalance[msg.sender] += msg.value;
    }   

    function withdrawBalance() public {
        bool flag;
        bytes memory data;
        // send userBalance[msg.sender] ethers to msg.sender
        // if mgs.sender is a contract, it will call its fallback function
        //The Re-entrancy vulnerability can lead to the theft of the ethers from the contract. Generally, avoid using the call-statement to transfer ethers. If you have to, you can deduct the money first and then transfer it.
        (flag, data) = msg.sender.call.value(userBalance[msg.sender])("");
        if( !flag ){
            revert();
        }
        userBalance[msg.sender] = 0;
    }   
}

