`default_nettype none

module mux_8to1_8bit (
    input wire [7:0] data0,  // 8-bit input
    input wire [7:0] data1,  // 8-bit input
    input wire [7:0] data2,  // 8-bit input
    input wire [7:0] data3,  // 8-bit input
    input wire [7:0] data4,  // 8-bit input
    input wire [7:0] data5,  // 8-bit input
    input wire [7:0] data6,  // 8-bit input
    input wire [7:0] data7,  // 8-bit input
    input wire [2:0] sel,    // 3-bit select lines
    output wire [7:0] y      // 8-bit output
);

assign y = (sel == 3'b000) ? data0 :
         (sel == 3'b001) ? data1 :
         (sel == 3'b010) ? data2 :
         (sel == 3'b011) ? data3 :
         (sel == 3'b100) ? data4 :
         (sel == 3'b101) ? data5 :
         (sel == 3'b110) ? data6 :
         data7;

endmodule
