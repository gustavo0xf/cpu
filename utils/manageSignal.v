function [15:0] sgnExt;
        input signal;
        input [5:0] imm_val;
        begin
            if (signal) // negativo
                sgnExt = ~{10'b0000000000, imm_val} + 16'd1;
            else        // positivo
                sgnExt = {10'b0000000000, imm_val};
        end
endfunction