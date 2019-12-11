pragma solidity 0.5.0;

//based on slither

contract uninitStateLocalVar{
    address payable payee;
    uint256 public _order;
    event Record(address indexed _donors, uint256 _number, uint256 _money);
    
    constructor() public{
        _order = 0;
    }
    //The local variable "number" is not initialized, so "number" does not work.
    function giveMeMoney() external payable{
        uint256 number;
        _order += 1;
        require(msg.value > 0);
        emit Record(msg.sender, number, msg.value);
    }
    //There is no initialized state variable ''payee''', so all 
    //donations can only be sent to the 0x0 destruction address.
    function withdrawDonation() external{
        payee.transfer(address(this).balance);
    }
}