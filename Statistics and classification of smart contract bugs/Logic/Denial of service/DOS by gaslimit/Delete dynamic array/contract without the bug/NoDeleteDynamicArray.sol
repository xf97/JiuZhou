pragma solidity 0.6.2;

//based smartcheck
/*
In solidity, deleting a huge map or array often consumes a lot of gas.
*/

contract C {
    uint[] public amounts;
    address payable[] addresses;
    address payable owner;
    bool[] public flags;
    
    constructor() public{
        owner = msg.sender;
    }

    function collect(address payable to) external payable {
        amounts.push(msg.value);
        addresses.push(to);
    }

    function pay() external {
        uint length = amounts.length;

        for (uint i = 0; i < length; i++) {
            bool flag = addresses[i].send(amounts[i]);
            if(flag)
                flags.push(addresses[i].send(amounts[i]));
        }
    }
    
    //If the payment has been executed, the length of the flags is equal 
    //to the length of the other two arrays
    function returnMoney() external{
        require(msg.sender == owner);
        require(amounts.length == flags.length && addresses.length == flags.length);
        selfdestruct(owner);
    }
}