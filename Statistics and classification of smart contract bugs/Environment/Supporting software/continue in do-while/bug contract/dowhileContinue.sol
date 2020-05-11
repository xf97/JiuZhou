pragma solidity 0.4.26;

contract doWhileContinue{
    address[] public owners;
    address public owner;
    
    constructor() public{
        owner = msg.sender;
    }
    
    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }
    
    function addOwner(address _owner) external onlyOwner{
        owners.push(_owner);
    }
    
    function deleteOwner(address _own) external onlyOwner{
        uint256 i = 0;
        uint256 _length = owners.length;
        do{
           if(owners[i] != _own || owners[i] == address(0x0)){
               i++;
               //Prior to version 0.5.0 of solidity, there was a bug with using the do-while-statement. Using the continue-statement in the do-while-statement causes the bug to skip the conditional judgment and go directly to the loop body for execution again.
               continue;
           }
           else{
               delete owners[i];
               i++;
           }
        }while( i < _length);
    }
    
}