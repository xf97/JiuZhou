pragma solidity 0.6.2;

//I will send 1 ether to each of my business partners.

contract myBonus{
    address public owner;
    address payable[] public myPartners;
    
    constructor() public{
        owner = msg.sender;
    }
    
    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }
    
    function depositOnce() external payable onlyOwner{
        require(msg.value == 1 ether);
    }
    
    function addNewPartner(address payable _friend) external onlyOwner{
        myPartners.push(_friend);
    }
    
    //Warning: I did not shorten the array after deleting the element, 
    //nor did I manually shift these elements.
    //So my money was sent to address 0x0, which means it was destroyed.
    function deletePartner(address _badGuy) external onlyOwner{
        uint256 _length = myPartners.length;
        for(uint256 i = 0; i < _length; i++){
            if(myPartners[i] == _badGuy)
                //In Solidity, deleting dynamic array elements does not automatically shorten the length of the array and move the array elements. You need to manually shorten the array length and manually shift the elements. Otherwise, gaps are left in the array (the deleted element is simply set as the default).
                delete myPartners[i];
        }
    }
    
    /*
    Warning: this function may be Dos, do not use this function to transfer 
    money.
    Error: when deleting an element, the element is set to the default value 
    (0x0), sending ethers to this address means your ethers is wasted.
    */
    function sendEther() external onlyOwner{
        uint256 _length = myPartners.length;
        for(uint256 i = 0; i < _length; i++){
            myPartners[i].transfer(1 ether);
        } 
    }
}