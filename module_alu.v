`include "defines.v"

module module_alu (
    input       [2:0]  opcode, // codigo da instrução a ser decodificado pela unit control
    input       [15:0] opA,    // operando A
    input       [15:0] opB,    // operando B
    output reg  [15:0] result  
);
  
    always @(*) begin
        case (opcode)
            `LOAD:    result = opB;
            `ADD:     result = opA + opB;
            `ADDI:    result = opA + opB;
            `SUB:     result = opA - opB;
            `SUBI:    result = opA - opB;
            `MUL:     result = opA * opB;
            `DISPLAY: result = opA;
            default: result = 16'd0;
        endcase
    end
endmodule
