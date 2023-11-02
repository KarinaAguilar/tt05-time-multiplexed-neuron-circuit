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

