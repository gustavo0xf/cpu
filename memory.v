module memory (
	input 		[15:0] data,         // informação
	input		[3:0]  src_addr1,    // endereço do registrador 1 (direto no FPGA)
	input  	    [3:0]  src_addr2,    // endereço do registrador 2 (direto no FPGA)
	input       [3:0]  dst_addr      // endereço do registrador de destino
	input              we, clk, rst, // sinais write enable, clock e reset
	output reg  [15:0] rdata1,       // valor armazenado no registrador 1
	output reg  [15:0] rdata2        // valor armazenado no registrador 2
);
	// matriz p/ memoria e contador
	reg [15:0] ram [15:0];
	integer i;
	// escrita síncrona
	always @(posedge clk) begin
		// se for detectado um sinal de reset, zerar a memoria
		if (rst) begin
			for (i = 0; i < 16; i = i + 1) begin // analogo a um for dentro de um for, p/ leitura de matriz em C
				ram[i] = 16'd0;
			end
		end
		// write
		else if (we) begin
			ram[dst_addr] <= data;
		end
	end
	// leitura assincrona
	assign rdata1 = ram[src_addr1];
	assign rdata2 = ram[src_addr2];
endmodule
// opcode dst_reg, src_reg1, src_reg2 (Imm)
