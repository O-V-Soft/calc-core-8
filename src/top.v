module top (
    input wire clk,
    input wire rst
);
    wire [7:0] ram_addr;
    wire [7:0] ram_data_out;
    wire [7:0] ram_data_in;
    wire ram_we;

    cpu cpu_inst (
        .clk(clk),
        .rst(rst),
        .ram_addr(ram_addr),
        .ram_data_out(ram_data_out),
        .ram_data_in(ram_data_in),
        .ram_we(ram_we)
    );

    ram_chip ram_inst (
        .clk(clk),
        .we(ram_we),
        .addr(ram_addr),
        .data_in(ram_data_out),
        .data_out(ram_data_in)
    );
endmodule
