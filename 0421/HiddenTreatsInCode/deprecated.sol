pragma solidity 0.4.21;

contract DeprecatedSimple {
    address public owner;
    
    function DeprecatedSimpleFixed() public{
        owner = msg.sender;
    }
    
    function killMyself() public{
        if(msg.sender == owner){
            suicide(owner);
        }
    }

}