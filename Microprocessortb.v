`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:28:04 11/06/2017
// Design Name:   Microprocessor
// Module Name:   C:/Users/Admin/Desktop/lab8/Microprocessortb.v
// Project Name:  Lab1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Microprocessor
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Microprocessortb;

	// Inputs
	reg [7:0] data_in;
	reg clk;
	reg interrupt;
	reg reset;

	// Outputs
	wire [7:0] data_out;

	// Instantiate the Unit Under Test (UUT)
	Microprocessor uut (
		.data_in(data_in), 
		.clk(clk), 
		.interrupt(interrupt), 
		.reset(reset), 
		.data_out(data_out)
	);

initial
begin
data_in = 0;
interrupt = 0;
clk = 0;
reset = 1;
#200; reset = 0;
#500; reset = 1;
end
always

#500 clk = ~clk;

      
endmodule

