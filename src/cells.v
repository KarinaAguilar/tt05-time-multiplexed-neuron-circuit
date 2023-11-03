/* 
This file provides the mapping from the Wokwi modules to Verilog HDL

It's only needed for Wokwi designs

*/
`define default_netname none

module buffer_cell (
    input wire in,
    output wire out
    );
    assign out = in;
endmodule

module and_cell (
    input wire a,
    input wire b,
    output wire out
    );

    assign out = a & b;
endmodule

module or_cell (
    input wire a,
    input wire b,
    output wire out
    );

    assign out = a | b;
endmodule

module xor_cell (
    input wire a,
    input wire b,
    output wire out
    );

    assign out = a ^ b;
endmodule

module nand_cell (
    input wire a,
    input wire b,
    output wire out
    );

    assign out = !(a&b);
endmodule

module not_cell (
    input wire in,
    output wire out
    );

    assign out = !in;
endmodule

module mux_cell (
    input wire a,
    input wire b,
    input wire sel,
    output wire out
    );

    assign out = sel ? b : a;
endmodule

module dff_cell (
    input wire clk,
    input wire d,
    output reg q,
    output wire notq
    );

    assign notq = !q;
    always @(posedge clk)
        q <= d;

endmodule

module dffsr_cell (
    input wire clk,
    input wire d,
    input wire s,
    input wire r,
    output reg q,
    output wire notq
    );

    assign notq = !q;

    always @(posedge clk or posedge s or posedge r) begin
        if (r)
            q <= 0;
        else if (s)
            q <= 1;
        else
            q <= d;
    end
endmodule

module mux_4to1_8bit (
    input wire [1:0] sel,        // 2-bit select lines
    input wire [7:0] in1,     // 8-bit input
    input wire [7:0] in2,     // 8-bit input
    input wire [7:0] in3,     // 8-bit input
    input wire [7:0] in4,     // 8-bit input
    output wire [7:0] out         // 8-bit output
);

always @* begin
    case (sel)
        2'b00: out = in1;
        2'b01: out = in2;
        2'b10: out = in3;
        2'b11: out = in4;
        default: out = 8'b0; // Default case if sel is out of range
    endcase
end

endmodule


module mux_2to1_8bit (
    input wire sel,          // Select line (1 bit)
    input wire [7:0] data0,  // 8-bit input
    input wire [7:0] data1,  // 8-bit input
    output wire [7:0] out      // 8-bit output
);

assign out = (sel) ? data1 : data0;

endmodule

