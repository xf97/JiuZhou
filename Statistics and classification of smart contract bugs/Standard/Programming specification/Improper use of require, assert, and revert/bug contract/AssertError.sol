pragma solidity 0.6.2;

//based https://swcregistry.io/docs/SWC-123#requirement-simplesol

//line 14

contract GasModel{
    uint x = 100;
    function check() external{
        uint a = gasleft();
        x = x + 1;
        uint b = gasleft();
        //always false
        assert(b > a);
    }
}
