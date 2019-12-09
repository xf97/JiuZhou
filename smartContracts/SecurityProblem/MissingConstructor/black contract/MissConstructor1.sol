pragma solidity 0.5.0;

//based on swc

contract Missing{
    address private owner;

    modifier onlyowner {
        require(msg.sender==owner);
        _;
    }

    function Constructor()
        public 
    {
        owner = msg.sender;
    }

    function () external payable {} 

    function withdraw() external onlyowner{
       msg.sender.transfer(address(this).balance);
    }

}