`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/03/2023 06:51:27 PM
// Design Name: 
// Module Name: LSFR
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

//finished
//generates random numbers yayyyyy

module LSFR(
    input clk,
    output [7:0] rnd
    );
    
    wire d0;
    
    assign d0 = rnd[0] ^ rnd[5] ^ rnd[6] ^ rnd[7];
    
    FDRE #(.INIT(1'b1) ) ff0 (.C(clk), .CE(1'b1), .D(d0), .Q(rnd[0]));
    FDRE #(.INIT(1'b0) ) ffrnd[7:1] (.C({7{clk}}), .CE({7{1'b1}}), .D(rnd[6:0]), .Q(rnd[7:1]));
endmodule
