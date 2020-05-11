// This code contains a vulnerability - do not use it!
//based on smartcheck
pragma solidity 0.6.2;

//Because Ethereum is based on the blockchain, miners have a full backup of the network data. For miners, all contract codes and variables are visible, even if external visibility is specified using private. Don't use smart contracts to store passwords or valuable puzzle answers.

contract OpenWallet {

    struct Wallet {
        bytes32 password;
        uint balance;
    }
    mapping(uint => Wallet) private wallets;    //For miners, the password is visible

    function createAnAccount(uint256 _account, bytes32 _password) public{
        wallets[_account].balance = 0;
        wallets[_account].password = _password;
    }
    
    function replacePassword(uint _wallet, bytes32 _previous, bytes32 _new) public {
        require(_previous == wallets[_wallet].password);
        wallets[_wallet].password = _new;
    }

    function deposit(uint _wallet) public payable {
        wallets[_wallet].balance += msg.value;
    }

    function withdraw(uint _wallet, bytes32 _password, uint _value) public {
        require(wallets[_wallet].password == _password);
        require(wallets[_wallet].balance >= _value);
        msg.sender.transfer(_value);
    }
}