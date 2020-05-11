pragma solidity 0.6.2;

//base swc

contract GuessTheRandomNumberChallenge {
    bytes32 answer;

    //Miners can control attributes such as mining time, and then control the attributes of blocks in smart contracts. For example, if the features of a contract depend on block.timestamp, miners can gain a competitive advantage by controlling the time of mining. At present, the most affected by this bug is block.timestamp (now). Try to avoid using block attributes controlled by miners. If you have to, you can use block attributes that make miners pay a huge price.
    constructor() public payable {
        require(msg.value == 1 ether);
        answer = keccak256(abi.encode(blockhash(block.number - 1), now));
    }

    function isComplete() public view returns (bool) {
        return address(this).balance == 0;
    }

    function guess(bytes32 n) public payable {
        require(msg.value == 1 ether);

        if (n == answer) {
            msg.sender.transfer(2 ether);
        }
    }
}