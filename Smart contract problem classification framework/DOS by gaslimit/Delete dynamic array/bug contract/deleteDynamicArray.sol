pragma solidity 0.5.0;

//from smartcheck
/*
In solidity, deleting a huge map or array often consumes a lot of gas.
*/

contract C {
    uint[] amounts;
    address payable[] addresses;
    address payable owner;
    
    constructor() public{
        owner = msg.sender;
    }

    function collect(address payable to) external payable {
        amounts.push(msg.value);
        addresses.push(to);
    }

    /*
    If these two arrays contain too many elements, then deleting them is likely to be Dos with gaslimit.
    */
    function pay() external {
        uint length = amounts.length;

        for (uint i = 0; i < length; i++) {
            addresses[i].send(amounts[i]);
        }

        delete amounts;
        delete addresses;
    }
    
    function returnMoney() external{
        require(msg.sender == owner);
        require(amounts.length == 0 && addresses.length == 0);
        selfdestruct(owner);
    }
}