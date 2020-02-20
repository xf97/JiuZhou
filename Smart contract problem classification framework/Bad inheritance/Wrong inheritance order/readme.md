## Wrong inheritance order
*Solidity* supports multiple inheritance, and when you have a function or variable of the same name in your base class, the order of inheritance matters, which determines which one will be integrated into the subclass. The wrong inheritance sequence will result in the functionality of the contract not being what the developer expected.
Bug type: feature bug