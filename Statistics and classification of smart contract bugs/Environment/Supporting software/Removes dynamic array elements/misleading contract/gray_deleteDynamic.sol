pragma solidity 0.6.2;

//I will send 1 ether to each of my business partners.

contract gray_MyBonus{
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
    
    //Manually modify the array length and shift the elements
    function deletePartner(address _badGuy) external onlyOwner{
        uint256 _length = myPartners.length;
        for(uint256 i = 0; i < _length; i++){
            if(myPartners[i] == _badGuy){
                delete myPartners[i];
                shiftElement(i, myPartners.length);
                myPartners.pop();
            }
        }
    }
    
    function shiftElement(uint256 startIndex, uint256 endIndex) internal{
        for(uint256 i = startIndex; i < endIndex; i++){
            myPartners[i] = myPartners[i+1];
        }
    }

    function sendEther() external onlyOwner{
        uint256 _length = myPartners.length;
        for(uint256 i = 0; i < _length; i++){
            myPartners[i].transfer(1 ether);
        } 
    }
}