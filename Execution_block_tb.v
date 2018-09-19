`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:19:22 08/05/2017
// Design Name:   execution_block
// Module Name:   C:/Users/Admin/Desktop/Lab1/Execution_block_tb.v
// Project Name:  Lab1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: execution_block
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Execution_block_tb;

	// Inputs
	reg [7:0] A;
	reg [7:0] B;
	reg [7:0] data_in;
	reg [4:0] op_dec;
	reg clk;
	reg reset;

	// Outputs
	wire [7:0] ans_ex;
	wire [7:0] DM_data;
	wire [7:0] data_out;
	wire [3:0] flag_ex;

	// Instantiate the Unit Under Test (UUT)
	execution_block uut (
		.ans_ex(ans_ex), 
		.DM_data(DM_data), 
		.data_out(data_out), 
		.flag_ex(flag_ex), 
		.A(A), 
		.B(B), 
		.data_in(data_in), 
		.op_dec(op_dec), 
		.clk(clk), 
		.reset(reset)
	);

	initial begin
		clk = 0;
		reset = 1;
		#200;
		reset = 0;
		#600;
		reset = 1;		
	   #200;
		
		A = 8'h40;
		B = 8'hC0;
		data_in = 8'h08;
		op_dec = 5'b00000;
		#1000;

		op_dec = 5'b00001;
		#1000;
        
		op_dec = 5'b00010;
		#1000;

		op_dec = 5'b00100;
		#1000;

		op_dec = 5'b00101;
		#1000;

		op_dec = 5'b00110;
		#1000;

		op_dec = 5'b00111;
		#1000;

		op_dec = 5'b01000;
		#1000;

		op_dec = 5'b01001;
		#1000;

		op_dec = 5'b01010;
		#1000;

		op_dec = 5'b01100;
		#1000;

		op_dec = 5'b01101;
		#1000;

		op_dec = 5'b01110;
		#1000;

		op_dec = 5'b01111;
		#1000;

		op_dec = 5'b10000;
		#1000;
		
		op_dec = 5'b10001;
		#1000;
        
		op_dec = 5'b10100;
		#1000;

		op_dec = 5'b10101;
		#1000;

		op_dec = 5'b10110;
		#1000;

		op_dec = 5'b10111;
		#1000;

		op_dec = 5'b11000;
		#1000;
		
		op_dec = 5'b11001;
		A = 8'hC0;
		B = 8'h01;
		#1000;

		op_dec = 5'b11010;
		#1000;

		op_dec = 5'b11011;
		#1000;
		
		op_dec = 5'b11100;
		#1000;		

		op_dec = 5'b11101;
		#1000;

		op_dec = 5'b11110;
		#1000;

		op_dec = 5'b11111;
		#1000;
	end
      
		always
			#500 clk = ~clk;

endmodule

