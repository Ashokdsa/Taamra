`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.09.2024 12:25:40
// Design Name: 
// Module Name: alu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module alu(
    input [31:0] a,  
    input [31:0] b,  
    input cin,        
    input [3:0] sel,  
    output reg cout, 
    output reg flag,
    output reg [31:0] sum,mult
);

always @(*)
begin
    mult=32'bz;
    sum = 32'bz;
    case (sel)
        4'b0000: {cout, sum} = a + b + cin;      
        4'b0001: {flag, sum} = a - b - cin;      
        4'b0010: sum = a & b;                    
        4'b0011: sum = a | b;                    
        4'b0100: sum = a ^ b;                    
        4'b0101: sum = ~(a | b);                
        4'b0110: sum = a << 1;                  
        4'b0111: sum = a >> 1;                  
        4'b1000: {mult,sum} = a * b;                    
        default: {mult,sum} = 64'bz;                 
    endcase
end

endmodule

