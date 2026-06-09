module debounce (
	input clk, btn,			    // clock e sinal físico do botão
	output reg instructionPulse // sinal que habilita o envio da instrução
);
	// timeout de debounce
	parameter TIMEOUT = 500000;
	// o sinal do botão físico é assíncrono, portanto, precisamos sincronizá-lo com o clock
	reg sync, btnSync;
	
	always @(posedge clk) begin
		sync    <= btn;  // recebe o sinal físico
		btnSync <= sync; // sincroniza de fato
	end
	// estados
	parameter init            = 0; // 00
	parameter debounce        = 1; // 01
	parameter waitRelease     = 2; // 10
	parameter sendInstruction = 3; // 11
	// estado atual e contador
	reg [1:0]  state = init;
	reg [32:0] counter;
	reg [1:0]  state;
	reg [32:0] counter;
	// parte combinacional
	always @(*) begin
		case (state)
			init: begin
				instructionPulse <= instructionPulse;
			end
			debounce: begin
				instructionPulse <= instructionPulse;
			end
			waitRelease: begin
				instructionPulse <= instructionPulse;
			end
			sendInstruction: begin
				instructionPulse <= ~instructionPulse;
			end
		endcase
	end
	// parte sequencial
	always @(posedge clk) begin
		case (state)
			init: begin
				counter <= 0;
				if (btnSync == 1) begin state <= debounce; end
				else begin state <= init; end
			end
			debounce: begin
				if (counter == TIMEOUT) begin state <= waitRelease; end
				else if (btnSync == 0) begin state <= init; end
				else begin
					counter <= counter + 1;
					state <= debounce;
				end
			end
			waitRelease: begin
        if (btnSync == 0) begin state <= sendInstruction; end
				else begin state <= waitRelease; end
			end
			sendInstruction: begin 
				state <= init; 
			end
		endcase
	end	
endmodule
