BugName: Results of contract execution affected by miners
BugLineNumber: 18
BugResaon: Miners can know the value of answer by obtaining 
           the values of now and block.number, thus gaining a competitive advantage.
ContractSource: https://github.com/smartdec/smartcheck