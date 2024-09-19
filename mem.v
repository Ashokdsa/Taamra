`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.09.2024 14:52:59
// Design Name: 
// Module Name: mem
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

module mem(clk, rst, wr, rd, addr, Datain, Dataout);

  input clk, rst, wr, rd;
  input [3:0] addr;
  input [7:0] Datain;
  output reg [7:0] Dataout;

  reg [7:0] A [0:10]; // 11 x 8-bit memory

  always @(posedge clk) begin
    if (rst) 
    begin
      Dataout = 8'bz; // Initialize output on reset
    end 
    else 
    begin
      case ({wr, rd})
        2'b10 : A[addr] = Datain;     // Write operation
        2'b01 : Dataout = A[addr];    // Read operation
        default: Dataout = 8'bz;        // High impedance for other cases
      endcase 
    end
  end
endmodule
