## Hide state variables
Inheritance makes a common bug that causes variables in subclasses to hide variables with the same name in the base class. And in smart contracts, the impact of this bug is magnified, and hidden base-class state variables are assigned to default values, which can be harmful in some cases.
Bug type: context-related bug