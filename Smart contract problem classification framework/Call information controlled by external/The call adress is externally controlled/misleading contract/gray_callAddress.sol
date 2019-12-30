pragma solidity 0.5.0;

contract gray_B {
    string private mySecret;
    bytes data;
    address[] public callers;
    address public owner;
    
    constructor(string memory _mySecret, bytes memory _data) public{
        owner = msg.sender;
        mySecret = _mySecret;
        data= _data;
    }

    modifier whiteList(address caller){
        bool flag = false;
        uint256 _length = callers.length;
        for(uint256 i = 0; i < _length; i++){
            if(callers[i] == caller){
                flag = true;
                break;
            }
        }    
        require(flag);
        _;
    }
    
    function addList(address newOne) external{
        require(msg.sender == owner);
        callers.push(newOne);
    }
    
    function info(address callee) external whiteList(callee){
        callee.call(data);
    }
    
    function secret() public view returns(string memory){
        require(address(this) == msg.sender);
        return mySecret;
    }
}