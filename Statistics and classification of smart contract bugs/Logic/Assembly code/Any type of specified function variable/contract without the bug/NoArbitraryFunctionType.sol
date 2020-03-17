pragma solidity 0.5.16;

//based on swc


contract NoFunctionTypes {
    struct Func{ 
        function () internal f; 
    }
    
    constructor() public payable { require(msg.value != 0); }
    
    function withdraw() private {
        require(msg.value == 0, 'dont send funds!');
        address(msg.sender).transfer(address(this).balance);
    }
    
    function frwd() internal{ 
        withdraw(); 
    }
    
    function breakIt() public payable {
        require(msg.value != 0, 'send funds!');
        Func memory func;
        func.f = frwd;
        //assembly { mstore(func, add(mload(func), callvalue)) }  //wrong
        func.f();
    }
}
