pragma solidity 0.6.2;

contract gray_HiddenBuiltinSymbols {
    address public owner;
    
    constructor() public payable{
        owner = msg.sender;
        require(msg.value > 0);
    }
    
    function transfer(uint256 money) pure external returns(uint256){
        return money + 10;
    }
    
    //Although the above function is also called transfer, 
    //the addr.trasnfer function is used when called, so the transfer is not hidden.
    function withdraw() external{
        require(msg.sender == owner);
        msg.sender.transfer(address(this).balance);
    }
}