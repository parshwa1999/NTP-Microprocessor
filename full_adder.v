`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:38:43 03/10/2017 
// Design Name: 
// Module Name:    full_adder 
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

module Full_adder(
	output sum,
	output carryout,
	input x,
	input y,
	input carryin
	);
	
	assign sum = carryin^(x^y);						// Sum = carry input ^ operand1 ^ operand2
	assign carryout = ((x^y)&carryin) | (x&y);	// CarryOut = ( (operand1 ^ operand2) & carry input ) OR (operand1 & operand2)

endmodule
