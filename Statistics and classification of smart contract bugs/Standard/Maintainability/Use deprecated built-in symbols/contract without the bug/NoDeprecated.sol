pragma solidity 0.6.2;

//new things

contract Old{
    address payable owner;
   bytes32 bytesnum;
   bytes32 hashnum;

    
    //function that has same name with contract's
    //is deprecated
    constructor(uint256 num) public{
        owner = msg.sender;
        //sha3 is deprecated
       bytesnum =keccak256(abi.encode(num));
        //var is deprecated 
        uint8 a = 0;
        //block.blockhash is deprecated
        hashnum = blockhash(num);
    }
    
    //constant is deprecated
    function getOwner() view public returns(address){
        return owner;
    }
    
    function callAnother() public{
        bool flag;
        bytes memory data;
        (flag, data) = owner.call("");
        //callcode and throw are deprecated
        if(flag){
            revert();
        }
        else{
            //suicide is deprecated
            require(msg.sender == owner);
            selfdestruct(owner);
        }
    }
    
    fallback () external{
        //msg.gas is deprecated
        uint remainGas = gasleft();
        if(remainGas > 2300){
            revert();
        }
    }
}