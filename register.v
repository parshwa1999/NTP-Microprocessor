`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:07:37 08/05/2017 
// Design Name: 
// Module Name:    register 
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
module register(
    output reg [7:0] ans_ex,
    output reg [7:0] data_out,
    output reg [7:0] DM_data,
    input [7:0] ans_tmp,
    input [7:0] data_out_buff,
    input [7:0] B,
    input clk,
    input reset
    );
	 
	 wire [7:0] temp1, temp2, temp3;
	 
	 assign temp1 = (reset) ? ans_tmp : 8'b0000_0000;			// Value of ans_tmp to be scanned at the next clk edge
	 assign temp2 = (reset) ? data_out_buff : 8'b0000_0000;	// Value of data_out_buff to be scanned at the next clk edge
	 assign temp3 = (reset) ? B : 8'b0000_0000;					// Value of data_out_buff to be scanned at the next clk edge
	 
	 always @ (posedge clk)												// Scanning values at next positive edge
	 begin
		ans_ex <= temp1;
		data_out <= temp2;
		DM_data <= temp3; 
	 end

endmodule
