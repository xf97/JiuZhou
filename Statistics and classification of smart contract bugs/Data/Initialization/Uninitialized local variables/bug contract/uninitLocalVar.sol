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
    //If the local variable is declared but not initialized, the local variable will be set to the default value. In some cases, the functionality of the contract may not match the developer's expectations due to uninitialized variables. In particular, uninitialized address types are particularly dangerous. The initial value of the local variable should be specified clearly, which can reduce the probability of error and make the code better understood.
        uint256 number;
        _order += 1;
        require(msg.value > 0);
        emit Record(msg.sender, number, msg.value);
    }

    function withdrawDonation() external{
        payee.transfer(address(this).balance);
    }
}