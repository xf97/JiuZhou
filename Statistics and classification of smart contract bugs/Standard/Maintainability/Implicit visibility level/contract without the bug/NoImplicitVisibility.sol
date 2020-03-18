pragma solidity 0.6.2;

//based on swc 108

contract HashForEther {
    
    uint public storeduint1 = 15;
    uint public constant constuint = 16;
    uint32 public investmentsDeadlineTimeStamp = uint32(now); 

    bytes16 private string1 = "test1"; 
    bytes32 private string2 = "test1236"; 
    string public string3 = "lets string something"; 

    mapping (address => uint) public uints1; 
    mapping (address => DeviceData) public  structs1; 

    uint[] public  uintarray; 
    DeviceData[] public deviceDataArray; 

    struct DeviceData {
        string deviceBrand;
        string deviceYear;
        string batteryWearLevel;
    }

    function testStorage(address payable address1, address payable address2) public  {
        uints1[address1] = 88;
        uints1[address2] = 99;

        DeviceData memory dev1 = DeviceData("deviceBrand", "deviceYear", "wearLevel");

        structs1[address1] = dev1;

        uintarray.push(8000);
        uintarray.push(9000);

        deviceDataArray.push(dev1);
    }

    function withdrawWinnings() public  {
        // Winner if the last 8 hex characters of the address are 0. 
        require(uint32(msg.sender) == 0);
        _sendWinnings();
     }

     function _sendWinnings() public  {
         msg.sender.transfer(address(this).balance);
     }
}
