pragma solidity 0.5.0;

//based on smartcheck



contract gray_GreaterOrEqualToZero {

    function finiteLoop_fixed2(uint256 border) public returns(uint256 ans) {
    	require(border >= 1);
        for (uint i = border - 1; i > 0 && i < border; i--) {
            ans += (i+1);
        }
    }
}