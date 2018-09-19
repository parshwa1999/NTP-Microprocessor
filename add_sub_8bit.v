`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:52:21 08/04/2017 
// Design Name: 
// Module Name:    add_sub_8bit 
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
module add_sub_8bit(
	output [7:0] S_D,
	output C_B ,
	output Overflow,
	input [7:0] A,
	input [7:0] B,
	input Operator
	);
	
	wire [7:0] Bq;		//temporary variable
	wire [6:0] Cout;
	
	assign Bq[0] = B[0] ^ Operator;
	assign Bq[1] = B[1] ^ Operator;
	assign Bq[2] = B[2] ^ Operator;
	assign Bq[3] = B[3] ^ Operator;
	assign Bq[4] = B[4] ^ Operator;
	assign Bq[5] = B[5] ^ Operator;
	assign Bq[6] = B[6] ^ Operator;
	assign Bq[7] = B[7] ^ Operator;
	
	Full_adder fb1(S_D[0], Cout[0], A[0], Bq[0], Operator);
	Full_adder fb2(S_D[1], Cout[1], A[1], Bq[1], Cout[0]);
	Full_adder fb3(S_D[2], Cout[2], A[2], Bq[2], Cout[1]);
	Full_adder fb4(S_D[3], Cout[3], A[3], Bq[3], Cout[2]);
	Full_adder fb5(S_D[4], Cout[4], A[4], Bq[4], Cout[3]);
	Full_adder fb6(S_D[5], Cout[5], A[5], Bq[5], Cout[4]);
	Full_adder fb7(S_D[6], Cout[6], A[6], Bq[6], Cout[5]);
	Full_adder fb8(S_D[7], C_B, A[7], Bq[7], Cout[6]);
	
	assign Overflow = C_B ^ Cout[6];

endmodule

