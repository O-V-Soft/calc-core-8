module cpu (
    input wire clk,
    input wire rst
);

    reg [7:0] PC;
    reg [7:0] A, B;
    
    reg [7:0] RAM [0:63];
    reg [7:0] ROM [0:255];

    reg [7:0] sqrt_table [0:255];
    reg [7:0] pow_table [0:255];  

    wire [3:0] opcode = ROM[PC][7:4];

    integer i, j, a, b;
    initial begin
        for (i = 0; i < 256; i = i + 1) ROM[i] = 8'h00;
        for (j = 0; j < 256; j = j + 1) sqrt_table[j] = $rtoi($floor($sqrt(j)));
        
        for (a = 0; a < 16; a = a + 1)
            for (b = 0; b < 16; b = b + 1)
                pow_table[{a[3:0], b[3:0]}] = a ** b;
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            PC <= 8'h00;
            A  <= 8'h00;
            B  <= 8'h00;
        end else begin
            case (opcode)
                4'b0000: begin A <= A; PC <= PC + 1; end
                4'b0001: begin A <= A + B; PC <= PC + 1; end
                4'b0010: begin A <= A - B; PC <= PC + 1; end
                4'b0011: begin A <= A + 1'b1; PC <= PC + 1; end
                4'b0100: begin A <= ROM[PC + 1]; PC <= PC + 2; end
                4'b0101: begin A <= A & B; PC <= PC + 1; end
                4'b0110: begin A <= A ^ B; PC <= PC + 1; end
                4'b0111: begin A <= B; B <= A; PC <= PC + 1; end   
                4'b1000: begin A <= sqrt_table[A]; PC <= PC + 1; end
                4'b1001: begin A <= pow_table[{A[3:0], B[3:0]}]; PC <= PC + 1; end
                4'b1010: begin A <= RAM[ROM[PC + 1]]; PC <= PC + 2; end
                4'b1011: begin RAM[ROM[PC + 1]] <= A; PC <= PC + 2; end
                4'b1101: begin PC <= ROM[PC + 1]; end
                default: begin PC <= PC + 1; end
            endcase
        end
    end
endmodule
