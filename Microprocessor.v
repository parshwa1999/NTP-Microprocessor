`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:28:17 09/24/2017 
// Design Name: 
// Module Name:    Microprocessor 
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
module Microprocessor(
    input [7:0] data_in,
    input clk,
    input interrupt,
    input reset,
    output [7:0] data_out/*,
	 output [23:0] ins,
    output [7:0] A,
    output [7:0] B,
    output [7:0] Current_Address,
    output [7:0] ans_ex,
    output [7:0] ans_dm,
	 output [7:0] ans_wb,
	output [1:0] mux_sel_A,
	output [1:0] mux_sel_B,
	output imm_sel*/
   );
  
	 wire [23:0] ins;
    wire [7:0] A;
    wire [7:0] B;
    wire [7:0] Current_Address;
    wire [7:0] ans_ex;
    wire [7:0] ans_dm;
	 wire [7:0] ans_wb;
	wire [1:0] mux_sel_A;
	wire [1:0] mux_sel_B;
	wire imm_sel  ;

wire [7:0] DM_data, imm, jmp_loc;
wire mem_rw_ex, mem_en_ex, mem_mux_sel_dm, pc_mux_sel, Stall, Stall_pm;
wire [4:0] RW_dm, op_dec;
wire [3:0] flag_ex;

Data_Memory_Block Data_Memory_Block1(ans_dm, ans_ex, DM_data, mem_rw_ex, mem_en_ex, mem_mux_sel_dm, reset, clk);
Dependency_Check_Block Dependency_Check_Block1(imm, RW_dm, op_dec, mux_sel_A, mux_sel_B, imm_sel, mem_en_ex, mem_rw_ex, mem_mux_sel_dm, ins, clk, reset);
execution_block Execution_block1(ans_ex, DM_data, data_out, flag_ex, A, B, data_in, op_dec, clk, reset);
Jump_Control_Block Jump_Control_Block1(jmp_loc, pc_mux_sel, ins, Current_Address, flag_ex, interrupt, clk, reset);
PCIM PCIM1(ins, Current_Address, jmp_loc, pc_mux_sel, Stall, Stall_pm, reset, clk);
Register_Bank_Block Register_Bank_Block1(A, B, ins, ans_ex, ans_dm, ans_wb, imm, RW_dm, mux_sel_A, mux_sel_B, imm_sel, clk);
Stall_Control_Block Stall_Control_Block1(Stall_pm, Stall, ins, clk, reset);
Write_Back_Block Write_Back_Block1(ans_wb, ans_dm, clk, reset);

endmodule
