pragma solidity 0.6.2;

//based on smartcheck

contract NoHoneyPot {

    bytes internal constant ID = hex"60203414600857005B60008080803031335AF100";

    constructor () public payable {
        bytes memory contract_identifier = ID;
        // assembly { return(add(0x20, contract_identifier), mload(contract_identifier)) }
    }
    
    function doAssembly() pure external returns(uint o_sum){
       assembly { 
           o_sum := add(0x20, 3) 
       }
    }

    function withdraw() public payable {
        require(msg.value >= 1 ether);
        msg.sender.transfer(address(this).balance);
    }
}