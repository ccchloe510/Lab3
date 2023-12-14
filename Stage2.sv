module Stage2#(
    parameter DATA_WIDTH = 32
)(
    input logic                     clk,
    input logic                     clr,
    // control input
    input logic                     RegWriteD,
    input logic[1:0]                ResultSrcD,
    input logic                     MemWriteD,
    input logic                     JumpD,
    input logic                     BranchD,
    input logic [2:0]                    ALUControlD,
    input logic                     ALUSrcAD,
    input logic                     ALUSrcBD,
    input logic                     LdSrcD, 
    input logic                     StSrcD, 
    input logic                     JalSrcD,
    // regfile input 
    input logic[DATA_WIDTH-1:0]     RD1,
    input logic[DATA_WIDTH-1:0]     RD2,
    //
    input logic[4:0]                RdD,
    // extend input
    input logic[DATA_WIDTH-1:0]     ImmExtD,
    //PC input
    input logic[DATA_WIDTH-1:0]     PCD,
    input logic[DATA_WIDTH-1:0]     PC_PlusD,
    // forward
    input logic[4:0]                Rs1D,
    input logic[4:0]                Rs2D,

    // control output 
    output logic                    RegWriteE,
    output logic[1:0]               ResultSrcE,
    output logic                    MemWriteE,
    output logic                    JumpE,
    output logic                    BranchE,
    output logic [2:0]                   ALUControlE,
    output logic                    ALUSrcAE,
    output logic                    ALUSrcBE,
    output logic                    LdSrcE, 
    output logic                    StSrcE, 
    output logic                    JalSrcE,
    // regfile output 
    output logic[DATA_WIDTH-1:0]     RD1E,
    output logic[DATA_WIDTH-1:0]     RD2E,
    //rd
    output logic[4:0]                RdE,
    // extend output
    output logic[DATA_WIDTH-1:0]     ImmExtE,
    //PC output
    output logic[DATA_WIDTH-1:0]     PCE,
    output logic[DATA_WIDTH-1:0]     PC_PlusE,

    //function3
    input logic[2:0]                funct3,
    output logic[2:0]               funct3E,

    //output
    output logic[4:0]                Rs1E,
    output logic[4:0]                Rs2E

);

always_ff @(posedge clk) begin
    if (clr) begin
        // Clear all registers when clr is active
        RegWriteE <= 0;
        ResultSrcE <= 0;
        MemWriteE <= 0;
        JumpE <= 0;
        BranchE <= 0;
        ALUControlE <= 0;
        ALUSrcAE <= 0;
        ALUSrcBE <= 0;
        LdSrcE <= 0;
        StSrcE <= 0;
        JalSrcE <= 0;
        RD1E <= 0;
        RD2E <= 0;
        RdE <= 0;
        ImmExtE <= 0;
        PCE <= 0;
        PC_PlusE <= 0;
        Rs1E <= 0;
        Rs2E <= 0;
        funct3E<=0;
    end 
    else begin
        //control
        RegWriteE <= RegWriteD;
        ResultSrcE <= ResultSrcD;
        MemWriteE <= MemWriteD;
        JumpE <= JumpD;
        BranchE <= BranchD;
        ALUControlE <= ALUControlD;
        ALUSrcAE <= ALUSrcAD;
        ALUSrcBE <= ALUSrcBD;
        LdSrcE <= LdSrcD;
        StSrcE <= StSrcD;
        JalSrcE <= JalSrcD;
        //regfile
        RD1E <= RD1;
        RD2E<= RD2;
        //rd
        RdE <= RdD;
        //extend
        ImmExtE <= ImmExtD;
        //PC
        PCE <= PCD;
        PC_PlusE <= PC_PlusD;
        //forward
        Rs1E <= Rs1D;
        Rs2E <= Rs2D;

        funct3E<=funct3;
    end

end
    
endmodule
