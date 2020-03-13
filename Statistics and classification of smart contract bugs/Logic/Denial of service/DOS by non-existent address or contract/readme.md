## DOS by non-existent address or contract
The call fails when the address with which it interacts does not exist or when a contract exception occurs. To prevent the features of the contract from being affected, the following principles should be observed:
1. The features of the contract should not be limited by a certain key address. For the sake of insurance, the standby address can be set generally.
2. When transferring to the outside, do not use the **tranfer-statement** to transfer in the loop, and try to let the user take the moeny instead of sending.
Bug type: context-related bug