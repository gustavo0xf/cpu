module module_alu (
    input             [2:0]  opcode, // codigo da instrução a ser decodificado pela unit control
    input signed      [15:0] opA,    // operando A
    input signed      [15:0] opB,    // operando B
    output reg signed [15:0] result  // ?
);
    // opcodes de acordo com as especificações
    parameter LOAD    = 3'b000; // LOAD x1, a
    parameter ADD     = 3'b001; // ADD  x3, x1, x2
    parameter ADDI    = 3'b010; // ADDI x2, x1, 10
    parameter SUB     = 3'b011; // SUB  x3, x1, x2
    parameter SUBI    = 3'b100; // SUBI x2, x1, 5
    parameter MUL     = 3'b101; // MUL  x3, x1, x2
    parameter CLEAR   = 3'b110; // zera os registradores
    parameter DISPLAY = 3'b111; // DISPLAY x0
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
