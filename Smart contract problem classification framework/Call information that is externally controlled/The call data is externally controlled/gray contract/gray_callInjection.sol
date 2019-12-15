pragma solidity 0.4.24;

//based on knowsec404

/*
Another injection attack is through the call function, as shown in 
the following contract: an external user can call the secret funct-
ion as the contract by specifying parameters to the info function.
*/

//One solution is to manually specify the call data

contract gray_B {
    string private mySecret;
    bytes public data;
    address public owner;
    
    constructor(string _mySecret) public{
        mySecret = _mySecret;
        owner = msg.sender;
    }
    
    function setData(bytes _data) external{
        require(msg.sender == owner);
        data = _data;
    }
    
    function info() external{
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