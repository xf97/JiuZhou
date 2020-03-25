pragma solidity 0.6.2;

//based https://swcregistry.io/docs/SWC-130#guess-the-numbersol


contract NoGuessTheNumber
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
        checkAndTransferPrize(p, n, msg.sender);
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