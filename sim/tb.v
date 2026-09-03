`timescale 1ns/1ps

module tb;

    reg clk;
    reg rst; 

    top dut (
        .clk(clk),
        .rst(rst)
    ); 

    initial begin
        clk = 0;
        forever #5 clk = ~clk;   
    end

    initial begin
        rst = 1;
        #10;
        rst = 0;

        dut.cpu_inst.ROM[0] = 8'h40; 
        dut.cpu_inst.ROM[1] = 8'h4F; 
        dut.cpu_inst.ROM[2] = 8'hB0; 
        dut.cpu_inst.ROM[3] = 8'h00;   

        dut.cpu_inst.ROM[4] = 8'h40; 
        dut.cpu_inst.ROM[5] = 8'h4B;  
        dut.cpu_inst.ROM[6] = 8'hB0; 
        dut.cpu_inst.ROM[7] = 8'h01;   

        dut.cpu_inst.ROM[8] = 8'hD0; 
        dut.cpu_inst.ROM[9] = 8'h08;   

        $dumpfile("sim/simulation.vcd");
        $dumpvars(0, tb);

        #500;
        
        $display("RAM[0] = %c (0x%h)", dut.ram_inst.memory[0], dut.ram_inst.memory[0]);
        $display("RAM[1] = %c (0x%h)", dut.ram_inst.memory[1], dut.ram_inst.memory[1]);

        $finish;
    end

endmodule
