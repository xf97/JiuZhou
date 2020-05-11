pragma solidity 0.6.2;

//based on slither

contract uninitStateVar{
    //The contract declares state variables, but does not initialize them, and the state variables are assigned default values. In some cases, this may cause the behavior of the contract to differ from the developer's expectations. The initial value of the state variable should be specified clearly, which can reduce the probability of error and make the code better understood.
    address payable payee;  //uninitialized
    uint256 public _order;  
    event Record(address indexed _donors, uint256 _number, uint256 _money);
    
    constructor() public{
        _order = 0;
    }

    function giveMeMoney() external payable{
        uint256 number = _order;
        _order += 1;
        require(msg.value > 0);
        emit Record(msg.sender, number, msg.value);
    }
    
    //There is no initialized state variable ''payee'', so all 
    //donations can only be sent to the 0x0 destruction address.
    function withdrawDonation() external{
        payee.transfer(address(this).balance);
    }
}