pragma solidity 0.5.0;

contract B {
    string private mySecret;
    bytes data;
    
    constructor(string memory _mySecret, bytes memory _data) public{
        mySecret = _mySecret;
        data= _data;
    }
    
    function info(address callee) external{
        callee.call(data);
    }
    
    function secret() public view returns(string memory){
        require(address(this) == msg.sender);
        return mySecret;
    }
}