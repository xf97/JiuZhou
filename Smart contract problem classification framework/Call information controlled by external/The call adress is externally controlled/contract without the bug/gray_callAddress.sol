pragma solidity 0.5.0;

//based on knowsec404



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
        owner.call(data);
    }
    
    function secret() public returns(string memory){
        require(address(this) == msg.sender);
        return mySecret;
    }
}