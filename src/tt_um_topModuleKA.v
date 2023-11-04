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
    wire [7:0] in1, in2, out1, out2, in3, out3, in4, out4, w0, w1, r, in5, out5, w2;
    wire spike1, spike2, spike3, spike4, spike5;

    LSFR random (.clk(clk), .rnd(r), .rst_n(rst_n));

    //assigning inputs
    //pair prop
    assign in1 = {ui_in[7:4], 4'd0};
    assign in2 = out1;

    //pair prop
    assign in3 = ui_in + 8'd10;
    assign in4 = out3;

    //one neuron that has random current input
    assign in5 = r;
    

    // instantiate lif neuron
    lif lif1 (.current(in1), .clk(clk), .rst_n(rst_n), .spike(spike1), .state(out1));
    lif lif2 (.current(in2), .clk(clk), .rst_n(rst_n), .spike(spike2), .state(out2));
    
    lif lif3 (.current(in3), .clk(clk), .rst_n(rst_n), .spike(spike3), .state(out3));
    lif lif4 (.current(in4), .clk(clk), .rst_n(rst_n), .spike(spike4), .state(out4));

    lif lif5 (.current(in5), .clk(clk), .rst_n(rst_n), .spike(spike5), .state(out5));

    //weight multiplication
    mux_2to1_8bit weight0 (.data0(8'd0), .data1(out2 >> r[2:0]), .sel(spike2), .out(w0)); //multiply by random number 0-7
    mux_2to1_8bit weight1 (.data0(8'd0), .data1(out4 << 1), .sel(spike4), .out(w1)); //divide by 2
    mux_2to1_8bit weight2 (.data0(8'd0), .data1(out5 >> r[4:3]), .sel(spike5), .out(w2)); //multiply by random number 0-7 but from diff portion

    //assigning outputs
    assign uio_out = {3'd0, spike5, spike4, spike3, spike2, spike1};
 
    mux_8to1_8bit muxing (.sel(r[1:0]), .data0(out1), .data1(out2), .data2(out3), .data3(out4), .data4(out5), .data5(w0), .data6(w1), .data7(w2), .y(uo_out));


endmodule
