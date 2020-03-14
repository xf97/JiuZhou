# JiuZhou(九州)
**Jiuzhou** is a collection of statistics and classification of Ethereum smart contracts. 

**Jiuzhou** follows the *[IEEE Standard Classification for Software Anomalies](https://ieeexplore.ieee.org/document/5399061)* (1044-2009) and classifies Ethereum smart contract bugs into 8 categories with a total of 50 bugs. 

**Jiuzhou** provides a brief introduction and test cases for each bug. This helps smart contract developers or researchers understand the current state of security of Ethereum and obtain benchmark data sets for testing smart contract analysis tools.

For more information on Bugs, we have an unfinished [paper](https://github.com/xf97/JiuZhou/blob/master/Jiuzhou__a_classification_framework_for_Ethereum_smart_contract_bugs.pdf).

## Bug source
First, we used *smart contract bugs*, *smart contract defects*, *smart contract problems*, and *smart contract vulnerabilities* to retrieve papers published in [IEEE](https://ieeexplore.ieee.org/Xplore/home.jsp) and [ACM](https://dl.acm.org/) after 2014 to obtain information about Ethereum smart contract bugs.

Secondly, we use the above four search keywords and *smart contract security* and *smart contract analysis tools* to retrieve Ethereum smart contract projects on Github. We got a total of 266 Github projects, and we manually checked each project to get information about the smart contract bug.

Finally, we also focus on [Github homepage of Ethereum](https://github.com/ethereum/), [the development documents of Solidity](https://solidity.readthedocs.io/en/v0.6.0), [ the official blogs of Ethereum](https://blog.ethereum.org/), [the Gitter chat room](https://gitter.im/orgs/ethereum/rooms), [Ethereum Improvement Proposals](https://eips.ethereum.org). From these resources we also get information about the Ethereum smart contract bugs.


**Jiuzhou** has removed all bugs that have been fixed.

## Bug categories
We classify Ethereum smart contract bugs into the following 8 categories:
+ **Data**. Bugs in data definition, initialization, mapping, access,   or use, as found in a model, specification, or implementation. 
+ **Interface**. Bugs in specification or implementation of an interface. 
+ **Logic**. Bugs in decision logic, branching, sequencing, or computation algorithm, as found in natural language specifications or in implementation language. 
+ **Description**. Bugs in description of software or its use, installation, or operation. 
+ **Standard**. Nonconformity with a defined standard.
+ **Security**. Bugs that threaten contract security, such as authentication, privacy/confidentiality, property.
+ **Performance**. Bugs that cause increased *gas* consumption.
+ **Interaction**. Bugs caused by contract interaction with other accounts.
+ **Environment**. Bugs due to mistakes in the software that supports Ethereum smart contracts.

