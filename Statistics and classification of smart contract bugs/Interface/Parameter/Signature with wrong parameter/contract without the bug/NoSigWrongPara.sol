pragma solidity 0.6.2;

//from Jiuzhou

contract NoSigWrongPara{
    bytes32 private idHash;
    
    constructor() public payable{
        require(msg.value > 0);
        idHash = keccak256(abi.encode(msg.sender));
    }

    function getMyMoney(address payable _id, bytes32 _hash, uint8 v, bytes32 r, bytes32 s) external returns(bool){
        if (_id == address(0x0))
            return false;
        if(_id != ecrecover(_hash, v, r, s))
            return false;
        _id.transfer(address(this).balance);
        return true;
    }
    
}