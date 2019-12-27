pragma solidity 0.5.0;

//based on smartcheck


contract gray_GreaterOrEqualToZero {

    function finiteLoop_fixed1(uint border) public returns(uint ans) {
        for (uint i = 0; i <= border; i++) {
            ans += i;
        }
    }
}