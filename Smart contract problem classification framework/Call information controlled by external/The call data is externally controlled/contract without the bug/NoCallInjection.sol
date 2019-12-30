pragma solidity 0.5.0;

//based on knowsec404


//One solution is to manually specify the call data

contract gray_B {
    string private mySecret;
    bytes public data;
    address public owner;
    
    constructor(string memory _mySecret) public{
        mySecret = _mySecret;
        owner = msg.sender;
    }
    
    function setData(bytes calldata _data) external{
        require(msg.sender == owner);
        data = _data;
    }
    
    function info() external{
        address(this).call(data);
        //this.call(bytes4(keccak256("secret()"))); 
        //Use the code above to call the secret function
        //now, you can know my secret
    }
    
    function secret() public returns(string memory){
        require(address(this) == msg.sender);
        return mySecret;
    }
}