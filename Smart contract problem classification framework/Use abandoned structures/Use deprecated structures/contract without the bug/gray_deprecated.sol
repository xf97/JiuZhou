pragma solidity 0.4.24;

//old things

contract Old{
    address owner;
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
        //callcode and throw are deprecated
        if(owner.delegatecall("")){
            revert();
        }
        else{
            //suicide is deprecated
            selfdestruct(owner);
        }
    }
    
    function () external{
        //msg.gas is deprecated
        uint remainGas = gasleft();
        if(remainGas > 2300){
            revert();
        }
    }
}