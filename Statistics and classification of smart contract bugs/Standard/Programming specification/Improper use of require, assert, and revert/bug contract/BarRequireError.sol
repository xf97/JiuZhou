pragma solidity 0.6.2;

//based https://swcregistry.io/docs/SWC-123#requirement-simplesol

// Solidity  language provides several statements ( require ,  assert , and  revert ) to handle errors. These statements are slightly different when used, so they need to be used correctly. For example,  require  should be used for input validation,  assert  should be used to validate invariants, and  revert  is used for termination and rollback transactions. In addition, the  require  does not consume any  gas , but  assert  consumes all available  gas.

//line 10, 18

//now, x is a invariant
contract Foo {
    function baz(int256 x) public pure returns (int256) {
        require(0 < x);
        return 42;
    }
}


contract Bar is Foo {
    function doubleBaz() public pure returns (int256) {
        return 2*baz(0);
    }
}