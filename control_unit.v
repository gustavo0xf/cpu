`include "utils/defines.v"

module control_unit (
    input wire        clk, 
    input wire        rst, 
    input wire        sendInstruction,            // input enables
    input wire [17:0] switchVector,
    output reg        wE, rE, aluE, lcdE, clearE, // output enables
    output reg [2:0]  opcode,
    output reg [3:0]  src_reg1,
    output reg [3:0]  src_reg2,
    output reg [3:0]  dst_reg,
    output reg [15:0] imm
);
    // chamando a função para tratar o sinal
    `include "utils/manageSignal.v"
    // estados
    parameter off     = 0;
    parameter on      = 1;
    parameter await   = 2;
    parameter fetch   = 3;
    parameter decode  = 4;
    parameter read    = 5;
    parameter execute = 6;
    parameter store   = 7;
    // estado atual e instrução para decodificação
    reg [2:0]  state       = OFF;
    reg [17:0] instruction = 18'd0;
    // parte combinacional
    always @(*) begin
        case (state)
            off: begin
                wE     = 0;
                rE     = 0;
                aluE   = 0;
                lcdE   = 0;
                clearE = 0;
            end
            on: begin
                wE     = 0;
                rE     = 0;
                aluE   = 0;
                lcdE   = 0;
                clearE = 1;
            end
            await: begin
                wE     = 0;
                rE     = 0;
                aluE   = 0;
                lcdE   = 0;
                clearE = 0;
            end
            fetch: begin
                wE     = 0;
                rE     = 0;
                aluE   = 0;
                lcdE   = 0;
                clearE = 0;
            end
            decode: begin
                wE     = 0;
                rE     = 0;
                aluE   = 0;
                lcdE   = 0;
                clearE = 0;
            end
            read: begin
                wE     = 0;
                rE     = 1;
                aluE   = 0;
                lcdE   = 0;
                clearE = 0;
            end
            execute: begin
                wE     = 0;
                rE     = 0;
                aluE   = 1;
                lcdE   = 0;
                clearE = 0;
            end
            store: begin
                if (opcode == `DISPLAY) begin
                    lcdE = 1;
                end
                if (opcode != `CLEAR && opcode != `DISPLAY) begin
                    wE = 1;
                end
            end
        endcase
    end
    // parte sequencial
    always @(posedge clk) begin
        if (rst) begin
            if (state == OFF) state <= ON;
            else state <= OFF;
        end
        else begin
            case (state)
                OFF: begin
                    ; // fica inativo
                end
                ON: begin
                    instruction <= 0;
                    opcode      <= 0;
                    dst_reg     <= 0;
                    src_reg1    <= 0;
                    src_reg2    <= 0;
                    imm         <= 0;  
                    state       <= AWAIT;
                end
                AWAIT: begin
                    if (sendInstruction) state <= FETCH;
                end
                FETCH: begin
                    instruction <= switchVector;
                    state <= DECODE;
                end

                DECODE: begin
                    if (instruction[`OPCODE] == `ADDI || instruction[`OPCODE] == `SUBI || instruction[`OPCODE] == `MUL) 
                    begin                    
                        opcode   <= instruction[`OPCODE];
                        dst_reg  <= instruction[`DST_REG];
                        src_reg1 <= instruction[`IMM_SRC0];
                        imm      <= sgnExt(instruction[`SGN], instruction[`IMM]);
                    end
                    else if (instruction[`OPCODE] == `ADD || instruction[`OPCODE] == `SUB) 
                    begin
                        opcode   <= instruction[`OPCODE];
                        dst_reg  <= instruction[`DST_REG];
                        src_reg1 <= instruction[`REG_SRC0];
                        src_reg2 <= instruction[`REG_SRC1];
                    end
                    else if (instruction[`OPCODE] == `LOAD) 
                    begin
                        opcode   <= instruction[`OPCODE];
                        dst_reg  <= instruction[`DST_REG];
                        imm      <= sgnExt(instruction[`SGN], instruction[`IMM]);
                    end
                    else if (instruction[`OPCODE] == `CLEAR || instruction[`OPCODE] == `DISPLAY) 
                    begin
                        opcode   <= instruction[`OPCODE];
                        src_reg1 <= instruction[`DST_REG];
                        dst_reg  <= instruction[`DST_REG];
                    end
                    state <= READ;
                end
                READ: begin
                    state <= EXECUTE;
                end
                EXECUTE: begin
                    state <= STORE;
                end
                STORE: begin
                    state <= AWAIT;
                end
            endcase
        end
    end
endmodule