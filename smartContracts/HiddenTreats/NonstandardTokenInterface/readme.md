# Non-standard token interface
There are seven main problems with non-standard token interfaces:
1. Missing token standard state variable
2. Missing token standard functions
3. Raises an exception in a function that should return a Boolean value
4. The function does not return a value of the specified type according to the token standard
5. There are no recorded events in the functions that should record events (such as the approve, transfer, and transferFrom functions specified by the ERC20 standard)
6. At least one of the parameters of the event should be indexed
7. A function that returns a Boolean value should not return only one result

## We provide two standard test contracts for ERC20 and ERC721