`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: SJEC
// Engineer: Ashok
// 
// Create Date: 18.09.2024 11:51:34
// Design Name: ALU Test Bench
// Module Name: alu_tb
// Project Name: Taamra
// Target Devices: Simulation
// Tool Versions: Xilinx Vivado 2018
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module alu_tb();
reg [31:0]a,b;
reg cin;
wire cout;
wire[31:0]sum;
wire[31:0]mult;
reg [3:0]sel;
wire flag;
alu d1(a,b,cin,sel,cout,flag,sum,mult);
initial begin
    
    for (a=0;a<32'd4294967295;)
    begin
        a=a+1;
        #2;
        for (b=0;b<32'd4294967295;)
        begin
            b=b+1;
            #2;
            for (cin=0;cin<1'b1;)
            begin
                cin=cin+1;
                #2;
                for(sel=0;sel<8;)
                begin
                    sel=sel+1;
                    #2;
                    $display("At%dns, A =%d B =%d Cin = %d\nSel = %d Sign = %d Out = %d Mult = %d",$time,a,b,cin,sel,flag,sum,mult);
                end
            end
        end
    end
    $finish;
    
end
endmodule
