pragma solidity 0.5.8;

//based on  smartcheck
/*
In solidity, deleting a huge map or array often consumes a lot of gas.
*/

contract gray_C {
    uint[] amounts;
    address payable[] addresses;
    uint256 public index;

    constructor() public{
        index = 0;
    }

    function collect(address payable to) external payable {
        amounts.push(msg.value);
        addresses.push(to);
    }

    /*
    If these two arrays contain too many elements, then deleting them is likely to be Dos with gaslimit.
    */
    //One possible solution is to break the deletion step into several steps.
    function paySomeone(uint256 _length) external {
        uint256 boundary = index + _length;
        if(boundary > addresses.length)
            boundary = addresses.length;
        for (uint i = index; i < boundary; i++) {
            addresses[i].transfer(amounts[i]);
            delete addresses[i];
            delete amounts[i];
        }
        if(boundary == addresses.length)
            index = 0;  //reset index
        else
            index += _length;   //update index
    }
}