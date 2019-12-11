pragma solidity 0.5.0;

contract fixed_unusedResult1{
    bytes32 public myAnswer;
    address public solver;
    event GetAnswer(address indexed _sender);
    
    constructor(bytes32 _answer) public{
        myAnswer = _answer;
        solver = msg.sender;
    }
    
    function getAnswer() external returns(bytes32){
        emit GetAnswer(msg.sender);
        return _getAnswer();
    }
    //Using return values
    function _getAnswer() internal returns(bytes32){
        return myAnswer;
    }
}