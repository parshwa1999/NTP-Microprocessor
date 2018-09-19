`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:55:09 08/04/2017 
// Design Name: 
// Module Name:    ALU 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ALU(
	output [7:0] ans_tmp,
	output [7:0] data_out_buff,
	output [3:0] flag_ex,
	input [7:0] data_in,
	input [4:0] op_dec,
	input [7:0] A,
	input [7:0] B,
	input [7:0] ans_ex,
	input [7:0] data_out,
	input clk
	);
	
	wire [7:0] sum;
	wire tmp1, tmp2;
	reg [3:0] flagtmp;
	
	add_sub_8bit adder1(sum, tmp1 , tmp2, A, B, op_dec[0]);
	
	assign ans_tmp = (op_dec == 5'b00000 || op_dec == 5'b01000) ? (sum) : 	// ADD and ADI
						  (op_dec == 5'b00001 || op_dec == 5'b01001) ? (A - B) : // SUB and SBI
						  (op_dec == 5'b00010 || op_dec == 5'b01010) ? (B) :		// MOV and MVI
						  (op_dec == 5'b00100 || op_dec == 5'b01100) ? (A & B) :	// AND and ANI
						  (op_dec == 5'b00101 || op_dec == 5'b01101) ? (A | B) :	// OR and ORI
						  (op_dec == 5'b00110 || op_dec == 5'b01110) ? (A ^ B) : // XOR and XRI
						  (op_dec == 5'b00111 || op_dec == 5'b01111) ? (~B) :		// NOT and NTI
						  (op_dec == 5'b10100 || op_dec == 5'b10101) ? (A) :		// LD and ST
						  (op_dec == 5'b10110) ? (data_in) :							// IN
						  (op_dec == 5'b11001) ? (A << B) :								// LS
						  (op_dec == 5'b11010) ? (A >> B) :								// RS
						  (op_dec == 5'b11011) ?((A[7]) ?								// RSA
															((B == 0) ? A :
														   (B == 1) ? {1'b1, A[7:1]} :
														   (B == 2) ? {2'b11, A[7:2]} :
														   (B == 3) ? {3'b111, A[7:3]} :
														   (B == 4) ? {4'b1111, A[7:4]} :
														   (B == 5) ? {5'b11111, A[7:5]} :
														   (B == 6) ? {6'b111111, A[7:6]} :
														   (B == 7) ? {7'b1111111, A[7]} :
														    8'b11111111)
													  : (A >> B) ):
						(op_dec == 5'b10000 || op_dec == 5'b10001 || op_dec == 5'b10111 || op_dec == 5'b11000 || op_dec == 5'b11100 || op_dec == 5'b11101 || op_dec == 5'b11110 || op_dec == 5'b11111) ? ans_ex :  8'b0000_0000;
						
	assign data_out_buff  = (op_dec == 5'b10111 ) ? A : data_out;	// Assigning the data buffer to be scanned at the next posedge
	
	// Carry flag
	assign flag_ex[0] = (op_dec == 5'b00000 || op_dec == 5'b01000 || op_dec == 5'b00001 || op_dec == 5'b01001) ? tmp1 : (op_dec[4:2] == 3'b111) ? flagtmp[0] : 1'b0 ;
	// Zero flag
	assign flag_ex[1] = (op_dec == 5'b10000 || op_dec == 5'b10001 || op_dec == 5'b10100 || op_dec == 5'b10101 || op_dec == 5'b10111 || op_dec == 5'b11000) ? 1'b0 : (op_dec[4:2] == 3'b111) ? flagtmp[1] : &(~ans_tmp);												
	// Overflow flag
	assign flag_ex[2] = (op_dec == 5'b00000 || op_dec == 5'b01000 || op_dec == 5'b00001 || op_dec == 5'b01001) ? tmp2 : (op_dec[4:2] == 3'b111) ? flagtmp[2] : 1'b0 ;	
	// Parity flag
	assign flag_ex[3] = (op_dec == 5'b10000 || op_dec == 5'b10001 || op_dec == 5'b10100 || op_dec == 5'b10101 || op_dec == 5'b10111 || op_dec == 5'b11000) ? 1'b0 : (op_dec[4:2] == 3'b111) ? flagtmp[3] : (^ans_tmp);												 

	always@(posedge clk)
	begin
		flagtmp <= flag_ex;
	end
endmodule
