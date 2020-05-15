pragma solidity 0.6.2;

//based https://swcregistry.io/docs/SWC-130#guess-the-numbersol

//line 32

contract GuessTheNumber
{
    uint _secretNumber;
    address payable _owner;
    event success(string);
    event wrongNumber(string);
    
    constructor(uint secretNumber) payable public
    {
        require(secretNumber <= 10);
        _secretNumber = secretNumber;
        _owner = msg.sender;    
    }
    
    function getValue() view public returns (uint)
    {
        return address(this).balance;
    }

    function guess(uint n) payable public
    {
        require(msg.value == 1 ether);
        
        uint p = address(this).balance;
        //When printing U+202E characters, the character string will be inverted. In some cases, this can cause the true intention of the contract to be hidden.
        checkAndTransferPrize(/*The prize‮/*rebmun desseug*/n , p/*‭
                /*The user who should benefit */,msg.sender);
    }
    
    function checkAndTransferPrize(uint p, uint n, address payable guesser) internal returns(bool)
    {
        if(n == _secretNumber)
        {
            guesser.transfer(p);
            emit success("You guessed the correct number!");
        }
        else
        {
            emit wrongNumber("You've made an incorrect guess!");
        }
    }
    
    function kill() public
    {
        require(msg.sender == _owner);
        selfdestruct(_owner);
    }
}