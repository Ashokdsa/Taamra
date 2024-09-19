`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.09.2024 14:53:13
// Design Name: 
// Module Name: mem_tb
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

module mem_tb();
reg [3:0]address;
reg write;
reg read;
reg clk;
reg rst;
reg [7:0]datain;
wire [7:0]dataout;

    mem UUT (.addr(address),.wr(write),.rd(read),.clk(clk),.rst(rst),.Datain(datain),.Dataout(dataout));
    
    initial
    begin
    clk=0;
        forever
        begin
        #5 clk=~clk;
        end
    end
    initial
    begin 
        rst=1;
        write=0;
        read=0;
        #20
        rst=0;
        write=1;
        #20
        address=0;
        datain=8'b10101010;
        #20
        compare(write,read,rst,address,datain,dataout);
        address=1;
        datain=8'b00000000;
        #20
        compare(write,read,rst,address,datain,dataout);
        address=2;
        datain=8'b10000000;
        #20
        compare(write,read,rst,address,datain,dataout);
        address=3;
        datain=8'b00000001;
        #20
        compare(write,read,rst,address,datain,dataout);
        address=4;
        datain=8'b10010000;
        #20
        compare(write,read,rst,address,datain,dataout);
        address=5;
        datain=8'b01010101;
        #20
        compare(write,read,rst,address,datain,dataout);
        address=6;
        datain=8'b11111111;
        #20
        compare(write,read,rst,address,datain,dataout);
        address=7;
        datain=8'b10000010;
        #20
        compare(write,read,rst,address,datain,dataout);
        address=8;
        datain=8'b11100111;
        #20
        compare(write,read,rst,address,datain,dataout);
        read=1;
        address=3;
        datain=8'b11100111;
        #20
        compare(write,read,rst,address,datain,dataout);
        address=4;
        datain=8'b11100111;
        #20
        compare(write,read,rst,address,datain,dataout);
        write=0;
        address=1;
        datain=8'b11100111;
        #20
        compare(write,read,rst,address,datain,dataout);
        address=9;
        $display("%d|\nA=_\n|%d|\n|%d|\n|%d|\n|%d|\n|%d|\n|%d|\n|%d|\n|%d|\n|%d|\n|%d|\n|%d|\n_",
        $time,UUT.A[0],UUT.A[1],UUT.A[2],UUT.A[3],UUT.A[4],UUT.A[5],UUT.A[6],UUT.A[7],UUT.A[8],UUT.A[9],UUT.A[10]);
        #20 
        compare(write,read,rst,address,datain,dataout);
        #10 $finish;
    end
    task compare(input write,read,rst,
                input[3:0]address,
                input[7:0]datain,dataout);
    reg [7:0] out;
    begin
        if(rst) 
        begin
            #2;
        end
        else if(write&&read)
        begin
            out=8'bz;
            #2;
        end
        else if(write)
        begin
            if(UUT.A[address]==datain)
            begin
                $display("%d|\nSuccessfully entered data: %d at address: %d",$time,datain,address);
                #1;
            end
            else
            begin
                $display("%d|\nFailed to enter data: %d at address: %d",$time,datain,address);
                #1;
            end
            #2;
        end
        else if(read)
        begin
            out=UUT.A[address];
            if(out==dataout)
            begin
                $display("%d|\nRead value:%d is verfied from memory address:%d",$time,dataout,address);
                #1;
            end
            else
            begin
                $display("%d|\nOutput:%d is not matching with the value at memory address:%d",$time,dataout,UUT.A[address]);
                #1;
            end
            #2;
        end
        #2;
    end
    endtask
endmodule