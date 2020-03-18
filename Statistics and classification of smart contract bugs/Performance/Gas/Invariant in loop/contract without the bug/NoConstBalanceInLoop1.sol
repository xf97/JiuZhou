pragma solidity 0.6.2;

contract NoWaste1{
	address public owner;
	uint256[] public grades;

	constructor(uint256 _length) public payable{
		owner = msg.sender;
		initGrades(_length);	
	}

	function pushGrade(uint256 _grade) public{
		require(msg.sender == owner);
		grades.push(_grade);
	}

	function addOne() public{
		for(uint256 i = 0; i < grades.length; i++){
			grades[i] += 1;
			grades.pop();	//length became shorter
		}
	}

	function initGrades(uint256 _length) internal{
		for(uint256 i = 0; i < _length; i++){
			grades.push(address(this).balance);
		}
	}
}
