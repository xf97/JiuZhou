pragma solidity 0.5.0;

/*
from swc:
Unused variables are allowed in Solidity and they do not pose a direct security issue. It is best practice though to avoid them as they can:

cause an increase in computations (and unnecessary gas consumption)
indicate bugs or malformed data structures and they are generally a sign of poor code quality
cause code noise and decrease readability of the code
*/

/*
If your number is bigger than mine, then you can take all the money
*/

contract unusedVariable{
    uint256 public constant betPrice = 0.1 ether;   //unused 
    address public owner;
    bytes32 private myGrade;
    
    constructor(uint256 _myNumber) public payable{
        require(msg.value == 1 ether);
        owner = msg.sender;
        myGrade = keccak256(abi.encode(_myNumber, 0));
    }
    
    function play(uint256 _yourNumber) external payable{
        require(msg.value == 1 ether);
        bytes32 yourGrade = keccak256(abi.encode(_yourNumber, 0));
        if(yourGrade > myGrade)
            //you win!
            msg.sender.transfer(address(this).balance);
    }
}