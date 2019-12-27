pragma solidity 0.5.0;

contract unusedResult{
    bytes32 public myAnswer;
    address public solver;
    event GetAnswer(address indexed _sender);
    
    constructor(bytes32 _answer) public{
        myAnswer = _answer;
        solver = msg.sender;
    }
    
    function getAnswer() external returns(bytes32){
        _getAnswer();   //unused
        emit GetAnswer(msg.sender);
        return myAnswer;
    }

    function _getAnswer() internal view returns(bytes32){
        return myAnswer;
    }
}