pragma solidity 0.5.0;

//based on smartcheck

/*
 The following example includes an infinite loop:
 //
 In this case, i >= 0 condition will always evaluate to true.  The next value of i
 variable after 0 will be 2**256-1. Thus, the loop will be infinite.
*/

contract gray_GreaterOrEqualToZero {

    function finiteLoop_fixed2(uint256 border) public returns(uint256 ans) {
    	require(border + 1 > border);
        for (uint i = border + 1; i > 0 ; i--) {
            ans += (i-1);
        }
    }
}