`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:38:54 09/01/2017 
// Design Name: 
// Module Name:    Stall_Control_Block 
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
module Stall_Control_Block(
    output reg Stall_pm,
    output Stall,
    input [23:0] ins,
    input clk,
    input reset
    );

///////////////////////////////////////////////////////////////////////////////////Declarations/////////////////////////////////////////////////////////////////////////////////////////////////
	wire jump_temp1, jump_temp3, ld_temp1;
	wire jump, ld, hlt, Stall_temp;
	wire [4:0] ins_temp;	// Temporary reg for storing the instruction
	reg jump_temp2, jump_temp4, ld_temp2;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////Combinational Block/////////////////////////////////////////////////////////////////////////////////////////////
	assign ins_temp = ins[23:19];
	assign jump = ins_temp[4] & ins_temp[3] & ins_temp[2] & ~jump_temp4;
	assign ld = ins_temp[4] & ~ins_temp[3] & ins_temp[2] & ~ins_temp[1] & ~ins_temp[0] & ~ld_temp2;
	assign hlt = ins_temp[4] & ~ins_temp[3] & ~ins_temp[2] & ~ins_temp[1] & ins_temp[0];
	
	assign Stall = jump | ld | hlt; // Stall

	assign jump_temp1 = reset ?  jump : 1'b0;	// Temporary value of jump 1 to be scanned at next clock edge
	assign ld_temp1 = reset ?  ld : 1'b0;	// Temporary value of ld to be scanned at next clock edge
	assign jump_temp3 = reset ?  jump_temp2 : 1'b0;	// Temporary value of jump 3 to be scanned at next clock edge
	assign Stall_temp = reset ? Stall : 1'b0;	// Temporary value of Stall to be scanned at next clock edge
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////Sequential Block///////////////////////////////////////////////////////////////////////////////////
	always @(posedge clk)
	begin
		jump_temp2 <= jump_temp1;	// Scanning at next clock edge
		jump_temp4 <= jump_temp3;	// Scanning at next clock edge
		ld_temp2 <= ld_temp1;	// Scanning at next clock edge
		Stall_pm <= Stall_temp;	// Scanning at next clock edge
	end
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

endmodule
