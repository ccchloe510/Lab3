//This module is managed by Guanxi Lu
module PCSrcE_decode(
    input logic         ZeroE, 
    input logic         BranchE,
    input logic         JumpE,
    input logic [2:0]   funct3E,
    output logic        PCSrcE
); 

always_comb begin 
    if (JumpE == 1) 
        PCSrcE = 1;
    else if (BranchE == 1 && ZeroE == 1 && funct3E == {3'b000}) 
        PCSrcE = 1;
    else if (BranchE == 1 && ZeroE == 0 && funct3E == {3'b001}) 
        PCSrcE = 1;
    else 
        PCSrcE = 0;
end

// assign PCSrcE = JumpE | (BranchE & ZeroE);

endmodule
