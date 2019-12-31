pragma solidity 0.5.0;

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
        require(msg.value == 0.1 ether);
        uint c = 0; //unused
        bytes32 yourGrade = keccak256(abi.encode(_yourNumber, 0));
        if(yourGrade > myGrade)
            //you win!
            msg.sender.transfer(address(this).balance);
    }
}