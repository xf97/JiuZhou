## Unused public functions within a contract should be declared external
There are four kinds of external visibility required in *Solidity*:
1. external --- function can only be called externally
2. internal --- function can only be used in this contract and subclass
3. private --- function can only be used in this contract
4. public --- function can be called by external accounts or internal functions

Among them, the **gas** consumption can be saved by declaring the **public** function not used in the contract as **external**.
Bug type: feature bug