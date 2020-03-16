pragma solidity 0.6.2;

//based on slither

contract uninitStateLocalVar{
    address payable payee;
    uint256 public _order;
    event Record(address indexed _donors, uint256 _number, uint256 _money);
    
    constructor() public{
        _order = 0;
        payee = msg.sender;
    }
    //The local variable "number" is not initialized, so "number" always is 0.
    function giveMeMoney() external payable{
        uint256 number;
        _order += 1;
        require(msg.value > 0);
        emit Record(msg.sender, number, msg.value);
    }

    function withdrawDonation() external{
        payee.transfer(address(this).balance);
    }
}