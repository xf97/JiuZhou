pragma solidity 0.6.2;

//based on swc

/**
 * @title MultiOwnable
 */
contract gray_MultiOwnable {
  address public root;
  mapping (address => address) public owners; // owner => parent of owner
  
  /**
  * @dev The Ownable constructor sets the original `owner` of the contract to the sender
  * account.
  */
  constructor() public {
    root = msg.sender;
    owners[root] = root;
  }
  
  /**
  * @dev Throws if called by any account other than the owner.
  */
  modifier onlyOwner() {
    require(owners[msg.sender] != address(0));
    _;
  }
  
  function newOwner(address _owner) onlyOwner external returns (bool) {
    require(_owner != address(0));
    owners[_owner] = msg.sender;
    return true;
  }
  
  /**
    * @dev Deleting owners
    */
  function deleteOwner(address _owner) onlyOwner external returns (bool) {
    require(owners[_owner] == msg.sender || (owners[_owner] != address(0) && msg.sender == root));
    owners[_owner] = address(0);
    return true;
  }
}

contract gray_TestContract is gray_MultiOwnable {
  
  function withdrawAll() external onlyOwner {
    msg.sender.transfer(address(this).balance);
  }

  fallback() external payable {
  }

}