`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:46:30 08/18/2017
// Design Name:   Data_Memory_Block
// Module Name:   C:/Users/1641068/Desktop/Lab1/Data_Memory_Block_tb.v
// Project Name:  Lab1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Data_Memory_Block
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Data_Memory_Block_tb;

	// Inputs
	reg [7:0] ans_ex;
	reg [7:0] DM_data;
	reg mem_rw_ex;
	reg mem_en_ex;
	reg mem_mux_sel_dm;
	reg reset;
	reg clk;

	// Outputs
	wire [7:0] ans_dm;

	// Instantiate the Unit Under Test (UUT)
	Data_Memory_Block uut (
		.ans_dm(ans_dm), 
		.ans_ex(ans_ex), 
		.DM_data(DM_data), 
		.mem_rw_ex(mem_rw_ex), 
		.mem_en_ex(mem_en_ex), 
		.mem_mux_sel_dm(mem_mux_sel_dm), 
		.reset(reset), 
		.clk(clk)
	);

initial begin

		ans_ex = 8'h03;
		DM_data = 8'hFF;
		mem_rw_ex = 1'b0;
		mem_en_ex = 1'b0;
		mem_mux_sel_dm = 1'b0;
		reset = 1'b1;
		clk = 1'b0;
		
		#200;
		reset = 1'b0;
		
		#600;
		reset = 1'b1;
		
		#200;
		mem_en_ex = 1'b1;
		mem_mux_sel_dm = 1'b1;
		
		#1000;
		mem_rw_ex = 1'b1;
		
		#1000;
		mem_rw_ex = 1'b0;		
	end
    
	always
		#500	clk = ~clk;
endmodule

