pragma solidity 0.6.2;

//based https://swcregistry.io/docs/SWC-123#requirement-simplesol

//line 15

contract GasModel{
    uint x = 100;
    function check() external{
        uint a = gasleft();
        x = x + 1;
        uint b = gasleft();
        // Solidity  language provides several statements ( require ,  assert , and  revert ) to handle errors. These statements are slightly different when used, so they need to be used correctly. For example,  require  should be used for input validation,  assert  should be used to validate invariants, and  revert  is used for termination and rollback transactions. In addition, the  require  does not consume any  gas , but  assert  consumes all available  gas .
        //always false
        assert(b > a);
    }
}
