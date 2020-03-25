pragma solidity 0.6.2;

//based https://swcregistry.io/docs/SWC-123#requirement-simplesol


//now, x is a invariant
contract Foo {
    function baz(int256 x) public pure returns (int256) {
        require(0 < x);
        return 42;
    }
}


contract RightBar is Foo {
    function doubleBaz(int256 x) public pure returns (int256) {
        return 2 * baz(x);
    }
}