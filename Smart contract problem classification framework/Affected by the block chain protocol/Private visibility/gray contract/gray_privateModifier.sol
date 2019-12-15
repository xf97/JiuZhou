//based on  smartcheck

//Although using private does not make passwords 
//invisible to the outside world, they can be stored 
//encrypted in advance.
pragma solidity 0.5.0;

contract gray_OpenWallet {

    struct Wallet {
        bytes32 password;
        uint balance;
    }
    mapping(uint => Wallet) private wallets;    

    function createAnAccount(uint256 _account, uint256 _password) external{
        wallets[_account].balance = 0;
        //Encrypted storage password, miners are not visible to the original password
        wallets[_account].password = keccak256(abi.encode(_password, 0));   
    }
    
    function replacePassword(uint _wallet, uint256 _previous, uint256 _new) external {
        require(keccak256(abi.encode(_previous, 0)) == wallets[_wallet].password);
        wallets[_wallet].password = keccak256(abi.encode(_new, 0));
    }

    function deposit(uint _wallet) public payable {
        wallets[_wallet].balance += msg.value;
    }

    function withdraw(uint _wallet, uint256 _password, uint _value) public {
        require(wallets[_wallet].password == keccak256(abi.encode(_password, 0)));
        require(wallets[_wallet].balance >= _value);
        msg.sender.transfer(_value);
    }
}