pragma solidity 0.6.4;

//from https://swcregistry.io/docs/SWC-123#requirement-simplesol

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
        return 2 * baz(0);
    }
}