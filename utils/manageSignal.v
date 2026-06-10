function [15:0] signal_extension;
        input signal;
        input [5:0] imm_val;
        begin
            if (signal) // negativo
                signal_extension = ~{10'b0000000000, imm_val} + 16'd1;
            else        // positivo
                signal_extension = {10'b0000000000, imm_val};
        end
endfunction