pragma solidity 0.4.26;

contract gray_doWhileContinue{
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
           }
           else{
               delete owners[i];
               break;
               continue;    //continue is inaccessible
           }
        }while( i < _length);
    }
    
}