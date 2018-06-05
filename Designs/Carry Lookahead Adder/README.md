# Carry Look-Ahead Adder

A carry-Lookahead adder is a fast parallel adder as it reduces the propagation delay by more complex hardware, hence it is costlier. In this design, the carry logic over fixed groups of bits of the adder is reduced to two-level logic, which is nothing but a transformation of the ripple carry design.

![CarryLookAhedadAdder](http://cse10-iitkgp.virtual-labs.ac.in/images/carrylookahead.png)
*Example of a carry LookAhdead Adder*

It is also possible to construct 16 bit and 32 bit parallel adders by cascading the number of 4 bit adders with carry logic. A 16 bit carry-Lookahead adder is constructed by cascading the four 4 bit adders with two more gate delays, whereas the 32 bit carry-Lookahead adder is formed by cascading of two 16 bit adders.

For this proyect, this type of adder was a requieriment. This a part of the ALU.
