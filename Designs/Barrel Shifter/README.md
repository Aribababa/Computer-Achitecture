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

Este bloque es utilizado para que la ALU pueda realizar estas operaciones con solo un ciclo de reloj. Como se mencionó este bloque es parte de la ALU.
