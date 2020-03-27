pragma solidity 0.6.2;

//base swc

contract GuessTheRandomNumberChallenge {
    bytes32 answer;

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