pragma solidity 0.6.2;


/* User can add pay in and withdraw Ether.
   The constructor is wrongly named, so anyone can become 'creator' and withdraw all funds.
*/

contract gray_Wallet {
    address creator;
    
    mapping(address => uint256) balances;

    function Constructor() public {
        creator = msg.sender;
    }

    function deposit() external payable {
        assert(balances[msg.sender] + msg.value > balances[msg.sender]);
        balances[msg.sender] += msg.value;
    }
    
    function withdraw(uint256 amount) external {
        require(amount <= balances[msg.sender]);
        msg.sender.transfer(amount);
        balances[msg.sender] -= amount;
    }

    // In an emergency the owner can migrate  allfunds to a different address.
    function migrateTo(address payable to) external {
        require(creator == msg.sender);
        to.transfer(address(this).balance);
    }

}
