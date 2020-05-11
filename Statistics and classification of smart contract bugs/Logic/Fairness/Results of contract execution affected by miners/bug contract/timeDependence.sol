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
        //Miners can control attributes such as mining time, and then control the attributes of blocks in smart contracts. For example, if the features of a contract depend on block.timestamp, miners can gain a competitive advantage by controlling the time of mining. At present, the most affected by this bug is block.timestamp (now). Try to avoid using block attributes controlled by miners. If you have to, you can use block attributes that make miners pay a huge price.
        return block.timestamp >= 1546300800;
    }
}