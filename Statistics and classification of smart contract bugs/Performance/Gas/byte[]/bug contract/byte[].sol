pragma solidity 0.5.0;

//use bytes instead of byte[]

contract waste2{
	byte[] private _secret;

	constructor() public{
		_secret = new byte[](8);
	}
}
