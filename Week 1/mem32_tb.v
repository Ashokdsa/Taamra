`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.09.2024 10:15:26
// Design Name: 
// Module Name: mem32_tb
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


module mem32_tb;

    reg clk;
    reg rst;
    reg wr;
    reg rd;
    reg [3:0] addr;
    reg [31:0] Datain;
    wire [7:0] Dataout;
    wire busy;

    reg [31:0] read_data;  // To store the full 32-bit read data
    integer i;  // Iterator for loop

    // Instantiate the memory module
    mem32 UUT (
        .clk(clk),
        .rst(rst),
        .wr(wr),
        .rd(rd),
        .addr(addr),
        .Datain(Datain),
        .Dataout(Dataout),
        .busy(busy)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10ns clock period
    end

    // Stimulus
    initial begin
        // Reset the memory
        rst = 1;
        wr = 0;
        rd = 0;
        addr = 4'b0000;
        Datain = 32'b0;
        #10 rst = 0;  // Release reset after 20ns

        // Write 32-bit data to memory using iteration (addresses 0, 4, 8, 12)
        wr = 1;
        for (i = 0; i < 4; i = i + 1) begin
            #10
            addr = i * 4;  // Write to address 0, 4, 8, 12
            Datain = {8'hA1 + i, 8'hB2 + i, 8'hC3 + i, 8'hD4 + i};  // Different 32-bit values
            wait (!busy);
        end
        // Switch to read mode and read from memory using iteration (addresses 0, 4, 8, 12)
        #5
        addr=4'bx;
        wr = 0;
        rd = 1;
        for (i = 0; i < 4; i = i + 1) begin
            #10
            addr = i * 4;  // Read from address 0, 4, 8, 12
            read_32bit(addr,Dataout);  // Read 32-bit data
            wait(!busy);
        end
        $display("%d|\nA=_\n|%d|\n|%d|\n|%d|\n|%d|\n|%d|\n|%d|\n|%d|\n|%d|\n|%d|\n|%d|\n|%d|\n_",
                $time,UUT.A[0],UUT.A[1],UUT.A[2],UUT.A[3],UUT.A[4],UUT.A[5],UUT.A[6],UUT.A[7],UUT.A[8],UUT.A[9],UUT.A[10]);
        // End of test
        $finish;
    end

    // Task to perform 32-bit read using concatenation and iteration
    task read_32bit(input reg [3:0] addr,input reg [7:0]Dataout);
        reg [31:0]a;
        begin
            read_data = 32'b0;  // Clear previous data
            // Concatenate the 8-bit outputs over 4 clock cycles using iteration
            read_data=UUT.A[addr];
            read_data=UUT.A[addr+1];
            read_data=UUT.A[addr+2];
            read_data=UUT.A[addr+3];
            $display("Read 32-bit data from addr %h: %h", addr, read_data);
        end
    endtask

    // Monitor signals
    initial begin
        $monitor("Time=%0t | clk=%b | rst=%b | wr=%b | rd=%b | addr=%h | Datain=%h | Dataout=%h | busy=%b", 
                 $time, clk, rst, wr, rd, addr, Datain, Dataout, busy);
    end
endmodule

