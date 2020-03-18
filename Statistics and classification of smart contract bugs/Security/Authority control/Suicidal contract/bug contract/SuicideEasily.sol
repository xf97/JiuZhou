pragma solidity 0.6.2;

contract SuicideEasily{
    address public owner;
    
    constructor() public payable{
        owner = msg.sender;
        require(msg.value > 0);
    }
    
    modifier OnlyOwner{
        require(msg.sender == owner);
        _;
    }
    
    function withdraw() external OnlyOwner{
        msg.sender.transfer(address(this).balance);
    }
    
    //The selfdestruct operation has no access control, so anyone
    //can kill the contract and transfer the contract deposit to 
    //their own account.
    function suicideSelf(address payable _Beneficiary) external{
        selfdestruct(_Beneficiary);
    }
}