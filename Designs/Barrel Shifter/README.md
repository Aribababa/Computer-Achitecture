# Bit Shifting Block Implemented with Barrel Shifters

A barrel shifter is a specialized digital electronic circuit with the purpose of shifting an entire data word by a specified number of bits by only using combinational logic, 
with no sequential logic used.

The Simplest way to implementing this desigs was using Multiplexers in a specific manner that depends on the amount of shift specified.

![Barrel_Shifter](https://i.stack.imgur.com/AefYE.jpg)
*Example of a Barrel Shifter*

Using this design we develop a Bit Shifting block which was used for implementing arithmetic operation like:

⋅⋅* Arithmetic Shift Right. 
⋅⋅* Logic Shift Right.
⋅⋅* Logic Shift Left.
⋅⋅* Rotate Right.


This block is used so that the ALU can perform these operations with only one clock cycle. As mentioned this block is part of the ALU.
