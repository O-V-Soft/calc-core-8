module ram_chip (
    input wire clk,
    input wire we,
    input wire [7:0] addr,
    input wire [7:0] data_in,
    output wire [7:0] data_out
);
    reg [7:0] memory [0:63];

    assign data_out = memory[addr[5:0]];

    always @(posedge clk) begin
        if (we)
            memory[addr[5:0]] <= data_in;
    end
endmodule
