pragma solidity 0.4.21;

//from smartcheck

contract BreakThisHash {
    bytes32 hash;
    uint birthday;
    function BreakThisHash(bytes32 _hash) public payable {
        hash = _hash;
        birthday = now;
    }
    
    function kill(bytes password) external {
        if (sha3(password) != hash) {   //use sha3
            throw;  //use throw
        }
        //use suicide
        suicide(msg.sender);
    }
    //use constant
    function hashAge() public constant returns(uint) {
        return(now - birthday);
    }
}