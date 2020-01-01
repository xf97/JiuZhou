pragma solidity 0.5.0;

//based on smartcheck


contract NoGreaterOrEqualToZero {

    function finiteLoop_fixed1(uint border) pure external returns(uint ans) {
        for (uint i = 0; i <= border; i++) {
            ans += i;
        }
    }
}