module DataMemory#(
    parameter DATA_WIDTH = 32
)(
    input  logic                  clk,          // Clock input
    input  logic                  WE,           // Write Enable signal
    input  logic                  StSrcM,       // Store Type signal
    input  logic                  LdSrcM,       // Load Type signal
    input  logic [DATA_WIDTH-1:0] A,            // Address input
    input  logic [DATA_WIDTH-1:0] WD,           // Write Data input
    output logic [DATA_WIDTH-1:0] RD            // Read Data output
);

    logic [7:0] data_array [2**17-1 : 0]; 

    initial $readmemh("noisy.mem", data_array, 17'h10000);

    always_comb begin
        if (LdSrcM) RD = {{24{1'b0}}, data_array[A]};                                   //LBU
        else RD = {data_array[A+3], data_array[A+2], data_array[A+1], data_array[A]};   //LW
    end
        
    always_ff @(posedge clk) begin
        if (WE == 1 && StSrcM == 0) begin       // SW
            data_array[A] <= WD[7:0];
            data_array[A+1] <= WD[15:8];
            data_array[A+2] <= WD[23:16];
            data_array[A+3] <= WD[31:24];
        end
        else if(WE ==1 && StSrcM ==1 ) begin
            data_array[A] <= WD[7:0];           // SB
        end
    end 

endmodule
