pragma solidity 0.5.0;

contract NoHiddenBuiltinSymbols {
    address public owner;
    
    constructor() public payable{
        owner = msg.sender;
        require(msg.value > 0);
    }
    
    function getMoney(uint256 money) pure external returns(uint256){
        return money + 10;
    }
    
    //now the owner can take his money back
    function withdraw() external{
        require(msg.sender == owner);
        msg.sender.transfer(address(this).balance);
    }
}