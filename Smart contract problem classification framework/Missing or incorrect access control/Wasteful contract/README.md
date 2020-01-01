## Prodigal contract
We call a contract in which anyone can withdraw balance a prodigal contract, and the reason for this bug is that the contract does not have access control for withdrawals, allowing anyone to withdraw ethers from the contract.
In some cases, the bug is caused by misspelled constructor's name.
Bug type: context-related bug