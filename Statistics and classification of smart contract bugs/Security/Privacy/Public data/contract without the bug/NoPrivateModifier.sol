pragma solidity 0.6.2;

//Instead of saving the password, use the address for authentication

contract NoOpenWallet {
    
    /*
    struct Wallet {
        address user;
        uint balance;
    }*/
    mapping(address => uint256) public wallets;    

    function createAnAccount() public{
        wallets[msg.sender] = 0;
        //wallets[msg.sender].user = msg.sender;
    }
    
    /*
    function replacePassword(uint _wallet, bytes32 _previous, bytes32 _new) public {
        require(_previous == wallets[_wallet].password);
        wallets[_wallet].password = _new;
    }*/

    function deposit() public payable {
        require(wallets[msg.sender] + msg.value > wallets[msg.sender]);
        wallets[msg.sender] += msg.value;
    }

    function withdraw(uint _value) public {
        require(wallets[msg.sender] >= _value);
        msg.sender.transfer(_value);
    }
}