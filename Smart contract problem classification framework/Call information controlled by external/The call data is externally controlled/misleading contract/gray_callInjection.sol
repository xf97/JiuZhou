pragma solidity 0.5.0;

//based on knowsec404

/*
Another injection attack is through the call function, as shown in 
the following contract: an external user can call the secret funct-
ion as the contract by specifying parameters to the info function.
*/

contract gray_B {
    string private mySecret;
    bytes public data;
    
    constructor(string memory _mySecret, bytes memory _data) public{
        mySecret = _mySecret;
        data = _data;
    }
    
    function info() external{
        _info(data);
    }
    
    //The call parameters appear to be externally controlled, but they are not.
    function _info(bytes memory _data) internal{
        address(this).call(_data);
    }
    
    function secret() public view returns(string memory){
        require(address(this) == msg.sender);
        return mySecret;
    }
}