`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:37:12 09/23/2017 
// Design Name: 
// Module Name:    Dependency_Check_Block 
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
module Dependency_Check_Block(imm, RW_dm, op_dec, mux_sel_A, mux_sel_B, imm_sel, mem_en_ex, mem_rw_ex, mem_mux_sel_dm, ins, clk, reset);

//////////////////////////////////////////////////Declarations/////////////////////////////////////////////////////////////////////////////////
	input [23:0] ins;
	input clk, reset;
	output reg [7:0] imm;
	output reg [4:0] RW_dm, op_dec;
	output [1:0] mux_sel_A, mux_sel_B;
	output imm_sel, mem_en_ex, mem_rw_ex, mem_mux_sel_dm;
	wire [4:0] op_dec_rst;
	wire JMP, Cond_J;
	wire [18:0] nJCL, flag, ins_tmp;
	wire mask;
	wire [4:0] RA, RB, RW;
	wire imm_flag, LD_flag, ST_flag, mem_rw;
	reg [4:0] RA_dec, RB_dec, RW_dec, RW_ex, RW_wb;
	reg LD1, LD_dec, mem_rw_dec, mem_mux_sel_ex, ST_dec, imm_sel, mem_rw_ex, mem_en_ex, mem_mux_sel_dm;
	wire LD1_rst, imm_flag_rst, LD_dec_rst, ST_dec_rst, mem_rw_dec_rst, mem_rw_ex_rst, mem_mux_sel_ex_rst, mem_en_ex_rst, mem_mux_sel_dm_rst;
	wire [4:0] RA_rst, RB_rst, RW_rst, RW_dec_rst, RW_ex_rst, RW_dm_rst;
	wire [7:0] imm_rst;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////Combinational Logic////////////////////////////////////////////////////////////////////////////////	
	assign JMP = ins[23] & ins[22] & ~ins[21] & ~ins[20] & ~ins[19];	// Checking opcode of JMP
	assign Cond_J = ins[23] & ins[22] & ins[21]; // Checking opcode of Conditional Jump
	assign mask = ~(JMP | Cond_J | LD1); // Checking if the opcode does not correspond to JMP, Cond_J or LD1
	assign nJCL = {mask, mask, mask, mask, mask, mask, mask, mask, mask, mask, mask, mask, mask, mask, mask, mask, mask, mask, mask};
	//assign flag = ins[18:0] & nJCL; // Masking the read and write operand addresses
	
	assign ins_tmp = ins[18:0] & nJCL;
	assign RW = ins_tmp[18:14];	// RW (Write/Destination)
	assign RA = ins_tmp[13:9]; // RA (Operand A's Register)
	assign RB = ins_tmp[8:4]; // RB (Operand B's Register)
	
	// Encoding based on priority
	assign mux_sel_A = (RA_dec == RW_ex) ? 2'b01 : (RA_dec == RW_dm) ? 2'b10 : (RA_dec == RW_wb) ? 2'b11 : 2'b00;
	assign mux_sel_B = (RB_dec == RW_ex) ? 2'b01 : (RB_dec == RW_dm) ? 2'b10 : (RB_dec == RW_wb) ? 2'b11 : 2'b00;
	
	// Checking opcode for imm
	assign imm_flag = ~ins[23] & ins[22];
	
//	assign mem_rw = ins[19];
	assign LD_flag = ins[23] & ~ins[22] & ins[21] & ~ins[20] & ~ins[19];	// Load opcode
	assign ST_flag = ins[23] & ~ins[22] & ins[21] & ~ins[20] & ins[19]; // Store opcode
	
	// If reset is 0, all the values to be scanned at the next positive clock edge are set to 0
	assign LD1_rst = (reset == 1'b0) ? 1'b0 : ins[23] & ~ins[22] & ins[21] & ~ins[20] & ~ins[19] & ~LD1;
	assign RA_rst = (reset == 1'b0) ? 5'b0_0000 : RA;
	assign RB_rst = (reset == 1'b0) ? 5'b0_0000 : RB;
	assign RW_rst = (reset == 1'b0) ? 5'b0_0000 : RW;
	assign RW_dec_rst = (reset == 1'b0) ? 5'b0_0000 : RW_dec;
	assign RW_ex_rst = (reset == 1'b0) ? 5'b0_0000 : RW_ex;
	assign RW_dm_rst = (reset == 1'b0) ? 5'b0_0000 : RW_dm;
	assign imm_flag_rst = (reset == 1'b0) ? 1'b0 : imm_flag;
	assign imm_rst = (reset == 1'b0) ? 8'b0000_0000 : ins[8:1];
	assign LD_dec_rst = (reset == 1'b0) ? 1'b0 : LD_flag & ~LD_dec;
	assign ST_dec_rst = (reset == 1'b0) ? 1'b0 : ST_flag;
	assign op_dec_rst = (reset == 1'b0) ? 5'b0_0000 : ins[23:19];
	assign mem_rw_dec_rst = (reset == 1'b0) ? 1'b0 : ins[19];
	assign mem_rw_ex_rst = (reset == 1'b0) ? 1'b0 : mem_rw_dec;
	assign mem_mux_sel_ex_rst = (reset == 1'b0) ? 1'b0 : ~mem_rw_dec & (LD_dec | ST_dec);
	assign mem_en_ex_rst = (reset == 1'b0) ? 1'b0 : LD_dec | ST_dec;
	assign mem_mux_sel_dm_rst = (reset == 1'b0) ? 1'b0 : mem_mux_sel_ex;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////Sequential Logic///////////////////////////////////////////////////////////////////////////////////////////////
	always @ (posedge clk) // Scanning all values at the next positive clock edge, with reset already taken into account
	begin
		op_dec <= op_dec_rst;
		LD1 <= LD1_rst;
		RA_dec <= RA_rst;
		RB_dec <= RB_rst;
		RW_dec <= RW_rst;
		RW_ex <= RW_dec_rst;
		RW_dm <= RW_ex_rst;
		RW_wb <= RW_dm_rst;
		imm_sel <= imm_flag_rst;
		imm <= imm_rst;
		LD_dec <= LD_dec_rst;
		ST_dec <= ST_dec_rst;
		mem_rw_dec <= mem_rw_dec_rst;
		mem_rw_ex <= mem_rw_ex_rst;
		mem_mux_sel_ex <= mem_mux_sel_ex_rst;
		mem_en_ex <= mem_en_ex_rst;
		mem_mux_sel_dm <= mem_mux_sel_dm_rst;
		
	end
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
endmodule
