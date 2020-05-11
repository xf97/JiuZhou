pragma solidity 0.6.2;

//based smartcheck
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
            addresses[i].transfer(amounts[i]);
        }

        //When the size of a dynamic array is large, deleting the array results in a large consumption of gas. In extreme cases, this causes the transaction to be refused packaging by the blocks. In general, if you can do without deleting an array, keep it. If you must delete the arrays, try deleting them one by one.
        delete amounts;
        delete addresses;
    }
    
    function returnMoney() external{
        require(msg.sender == owner);
        require(amounts.length == 0 && addresses.length == 0);
        selfdestruct(owner);
    }
}