## The call address is externally controlled
If the call address is externally controlled, the attacker can specify the address to be called at will. Even if the call function and call parameters are fixed, the attacker can still make the contract perform any operation he wants by writing a function with the same name and same parameters at the address he specifies.
Bug type: statement Bug