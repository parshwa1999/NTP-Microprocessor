`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:34:18 09/08/2017 
// Design Name: 
// Module Name:    Jump_Control_Block 
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
module Jump_Control_Block(
    output [7:0] jmp_loc,
    output pc_mux_sel,
    input [23:0] ins,
    input [7:0] Current_Address,
    input [3:0] flag_ex,
    input interrupt,
    input clk,
    input reset
    );

//////////////////////////////////////////////////////////Declarations/////////////////////////////////////////////////////////////////////////////////////////////////////////////
	wire JC, JNC, JZ, JNZ, JMP, RET;
	wire [7:0] Current_Address_temp1, Current_Address_temp2;
	reg [7:0] Current_Address_temp3;
	reg interrupt_temp1, interrupt_temp2;
	wire [3:0] flag_ex_temp1, flag_ex_temp3;
	reg [3:0] flag_ex_temp2;
	wire [7:0] jmp_loc_temp;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////Combinational logic///////////////////////////////////////////////////////////////////
	// Check the opcode in ins[23:19]
	assign JC = ~ins[19] & ~ins[20] & ins[21] & ins[22] & ins[23];
	assign JZ = ~ins[19] & ins[20] & ins[21] & ins[22] & ins[23];
	assign JNC = ins[19] & ~ins[20] & ins[21] & ins[22] & ins[23];
	assign JNZ = ins[19] & ins[20] & ins[21] & ins[22] & ins[23];
	assign JMP = ~ins[19] &  ~ins[20] & ~ins[21] & ins[22] & ins[23];
	assign RET = ~ins[19] & ~ins[20] & ~ins[21] & ~ins[22] & ins[23];
	
	assign Current_Address_temp1 = Current_Address + 1'b1;	// Incrementing the address by 1
	assign Current_Address_temp2 = (interrupt == 1'b0) ? Current_Address_temp3 : Current_Address_temp1;	// If interrput is set, passing incremented address

	assign jmp_loc_temp = (interrupt_temp1 == 1'b0) ? ins[7:0] : 8'hf0;	// Assigning jump location aa hexadecimal F0 if interrupt is set
	assign jmp_loc = (RET == 1'b1) ? Current_Address_temp3 : jmp_loc_temp;	// Current Address to be scanned at next clock edge is being assigned here
	assign flag_ex_temp1 = (interrupt_temp2 == 1'b1) ? flag_ex : flag_ex_temp2; // Temporary value of flag

	assign flag_ex_temp3 = (RET == 1'b1) ? flag_ex_temp2 : flag_ex; // Assigning value at next clock edge
	// PC Mux select line
	assign pc_mux_sel = (JC & flag_ex_temp3[0]) | (~flag_ex_temp3[0] & JNC) | (JZ & flag_ex_temp3[1]) | (JNZ & ~flag_ex_temp3[1]) | JMP | RET | interrupt_temp1;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
/////////////////////////////////////////////////////Sequential logic///////////////////////////////////////////////////////////////////////
	always @ (posedge clk)
	begin
		Current_Address_temp3 <= Current_Address_temp2;	// Scanning current address at next clock edge
		interrupt_temp1 <= interrupt; // Scanning interrupt at next clock edge
		interrupt_temp2 <= interrupt_temp1; // Scanning interrupt at next clock edge
		flag_ex_temp2 <= flag_ex_temp1; // Scanning flag at next clock edge
	end
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

endmodule
