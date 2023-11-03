`default_nettype none

module lif (
    input wire [7:0] current,
    input wire clk,
    input wire rst_n,
    output wire spike,
    output reg [7:0] state
);
    //defines local vars
    reg [7:0] threshold;
    wire [7:0] next_state;

    always @(posedge clk) begin //@ positive clk edge do the following
        //if reset is high, then does the below [Note: ! inverts the bit]
        if (!rst_n) begin 
            state <= 0; //initialize state into a known condition
            threshold <= 127; //defines the threshold
        end else begin
            //go into next_state
            state <= next_state; 
        end
    end

        //next state logic
        assign next_state = current + (spike ? 0: (state >> 1) ); //mux; if spike is 1, then do not add decayed value; else, add decay value
        //the decay rate is 0.5

        //spike logic
        assign spike = (state >= threshold);
    
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
