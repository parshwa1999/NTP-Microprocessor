`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:30:18 09/01/2017
// Design Name:   Stall_Control_Block
// Module Name:   C:/Users/1641068/Desktop/Lab1/Stall_Control_Block_tb.v
// Project Name:  Lab1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Stall_Control_Block
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Stall_Control_Block_tb;

	// Inputs
	reg [23:0] ins;
	reg clk;
	reg reset;

	// Outputs
	wire Stall_pm;
	wire Stall;

	// Instantiate the Unit Under Test (UUT)
	Stall_Control_Block uut (
		.Stall_pm(Stall_pm), 
		.Stall(Stall), 
		.ins(ins), 
		.clk(clk), 
		.reset(reset)
	);

	initial begin
		ins = 0;
		clk = 0;
		reset = 1;
      
		#200;
		reset = 0;
		
		#600;
		reset = 1;
		
		#800;
		ins = 24'ha00000;
		
		#2000;
		ins = 24'h000000;
		
		#1000;
		ins = 24'hf00000;
		
		#3000;
		ins = 24'h000000;
		
		#1000;
		ins = 24'h880000;
		
	end
	
	always
	begin
		#500;
		clk = ~clk;
	end
      
endmodule

