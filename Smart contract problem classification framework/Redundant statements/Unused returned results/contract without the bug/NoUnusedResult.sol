pragma solidity 0.5.0;

contract fixed_unusedResult{
    bytes32 public myAnswer;
    address public solver;
    event GetAnswer(address indexed _sender);
    
    constructor(bytes32 _answer) public{
        myAnswer = _answer;
        solver = msg.sender;
    }
    
    function getAnswer() external returns(bytes32){
       // _getAnswer();
        emit GetAnswer(msg.sender);
        return myAnswer;
    }
    
    /*Remove redundant functions
    //unused
    function _getAnswer() internal returns(bytes32){
        return myAnswer;
    }
    */
}