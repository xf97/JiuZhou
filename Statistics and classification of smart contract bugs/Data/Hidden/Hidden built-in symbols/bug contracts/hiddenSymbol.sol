pragma solidity 0.6.2;

contract HiddenBuiltinSymbols {
    address public owner;
    
    constructor() public payable{
        owner = msg.sender;
        require(msg.value > 0);
    }
    
    //Hidden built-in symbols
    //Solidity defines some built-in symbols, including keywords and special functions. The names of variables, functions, and events that developers define should not be same with the built-in symbols, which can cause the built-in symbols to be hidden. In some cases, this can lead to economic losses.
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