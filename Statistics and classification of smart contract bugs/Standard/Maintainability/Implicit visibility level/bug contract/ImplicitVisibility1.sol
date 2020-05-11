pragma solidity 0.6.2;

//based on swc

/Prior to Solidity 0.5.0 version, you could not explicitly specify the visibility of state variables and functions, which would be given by default (after 0.5.0, functions must specify visibility). Not explicitly specifying visibility makes the code hard to understand, and state variables that do not explicitly specify visibility are set to private.

contract NoVisitLevel {
    //These state variable still does not specify visibility
    uint storeduint1 = 15;
    uint constant constuint = 16;
    uint32 investmentsDeadlineTimeStamp = uint32(now); 

    bytes16 string1 = "test1"; 
    bytes32 string2 = "test1236"; 
    string  string3 = "lets string something"; 

    mapping (address => uint)  uints1; 
    mapping (address => DeviceData) structs1; 

    uint[] uintarray; 
    DeviceData[] deviceDataArray; 

    struct DeviceData {
        string deviceBrand;
        string deviceYear;
        string batteryWearLevel;
    }
    
    constructor() public{
        
    }
    
    function getConstuint() public returns(uint256){
        return constuint;
    }
}
