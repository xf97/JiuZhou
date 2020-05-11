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
    //Smart contracts are allowed to self-destruct in Ethereum, and deposits from the self-destruct contracts will be sent to a designated address (you can force the ethers to be sent to an address by the contract self-destruct). There must be strict permission control over the self-destruct operation, otherwise the contract can be easily killed by an attacker.
    function suicideSelf(address payable _Beneficiary) external{
        selfdestruct(_Beneficiary);
    }
}