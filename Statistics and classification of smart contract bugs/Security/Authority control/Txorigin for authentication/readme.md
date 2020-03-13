## Tx.origin for authentication
*Solidity* provides the keyword **tx.origin** to indicate the source of the transaction. Using **tx.origin** for authentication can cause an attacker to bypass authentication after spoofing your trust. **tx.origin** is not recommended for authentication.
Bug type: context-related bug