## Integer signedness error
In *Solidity*, casting a negative integer to an unsigned integer results in an error and does not throw an exception. Avoid such conversions.
Bug type: context-related bug