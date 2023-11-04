`default_nettype none

//finished
//generates random numbers yayyyyy

module LSFR(
    input clk,
    output [7:0] rnd, 
    input rst_n
    );
    
    wire d0;
    
    assign d0 = rnd[0] ^ rnd[5] ^ rnd[6] ^ rnd[7];
    
    fdre_reset1 ff0 (.C(clk), .d(d0), .rst(!rst_n), .q(rnd[0]));
    fdre ffrnd[7:1] (.C({7{clk}}), .d(rnd[6:0]), .rst(!rst_n), .q(rnd[7:1]));

endmodule