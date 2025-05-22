module alu (
    input logic [7:0] a, b,
    input logic [2:0] opcode,
    output logic [7:0] result,
    output logic zero_flag, carry_flag, negative_flag, overflow_flag
);

    // internal wires
    logic [8:0] sum_sub_result;
    logic carry_out;

    // local parameters for OpCode readability
    localparam ADD = 3'b000;
    localparam SUB = 3'b001;
    localparam AND = 3'b010;
    localparam OR = 3'b011;
    localparam NOT = 3'b100;
    localparam XOR = 3'b101;
    localparam INC = 3'b110;
    localparam DEC = 3'b111;

    always_comb begin
        result = 8'b0; // default value
        zero_flag = 1'b0;
        carry_flag = 1'b0;
        negative_flag = 1'b0;
        overflow_flag = 1'b0;

        case (opcode)
            ADD: begin
                sum_sub_result = {1'b0, a} + {1'b0, b};
                result = sum_sub_result[7:0];
                carry_out = sum_sub_result[8];
            end 
            SUB: begin
                sum_sub_result = {1'b0, a} - {1'b0, b};
                result = sum_sub_result[7:0];
                carry_out = !sum_sub_result[8]; // borrow element
            end
            AND: begin
                result = a & b;
            end
            OR: begin
                result = a | b;
            end
            NOT: begin
                result = ~a;
            end
            XOR: begin
                result = a ^ b;
            end
            INC: begin
                sum_sub_result = {1'b0, a} + 1;
                result = sum_sub_result[7:0];
                carry_out = sum_sub_result[8];
            end
            DEC: begin
                sum_sub_result = {1'b0, a} + 1;
                result = sum_sub_result[7:0];
                carry_out = !sum_sub_result[8];
            end
            default: begin
                // handle invalid opcode (set result to 0)
                result = 8'b0;
            end
        endcase

        // flag generation
        zero_flag = (result == 8'b0);
        carry_flag = carry_out;
        negative_flag = result[7]; // MSB of result
        
        // overflow flag for signed arithmetic
        // for addition: (a_msb == b_msb) && (result_msb != a_msb)
        // for subtraction: (a_msb != b_msb) && (result_msb != a_msb)
        case (opcode)
            ADD, INC: begin
                overflow_flag = (a[7] == b[7]) && (result[7] != a[7]);
            end
            SUB, DEC: begin
                overflow_flag = (a[7] != b[7]) && (result[7] != a[7]);
            end
            default:  begin
                overflow_flag = 1'b0; // overflow not applicable for logical ops
            end
        endcase
    end
    
endmodule