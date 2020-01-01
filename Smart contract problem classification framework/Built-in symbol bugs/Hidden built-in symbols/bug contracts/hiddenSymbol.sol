pragma solidity 0.5.0;

contract HiddenBuiltinSymbols {
    address public owner;
    
    constructor() public payable{
        owner = msg.sender;
        require(msg.value > 0);
    }
    
    //Hidden built-in symbols
    function transfer(uint256 money) external returns(uint256){
        return money + 10;
    }
    
    //so the owner cann't take his money back
    function withdraw() external{
        require(msg.sender == owner);
        msg.sender.transfer(address(this).balance);
    }
}