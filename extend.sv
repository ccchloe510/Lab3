module extend(
    input logic [2:0]            ImmSrcD, 
    input logic [31:7]           Imm, 
    output logic [31:0]          ImmExtD
);

always_comb 
case (ImmSrcD)
    //I-type, 12-bit signed immediate
    3'b000: ImmExtD = {{20{Imm[31]}}, Imm[31:20]}; 
    
    //S-type. 12-bit signed immediate
    3'b001: ImmExtD = {{20{Imm[31]}}, Imm[31:25], Imm[11:7]}; 
    
    //B-type, 13-bit signed immediate
    3'b010: ImmExtD = {{20{Imm[31]}}, Imm[7], Imm[30:25], Imm[11:8], 1'b0};
    
    //J-type, 21-bit signed immediate 
    3'b011: ImmExtD = {{12{Imm[31]}}, Imm[19:12], Imm[20], Imm[30:21], 1'b0}; 
    
    //U-type, fill last 12 bits with 0
    3'b100: ImmExtD = {Imm[31:12], {12{1'b0}}}; 
    
    default: ImmExtD = 0;

endcase

endmodule
