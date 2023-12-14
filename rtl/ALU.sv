module ALU(
    input logic [31:0]      PCE,
    input logic [31:0]      SrcA0E, 
    input logic [31:0]      SrcB0E, 
    input logic [31:0]      ImmExtE,
    input logic [2:0]       ALUControlE,
    input logic             ALUSrcAE,
    input logic             ALUSrcBE,
    
    output logic [31:0]     ALUResult,     
    output logic            ZeroE
);

logic [31:0]      SrcAE;
logic [31:0]      SrcBE;

assign SrcAE = ALUSrcAE ? PCE : SrcA0E;
assign SrcBE = ALUSrcBE ? ImmExtE : SrcB0E;


always_comb begin
    
    ALUResult = 32'b0;
    ZeroE = 1'b0;

    if (ALUControlE == 3'b000) begin 
        ALUResult = SrcAE + SrcBE;      //add
    end
    
    if (ALUControlE == 3'b001) begin
        ALUResult = SrcAE - SrcBE ;     //subtract
    end

    if (ALUControlE == 3'b010) begin 
        ALUResult = SrcAE & SrcBE;      //and
    end

    if (ALUControlE == 3'b011) begin 
        ALUResult = SrcAE | SrcBE;      //or
    end

    if (ALUControlE == 3'b100) begin 
        ALUResult = SrcAE >> SrcBE[4:0];//shift right
    end

    if (ALUControlE == 3'b101) begin 
        ALUResult = SrcAE ^ SrcBE;      //xor
    end
    
    if (ALUControlE == 3'b110) begin 
        ALUResult = SrcBE;              //select SrcBE
    end

    if (ALUControlE == 3'b111) begin 
        ALUResult = SrcAE << SrcBE[4:0];//shift left
    end

    ZeroE = (ALUResult == 32'b0);
end

endmodule
