pragma solidity 0.6.2;

//based on swc

/*
The global variables that are most easily controlled by the miner are timestamp(now) and block.number. Try to avoid the influence of these two variables on the execution result of the contract.
*/

contract TimedCrowdsale {
    address[] public fundraising;
    uint256[] public money;
    address private owner;
    
    constructor() public{
        owner = msg.sender;
    }
    
    modifier onlyOwner{
        require(owner == msg.sender);
        _;
    }
    
    function run() external payable{
        if(isSaleFinished()  == false){
            require(msg.value > 0);
            fundraising.push(msg.sender);
            money.push(msg.value);
        }
    } 
    
    function getMoney() public onlyOwner{
        msg.sender.transfer(address(this).balance);
    }

    //raise money should finish exactly at January 1, 2019
    function isSaleFinished() private view returns (bool) {
        return block.timestamp >= 1546300800;
    }
}