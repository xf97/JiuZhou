## Integer division
Until now, *Solidity* doesn't support decimals or fixed-point numbers, and all integer division results are rounded down, which can lead to a loss of accuracy. Avoid using integer division to calculate the amount of **ethers**. If you have to, try multiplying before dividing to offset the loss of accuracy.
Bug type: context-related bug