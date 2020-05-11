pragma solidity 0.6.2;

//based on swc

contract Missing{
    address private owner;

    modifier onlyowner {
        require(msg.sender==owner);
        _;
    }

    //In some cases, the lack of constructors can be dangerous. If the developer is not going to write a constructor for the contract, the harm of the lack of a constructor is limited to the structural incompleteness of the contract. If the developer intends to write a constructor for the contract, but misspells the function name due to the developer's own negligence, the contract is at great risk. Because in contracts, constructors are often tasked with assigning values to key state variables.
    function Constructor() public {
        owner = msg.sender;
    }

    fallback () external payable {} 

    function withdraw() external onlyowner{
       msg.sender.transfer(address(this).balance);
    }
}