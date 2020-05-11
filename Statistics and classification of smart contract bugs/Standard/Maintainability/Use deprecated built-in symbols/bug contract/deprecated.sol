pragma solidity 0.4.26;

//Aftet Solidity 0.5.0 version, Solidity does not allow several structures to be used. Even if you don't use a compiler after Solidity 0.5.0 version, you can improve the readability of your code by not using deprecated structures.

//old things

contract Old{
    address owner;
   bytes32 bytesnum;
   bytes32 hashnum;

    
    //function that has same name with contract's
    //is deprecated
    function Old(uint256 num){
        owner = msg.sender;
        //sha3 is deprecated
       bytesnum =sha3(num);
        //var is deprecated 
        var a = 0;
        //block.blockhash is deprecated
        hashnum = block.blockhash(num);
    }
    
    //constant is deprecated
    function getOwner() constant returns(address){
        return owner;
    }
    
    function callAnother(){
        //callcode and throw are deprecated
        if(owner.callcode("")){
            throw;
        }
        else{
            //suicide is deprecated
            require(msg.sender == owner);
            suicide(owner);
        }
    }
    
    function () external{
        //msg.gas is deprecated
        if(msg.gas > 2300){
            throw;
        }
    }
}