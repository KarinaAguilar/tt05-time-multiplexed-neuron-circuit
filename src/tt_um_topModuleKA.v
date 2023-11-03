`default_nettype none

module tt_um_topModuleKA (
    input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);


    // use bidirectionals as outputs
    assign uio_oe = 8'b11111111;
    

    //wire declarations
    wire [7:0] in1, in2, out1, out2;
    wire spike1, spike2;

    //assigning inputs
    assign in1 = {ui_in[7], 7'd0};

    //assigning outputs
    assign uio_out[7:0] = {6'd0, spike2, spike1};

    // instantiate lif neuron
    lif lif1 (.current(in1), .clk(clk), .rst_n(rst_n), .spike(spike1), .state(out1));
    lif lif2 (.current(in2), .clk(clk), .rst_n(rst_n), .spike(spike2), .state(out2));



endmodule
