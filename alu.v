module alu (
    input             [2:0]  opcode,
    input signed      [15:0] opA,
    input signed      [15:0] opB,
    output reg signed [15:0] result
);
    // opcodes
    parameter LOAD    = 3'b000;
    parameter ADD     = 3'b001;
    parameter ADDI    = 3'b010;
    parameter SUB     = 3'b011;
    parameter SUBI    = 3'b100;
    parameter MUL     = 3'b101;
    parameter CLEAR   = 3'b110;
    parameter DISPLAY = 3'b111; 
    // parte combinacional: definição dos outputs de acordo com a instrução
    always @(*) begin
        case (opcode)
            LOAD:    result = opB;       
            ADD:     result = opA + opB;
            ADDI:    result = opA + opB;
            SUB:     result = opA - opB;
            SUBI:    result = opA - opB;
            MUL:     result = opA * opB;
            CLEAR:   result = 16'd0; 
            DISPLAY: result = opA;
            default: result = 16'd0;
        endcase
    end
endmodule
