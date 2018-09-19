`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:48:30 08/05/2017 
// Design Name: 
// Module Name:    execution_block 
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
module execution_block(
    output [7:0] ans_ex,
    output [7:0] DM_data,
    output [7:0] data_out,
    output [3:0] flag_ex,
    input [7:0] A,
    input [7:0] B,
	 input [7:0] data_in,
    input [4:0] op_dec,
    input clk,
    input reset
    );
	
		wire [7:0] ans_tmp, data_out_buff;
		ALU ALU1(ans_tmp, data_out_buff, flag_ex, data_in, op_dec, A, B, ans_ex, data_out,clk);		// Instance of ALU module
		register register1(ans_ex, data_out, DM_data, ans_tmp, data_out_buff, B, clk, reset);	// Instance of register block

endmodule
