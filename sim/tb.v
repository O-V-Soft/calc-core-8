`timescale 1ns/1ps

module tb;

    reg clk;
    reg rst; 

    cpu dut(clk, rst); 

    initial begin
        clk = 0;
        forever #5 clk = ~clk;   
    end

    initial begin
        rst = 1;
        #10;
        rst = 0;

        dut.ROM[0] = 8'h40;
        dut.ROM[1] = 8'h4F; 
        dut.ROM[2] = 8'hB0;   
        dut.ROM[3] = 8'h00;   

        dut.ROM[4] = 8'h40; 
        dut.ROM[5] = 8'h4B;  
        dut.ROM[6] = 8'hB0;   
        dut.ROM[7] = 8'h01;   

        dut.ROM[8] = 8'hD0;   
        dut.ROM[9] = 8'h08;   

        $dumpfile("sim/simulation.vcd");
        $dumpvars(0, tb);

        #500 $finish;
    end

endmodule
