## byte[]
The type **byte[]** is an array of bytes, but due to padding rules, it wastes 31 bytes of space for each element (except in storage). It is better to use the **bytes** type instead.
Bug type: feature bug