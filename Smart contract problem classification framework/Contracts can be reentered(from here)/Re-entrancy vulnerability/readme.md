## Re-entrancy vulnerability
The **Re-entrancy** vulnerability, which caused the hard fork of *Ethereum*, is the most notorious of the many smart contract bugs. When the following four characteristics exist in the contract, the re-entrancy vulnerability exists: 
1. Use the call-statement to send **ethers** 
2. Do not specify the amount of gas to carry
3. No receiver's response function is specified.
4. Transfer **ethers** first and deduct it later.
The **Re-entrancy** vulnerability can lead to the theft of the **ethers** from the contract. Generally, avoid using the call-statement to transfer money**ethers**. If you have to, you can deduct the money first and then transfer it.
Bug type: context-related bug