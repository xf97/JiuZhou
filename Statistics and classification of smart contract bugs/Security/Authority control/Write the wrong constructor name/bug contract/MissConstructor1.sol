pragma solidity 0.6.2;

//based on swc

contract Missing{
    address private owner;

    modifier onlyowner {
        require(msg.sender==owner);
        _;
    }

    function Constructor() public {
        owner = msg.sender;
    }

    fallback () external payable {} 

    function withdraw() external onlyowner{
       msg.sender.transfer(address(this).balance);
    }
}