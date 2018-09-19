`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:47:37 08/11/2017
// Design Name:   PCIM
// Module Name:   C:/Users/1641068/Desktop/Lab1/PCIM_tb.v
// Project Name:  Lab1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: PCIM
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module PCIM_tb;

	// Inputs
	reg [7:0] jmp_loc;
	reg pc_mux_sel;
	reg Stall;
	reg Stall_pm;
	reg reset;
	reg clk;

	// Outputs
	wire [23:0] ins;
	wire [7:0] Current_Address;

	// Instantiate the Unit Under Test (UUT)
	PCIM uut (
		.ins(ins), 
		.Current_Address(Current_Address), 
		.jmp_loc(jmp_loc), 
		.pc_mux_sel(pc_mux_sel), 
		.Stall(Stall), 
		.Stall_pm(Stall_pm), 
		.reset(reset), 
		.clk(clk)
	);

	initial begin
		// Initialize Inputs
		jmp_loc = 8'h08;
		pc_mux_sel = 1'b1;
		Stall = 1'b0;
		Stall_pm = 1'b0;
		reset = 1'b1;
		clk = 1'b0;
		
		#200;
		reset = 1'b0;
		
		#600;
		reset = 1'b1;
		pc_mux_sel = 1'b0;
		
		#3200;
		Stall = 1'b1;
		
		#1000;
		Stall = 1'b0;
		Stall_pm = 1'b1;
		
		#1000;
		Stall_pm = 1'b0;
		pc_mux_sel = 1'b1;

	end
      
	always
		#500	clk = ~clk;

endmodule

