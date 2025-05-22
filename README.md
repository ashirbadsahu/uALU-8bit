A very basic ALU written in SystemVerilog.

## ALU Functionality
- **Inputs**: 
  - `A` and `B`: Operands
  - `OpCode`: Control signal that selects which operation to perform
- **Outputs**:
    - `Result`: Output of the operation.
    - `Zero_Flag`: Set if Result is 0.
    - `Carry_Flag`: Set if an arithmetic operation results in a carry-out.
    - `Negative_Flag`: Set if Result is negative (MSB is 1 for signed numbers).
    - `Overflow_Flag`: Set if signed arithmetic results in an overflow.

## Block Diagram
```
        +---------------------+
        |                     |
A <-----|                     |
        |       ALU           |---> Result
B <-----|                     |
        |                     |---> Zero_Flag
OpCode<-|                     |---> Carry_Flag
        |                     |---> Negative_Flag
        |                     |---> Overflow_Flag
        +---------------------+
```
## Operations
- **Arithmetic**:
    - Addition (`A + B`)
    - Subtraction (`A - B`)
    - Increment (`A + 1`)
    - Decrement (`A - 1`)
- **Logical**:
    - AND (`A & B`)
    - OR (`A | B`)
    - NOT (`~A`)
    - XOR (`A ^ B`)

### Operation Encoding (OpCode Map)
| opcode | operation |
| ------ | --------- |
| 3'b000 | A + B     |
| 3'b001 | A - B     |
| 3'b010 | A & B     |
| 3'b011 | A \| B    |
| 3'b100 | ~A        |
| 3'b101 | A ^ B     |
| 3'b110 | A + 1     |
| 3'b111 | A - 1     |

## Simulation
- Make sure to install [Icarus Verilog](https://bleyer.org/icarus/).
- Navigate to the directory of `alu.sv` and `alu_tb.sv`, and compile it using iverilog:
```sh
iverilog -g2012 -o alu.vvp alu_tb.sv
vvp alu.vvp
gtkwave alu_wave.vcd
```