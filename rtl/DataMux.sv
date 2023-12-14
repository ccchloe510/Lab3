module DataMux (
    input logic [1:0]   ResultSrcW,     // 2-bit selector
    input logic [31:0]  ALUResultW,     // ALU ResultW
    input logic [31:0]  ReadDataW,      // Data memory read data
    input logic [31:0]  PC_PlusW,       // PC + 4
    output logic [31:0] ResultW         // Output ResultW
);

    always_comb begin
        case (ResultSrcW)
            2'b00: ResultW = ALUResultW; 
            2'b01: ResultW = ReadDataW;        
            2'b10: ResultW = PC_PlusW;     
            default: ResultW = 32'b0;   
        endcase
    end
endmodule
