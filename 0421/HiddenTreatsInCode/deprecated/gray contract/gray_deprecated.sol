pragma solidity 0.4.21;

contract DeprecatedSimpleFixed {
    address public owner;
    
    function DeprecatedSimpleFixed() public{
        owner = msg.sender;
    }
    
    function killMyself() public{
        if(msg.sender == owner){
            selfdestruct(owner);
        }
    }

}