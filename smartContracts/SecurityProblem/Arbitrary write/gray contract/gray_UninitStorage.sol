pragma solidity 0.4.24;

//based on  swc

contract CryptoRoulette {
    bytes32 private secretBytes;

    uint256 public betPrice = 0.1 ether;
    address public ownerAddr;

    struct Game {
        address player;
        uint256 number;
    }
    Game[] public gamesPlayed;

    constructor(uint256 secretNumber) public {
        ownerAddr = msg.sender;
        shuffle(secretNumber);
    }

    function shuffle(uint256 secretNumber) internal {
        require(secretNumber >= 1 && secretNumber <= 20);
        secretBytes = keccak256(abi.encode(secretNumber, 0));
    }

    function play(uint256 number) payable public {
        require(msg.value >= betPrice && number <= 10);

        Game memory game;
        game.player = msg.sender;
        game.number = number;
        gamesPlayed.push(game);

        if (keccak256(abi.encode(number,0)) == secretBytes) {
            // win!
            msg.sender.transfer(address(this).balance);
        }
    }

    function kill() public {
        if (msg.sender == ownerAddr) {
            selfdestruct(msg.sender);
        }
    }

    function() external payable { }
}