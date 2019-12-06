pragma solidity 0.4.24;

//based on knowsec404

/*
Another injection attack is through the call function, as shown in 
the following contract: an external user can call the secret funct-
ion as the contract by specifying parameters to the info function.
*/

contract B {
    string private mySecret;
    
    constructor(string _mySecret) public{
        mySecret = _mySecret;
    }
    
    function info(bytes data) external{
        address(this).call(data);
        //this.call(bytes4(keccak256("secret()"))); 
        //Use the code above to call the secret function
        //now, you can know my secret
    }
    
    function secret() public returns(string){
        require(this == msg.sender);
        return mySecret;
    }
}