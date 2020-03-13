## Removes dynamic array elements
In *Solidity*, deleting dynamic array elements does not automatically shorten the length of the array and move the array elements. You need to manually shorten the array length and manually shift the elements. Otherwise, gaps are left in the array (the deleted element is simply set as the default).
Bug type: context-related bug