## Return in constructor
The contract is not fully formed when the constructor is executing. Returning the result in the constructor makes the contract deployment process inconsistent with the intuitive experience.
Bug type: feature bug