pragma solidity 0.4.26;

//based on swc

// CryptoRoulette
//
// Guess the number secretly stored in the blockchain and win the whole contract balance!
// A new number is randomly chosen after each try.
//
// To play, call the play() method with the guessed number (1-20).  Bet price: 0.1 ether


/*warning!
The miner can obtain the value of secretNumber. Please do not use this 
contract or the repair contract of this contract to deploy to Ethereum, 
otherwise the miner will gain an unfair competitive advantage.
*/

contract CryptoRoulette {

    uint256 private secretNumber; //miner can see its value
    uint256 public lastPlayed;
    uint256 public betPrice = 0.1 ether;
    address public ownerAddr;

    struct Game {
        address player;
        uint256 number;
    }
    Game[] public gamesPlayed;

    function CryptoRoulette() public {
        ownerAddr = msg.sender;
        shuffle();
    }

    function shuffle() internal {
        // randomly set secretNumber with a value between 1 and 20
        secretNumber = uint8(sha3(now, block.blockhash(block.number-1))) % 20 + 1;
    }

    function play(uint256 number) payable public {
        require(msg.value >= betPrice && number <= 10);
        
        //Uninitialized storage variables are the most dangerous of all uninitialized bugs because uninitialized storage variables act as references to the first state variable. In some cases, this can cause critical state state variables to be overridden. All storage variables should be initialized to prevent the contract from getting into danger. According to our use, the bug was fixed after Solidity 0.5.0 version.
        Game storage game;  //this is a uninitialized storage variable
        game.player = msg.sender;
        game.number = number;
        gamesPlayed.push(game);

        if (number == secretNumber) {
            // win!
            msg.sender.transfer(this.balance);
        }

        shuffle();
        lastPlayed = now;
    }

    function kill() public {
        if (msg.sender == ownerAddr && now > lastPlayed + 1 days) {
            suicide(msg.sender);
        }
    }

    function() public payable { }
}
