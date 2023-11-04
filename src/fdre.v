`default_nettype none


module fdre(
    input wire C,        // Clock input
    input wire rst,        // Reset input
    input wire set,        // Set input
    input wire d,          // Data input
    output wire q          // Q output
    );

    reg q_reg;  // Flip-flop output register

    always @(posedge C or posedge rst) begin
        if (rst) begin
            q_reg <= 1'b0;  // Reset condition
        end else if (set) begin
            q_reg <= 1'b1;  // Set condition
        end else begin
            q_reg <= d;      // Data is transferred on the rising edge of the clock
        end
    end

assign q = q_reg;
endmodule
