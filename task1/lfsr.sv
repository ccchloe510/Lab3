module lfsr(
    input logic clk,
    input logic rst,
    input logic en,
    output logic [3:0] data_out
);

    logic [3:0] sreg;
    logic sreg3_xor_sreg4;

    assign sreg3_xor_sreg4 = sreg[2] ^ sreg[3];

    always_ff @(posedge clk) begin
        if (rst) begin
            sreg <= 4'b0001;
        end else if (en) begin
            sreg <= {sreg[2:0], sreg3_xor_sreg4};
        end
    end

    assign data_out = sreg;

endmodule
