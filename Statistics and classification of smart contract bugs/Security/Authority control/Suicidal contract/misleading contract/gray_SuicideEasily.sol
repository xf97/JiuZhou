pragma solidity 0.6.2;

contract gray_SuicideEasily{
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
        suicideSelf(msg.sender);
    }
    
    function suicideSelf(address payable _Beneficiary) internal{
        selfdestruct(_Beneficiary);
    }
}