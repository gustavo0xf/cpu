module cpu_top(

    input clk,
    input [17:0] SW,

    input KEY0,      // ligar
    input KEY1,      // enviar instrução

    inout [7:0] LCD_DATA,
    output LCD_RS,
    output LCD_RW,
    output LCD_EN

);

    // FIOS INTERNOS

    wire [15:0] alu_result;

    wire [15:0] reg_a;
    wire [15:0] reg_b;

    wire [3:0] read_addr1;
    wire [3:0] read_addr2;
    wire [3:0] write_addr;

    wire [15:0] write_data;

    wire write_enable;

    wire [2:0] opcode;

    // UNIDADE DE CONTROLE

    control_unit CU (

        .clk(clk),

        .instruction(SW),

        .send(KEY1),

        .opcode(opcode),

        .read_addr1(read_addr1),
        .read_addr2(read_addr2),

        .write_addr(write_addr),

        .write_enable(write_enable)

    );

    // BANCO DE REGISTRADORES

    memory MEM (

        .clk(CLOCK_50),

        .we(write_enable),

        .wr_addr(write_addr),

        .wr_data(alu_result),

        .rd_addr1(read_addr1),
        .rd_addr2(read_addr2),

        .rd_data1(reg_a),
        .rd_data2(reg_b)

    );

    // ULA

    module_alu ALU (

        .A(reg_a),

        .B(reg_b),

        .opcode(opcode),

        .result(alu_result)

    );

    // LCD

    lcd_controller_top LCD (

        .clk(CLOCK_50),

        .result(alu_result),

        .LCD_DATA(LCD_DATA),

        .LCD_RS(LCD_RS),

        .LCD_RW(LCD_RW),

        .LCD_EN(LCD_EN)

    );

endmodule
