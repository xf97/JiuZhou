pragma solidity 0.6.2;

interface tokenRecipient { 
    function receiveApproval(address _from, uint256 _value, address _token, bytes calldata _extraData) external; 
    
}

contract TokenERC20 {
    string public tokenName;
    string public tokenSymbol; 
    uint8 public tokenDecimals = 18; 
    uint256 public tokenTotalSupply; 

    mapping (address => uint256) public tokenBalanceOf;
    mapping (address => mapping (address => uint256)) public tokenAllowance;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Burn(address indexed from, uint256 value);

    constructor(uint256 initialSupply, string memory _tokenName, string memory _tokenSymbol) public {
        tokenTotalSupply = initialSupply * 10 ** uint256(tokenDecimals);  
        tokenBalanceOf[msg.sender] = tokenTotalSupply;               
        tokenName = _tokenName;                                  
        tokenSymbol = _tokenSymbol;                               
    }
    
    
    function name() external view returns (string memory) {
        return tokenName;
    }
    
    
    function symbol() public view returns (string memory){
        return tokenSymbol;
    }

    function decimals() public view returns (uint8){
        return tokenDecimals;
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
        emit Transfer(_from, _to, _value);

        assert(tokenBalanceOf[_from] + tokenBalanceOf[_to] == previousBalances);
    }

    function transfer(address _to, uint256 _value) public {
        _transfer(msg.sender, _to, _value);
    }


    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        if(_value <= tokenAllowance[_from][msg.sender])
            return false;
        //require(_value <= tokenAllowance[_from][msg.sender]);     // You can tell the caller by returning false
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

    
    function approveAndCall(address _spender, uint256 _value, bytes memory _extraData) public returns (bool success) {
        tokenRecipient spender = tokenRecipient(_spender);
        if (approve(_spender, _value)) {
            spender.receiveApproval(msg.sender, _value, address(this), _extraData);
            return true;
        }
        else
            return false;
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