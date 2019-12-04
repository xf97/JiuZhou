pragma solidity 0.5.0;

//based on smartcheck

/*
 The following example includes an infinite loop:
 //
 In this case, i >= 0 condition will always evaluate to true.  The next value of i
 variable after 0 will be 2**256-1. Thus, the loop will be infinite.
*/

contract gray_GreaterOrEqualToZero {

    function finiteLoop_fixed1(uint border) public returns(uint ans) {
        for (uint i = 0; i <= border; i++) {
            ans += i;
        }
    }
}