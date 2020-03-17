pragma solidity 0.6.2;

contract xfBank{
    mapping(address => uint256) public ledger;
    address[] public user;
    address public bankOwner;
    
    constructor() public{
        bankOwner = msg.sender;
    }
    
    function deposit() external payable{
        require(msg.value > 0);
        ledger[msg.sender] += msg.value;
        user.push(msg.sender);
    }
    
    function withdraw(uint256 _money) external{
        require(ledger[msg.sender] >= _money);
        msg.sender.transfer(_money);
    }
    
    //The transfer exception in the refund function should be handled, otherwise 
    //it will be impossible to know which user's refund was unsuccessful.
    function refundAll() external{
        require(msg.sender == bankOwner);
        uint256 _length = user.length;
        for(uint256 i = 0 ; i < _length; i++){
            uint256 money = ledger[user[i]];
            ledger[user[i]] = 0;
            user[i].call.value(money)("");
        }
    }
}