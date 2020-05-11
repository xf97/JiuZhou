pragma solidity 0.6.2;

//In order to facilitate the interaction of token contracts in Ethereum, some token contract standards have been established. These standards specify the state variables, functions and event information that should be included in the token contracts. Following these standards to develop token contracts enables your contract to interact with other contracts.

interface tokenRecipient { 
    function receiveApproval(address _from, uint256 _value, address _token, bytes calldata _extraData) external; 
    
}

contract unstandardTokenERC20 {
    string public tokenName;
    //string public tokenSymbol; //1. Lack of specified variables
    uint8 public tokenDecimals = 18; 
    uint256 public tokenTotalSupply; 

    mapping (address => uint256) public tokenBalanceOf;
    mapping (address => mapping (address => uint256)) public tokenAllowance;

    event Transfer(address indexed from, address indexed to, uint256 value);
    //2. The parameters of the event should be indexed
    event Burn(address from, uint256 value);

    constructor(uint256 initialSupply, string memory _tokenName, string memory _tokenSymbol) public {
        tokenTotalSupply = initialSupply * 10 ** uint256(tokenDecimals);  
        tokenBalanceOf[msg.sender] = tokenTotalSupply;               
        tokenName = _tokenName;                                  
        //tokenSymbol = _tokenSymbol;                               
    }
    
    /*
    3. Lack of prescribed methods
    function name() external view returns (string memory) {
        return tokenName;
    }
    */
    
    function symbol() public view returns (string memory){
        
    }

    /*
    4.The function does not return a value of the specified type as standard
    function decimals() public view returns (uint8)
    */
    function decimals() public view returns (uint256){
        return uint256(tokenDecimals);
    }
    
    function totalSupply() public view returns (uint256){
        return tokenTotalSupply;
    }
    
    
    function _transfer(address _from, address _to, uint _value) internal {
        require(_to != address(0x0));
        require(tokenBalanceOf[_from] >= _value);
        require(tokenBalanceOf[_to] + _value > tokenBalanceOf[_to]);

        uint previousBalances = tokenBalanceOf[_from] + tokenBalanceOf[_to];
        tokenBalanceOf[_from] -= _value;
        tokenBalanceOf[_to] += _value;
        //emit Transfer(_from, _to, _value);

        assert(tokenBalanceOf[_from] + tokenBalanceOf[_to] == previousBalances);
    }

    /*
    5.Events are not recorded in transfer, transferFrom, and approve functions
    */
    function transfer(address _to, uint256 _value) public {
        _transfer(msg.sender, _to, _value);
    }

    /*
    6.Raises an exception in a function that should return a Boolean value
    */
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_value <= tokenAllowance[_from][msg.sender]);     // You can tell the caller by returning false
        tokenAllowance[_from][msg.sender] -= _value;
        _transfer(_from, _to, _value);
        return true;
    }

    //Note that this function is susceptible to transaction order dependency problems.
    function approve(address _spender, uint256 _value) public returns (bool success) {
        require(tokenBalanceOf[msg.sender] >= _value);
        tokenAllowance[msg.sender][_spender] = _value;
        return true;
    }

    //7. A function that returns a Boolean value should not return only one result
    function approveAndCall(address _spender, uint256 _value, bytes memory _extraData) public returns (bool success) {
        tokenRecipient spender = tokenRecipient(_spender);
        if (approve(_spender, _value)) {
            spender.receiveApproval(msg.sender, _value, address(this), _extraData);
            return true;
        }
    }

    function burn(uint256 _value) public returns (bool success) {
        require(tokenBalanceOf[msg.sender] >= _value);   // Check if the sender has enough
        tokenBalanceOf[msg.sender] -= _value;            // Subtract from the sender
        tokenTotalSupply -= _value;                      // Updates totalSupply
        emit Burn(msg.sender, _value);
        return true;
    }

    function burnFrom(address _from, uint256 _value) public returns (bool success) {
        require(tokenBalanceOf[_from] >= _value);                // Check if the targeted balance is enough
        require(_value <= tokenAllowance[_from][msg.sender]);    // Check tokenAllowance
        tokenBalanceOf[_from] -= _value;                         // Subtract from the targeted balance
        tokenAllowance[_from][msg.sender] -= _value;             // Subtract from the sender's tokenAllowance
        tokenTotalSupply -= _value;                              // Update totalSupply
        emit Burn(_from, _value);
        return true;
    }
    
    function balanceOf(address _owner) public view returns (uint256 balance){
        return tokenBalanceOf[_owner];
    }

    function allowance(address _owner, address _spender) public view returns (uint256 remaining){
        return tokenAllowance[_owner][_spender];
    }
}