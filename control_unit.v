module control_unit (

    input clk,
    input rst,

    input [17:0] instruction,

    output reg [2:0] opcode,

    output reg [3:0] src1,
    output reg [3:0] src2,
    output reg [3:0] dst,

    output reg we

);

    always @(*) begin

        opcode = instruction[17:15];
        dst    = instruction[14:11];
        src1   = instruction[10:7];
        src2   = instruction[3:0];

        case(opcode)

            3'b000: we = 1'b1; // LOAD
            3'b001: we = 1'b1; // ADD
            3'b010: we = 1'b1; // ADDI
            3'b011: we = 1'b1; // SUB
            3'b100: we = 1'b1; // SUBI
            3'b101: we = 1'b1; // MUL

            3'b110: we = 1'b0; // CLEAR

            3'b111: we = 1'b0; // DISPLAY

            default: we = 1'b0;

        endcase

    end

endmodule
