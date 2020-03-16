pragma solidity 0.6.2;

contract HiddenBuiltinSymbols {
    address public owner;
    
    constructor() public payable{
        owner = msg.sender;
        require(msg.value > 0);
    }
    
    //Hidden built-in symbols
    function gasleft() external returns(uint256){
        return 10;
    }
    
    function withdraw() external{
        require(msg.sender == owner);
        //always false
        if (gasleft() >= 2300 )
            msg.sender.transfer(address(this).balance);
    }
}