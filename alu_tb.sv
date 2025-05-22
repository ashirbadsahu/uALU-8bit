`timescale 1ns/1ps
`include "alu.sv"

module alu_tb;
    logic [7:0] a, b;
    logic [2:0] opcode;
    logic [7:0] result;
    logic zero_flag, carry_flag, negative_flag, overflow_flag;


    alu uut (
        .a(a),
        .b(b),
        .opcode(opcode),
        .result(result),
        .zero_flag(zero_flag),
        .carry_flag(carry_flag),
        .negative_flag(negative_flag),
        .overflow_flag(overflow_flag)
    );

    // local parameters for OpCode readability
    localparam ADD = 3'b000;
    localparam SUB = 3'b001;
    localparam AND = 3'b010;
    localparam OR = 3'b011;
    localparam NOT = 3'b100;
    localparam XOR = 3'b101;
    localparam INC = 3'b110;
    localparam DEC = 3'b111;

    initial begin
        $display("simulation starting");
        $dumpfile("alu_wave.vcd");
        $dumpvars(0, uut);

        // test case 1: ADD(5 + 4 = 9)
        a = 8'd5;
        b = 8'd4;
        opcode = ADD;
        #10;
        $display("A=%0d, B=%0d, OpCode=%b (ADD), Result=%0d, Z=%b, C=%b, N=%b, O=%b", a, b, opcode, result, zero_flag, carry_flag, negative_flag, overflow_flag);

        // test case 2: SUB(10-6 = 4)
        a = 8'd10;
        b = 8'd6;
        opcode = SUB;
        #10;
        $display("A=%0d, B=%0d, OpCode=%b (SUB), Result=%0d, Z=%b, C=%b, N=%b, O=%b", a, b, opcode, result, zero_flag, carry_flag, negative_flag, overflow_flag);

        // test case 3: AND(0xF0 & 0x0F = 0x00)
        a = 8'hF0;
        b = 8'h0F;
        opcode = AND;
        #10;
        $display("A=%0d, B=%0d, OpCode=%b (AND), Result=%0d, Z=%b, C=%b, N=%b, O=%b", a, b, opcode, result, zero_flag, carry_flag, negative_flag, overflow_flag);

        // test case 4: OR(0xAA | 0x55 = 0xFF)
        a = 8'hAA;
        b = 8'h55;
        opcode = OR;
        #10;
        $display("A=%0d, B=%0d, OpCode=%b (OR), Result=%0d, Z=%b, C=%b, N=%b, O=%b", a, b, opcode, result, zero_flag, carry_flag, negative_flag, overflow_flag);

        // test case 5: NOT(0xAA = 0x55)
        a = 8'hAA;
        opcode = NOT;
        #10;
        $display("A=%0d, OpCode=%b (NOT), Result=%0d, Z=%b, C=%b, N=%b, O=%b", a, b, opcode, result, zero_flag, carry_flag, negative_flag, overflow_flag);

        // test case 6: XOR(0xF0 ^ 0xFF = 0x0F)
        a = 8'hF0;
        b = 8'hFF;
        opcode = XOR;
        #10;
        $display("A=%0d, B=%0d, OpCode=%b (OR), Result=%0d, Z=%b, C=%b, N=%b, O=%b", a, b, opcode, result, zero_flag, carry_flag, negative_flag, overflow_flag);

        // test case 7: Increment (255 + 1 = 0, Carry)
        a = 8'd255; // 0xFF
        opcode = INC;
        #10;
        $display("A=%0d, OpCode=%b (INC), Result=%0d, Z=%b, C=%b, N=%b, O=%b", a, b, opcode, result, zero_flag, carry_flag, negative_flag, overflow_flag);

        // test case 8: Decrement (0 - 1 = 255, Carry for subtraction)
        a = 8'd0; // 0x00
        opcode = DEC;
        #10;
        $display("A=%0d, OpCode=%b (DEC), Result=%0d, Z=%b, C=%b, N=%b, O=%b", a, b, opcode, result, zero_flag, carry_flag, negative_flag, overflow_flag);

        // test case 9: Signed addition overflow (70 + 80 = 150 (positive + positive = negative result))
        a = 8'd70; // 0100_0110 (positive)
        b = 8'd80; // 0101_0000 (positive)
        opcode = ADD;
        #10;
        $display("A=%0d, B=%0d, OpCode=%b (ADD - Overflow), Result=%0d, Z=%b, C=%b, N=%b, O=%b", a, b, opcode, result, zero_flag, carry_flag, negative_flag, overflow_flag);
        // Expected: Result = -106 (signed), Z=0, C=0, N=1, O=1


        $display("ALU test bench simulation finished.");
        $finish;
    end
endmodule