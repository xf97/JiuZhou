pragma solidity 0.6.2;

contract waste1{
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

	//The array length is calculated for each loop, but the array length remains the same
	function addOne() public{
		//Extracting invariants from loops is a widely used method to optimize performance. In Ethereum, this action can also reduce the loss of gas. 
		for(uint256 i = 0; i < grades.length; i++){
			grades[i] += 1;
		}
	}

	function initGrades(uint256 _length) internal{
		for(uint256 i = 0; i < _length; i++){
			grades.push(address(this).balance);
		}
	}
}
