module control_unit (
	input clk, rst
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

endmodule
