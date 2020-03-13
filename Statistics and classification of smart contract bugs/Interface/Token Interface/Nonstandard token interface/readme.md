## Non-standard token interface
In order to facilitate the interaction of token contracts in *Ethereum*, some token contract standards have been established. These standards specify the **state variables**, **functions** and **event** information that should be included in the token contracts. Following these standards to develop token contracts enables your contract to interact with other contracts.
There are seven main bugs with **non-standard token interfaces**:
1. Missing token standard state variable
2. Missing token standard functions or events
3. Raises an exception in a function that should return a Boolean value
4. The function does not return a value of the specified type according to the token standard
5. There are no recorded events in the functions that should record events (such as the approve, transfer, and transferFrom functions specified by the ERC20 standard)
6. At least one of the parameters of the event should be indexed
7. A function that returns a Boolean value should not return only one result

### We provide two standard test contracts for ERC20 and ERC721

Bug type: feature bug