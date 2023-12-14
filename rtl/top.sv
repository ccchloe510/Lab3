module top(
    input logic             clk, 
    input logic             rst,
    input logic[31:0]       trigger, 
    output logic [31:0]     a0
);

    logic               PCSrcE;
    logic [31:0]        PC_PlusF; 
    logic [31:0]        PC_PlusD; 
    logic [31:0]        PC_PlusE; 
    logic [31:0]        PC_PlusM; 
    logic [31:0]        PC_PlusW; 
    logic [31:0]        ImmExtD;
    logic [31:0]        ImmExtE; 

    logic [31:0]        PCF; 
    logic [31:0]        PCD; 
    logic [31:0]        PCE; 

    logic [31:0]        InstrD;
    
    logic [6:0]         opcode;
    logic [2:0]         funct3;
    logic [2:0]         funct3E;
    logic               func75;
    
    logic               ZeroE;
    
    logic [1:0]         ResultSrcD;
    logic [1:0]         ResultSrcE;
    logic [1:0]         ResultSrcM;
    logic [1:0]         ResultSrcW;
    
    logic               MemWriteD;
    logic               MemWriteE;
    logic               MemWriteM;

    logic               ALUSrcAD;
    logic               ALUSrcBD;
    logic               ALUSrcAE;
    logic               ALUSrcBE;

    logic [2:0]         ImmSrcD;

    logic               RegWriteD;
    logic               RegWriteE;
    logic               RegWriteM;
    logic               RegWriteW;

    logic [2:0]         ALUControlD;
    logic [2:0]         ALUControlE;
    
    logic               LdSrcD;  
    logic               StSrcD;
    logic               JalSrcD;
    logic               LdSrcE;  
    logic               StSrcE;
    logic               JalSrcE;
    logic               LdSrcM;  
    logic               StSrcM;

    logic [11:0]        A;
    logic [4:0]         A1;
    logic [4:0]         A2;

    logic [31:0]        RDi;
    logic [31:0]        RD;
    logic [31:0]        RD1;
    logic [31:0]        RD1E;

    logic [31:0]        RD2;
    logic [31:0]        RD2E;
    logic [31:0]        ResultW;

    logic [31:0]        WriteDataM;
    logic [31:0]        ReadDataW;
    logic [24:0]        Imm;

    logic [31:0]        ALUResult;
    logic [31:0]        ALUResultM;
    logic [31:0]        ALUResultW;
    logic               JumpD;
    logic               JumpE;
    logic               BranchD;
    logic               BranchE;

    logic[4:0]          RdD;
    logic[4:0]          RdE;
    logic[4:0]          RdM;
    logic[4:0]          RdW;
    //forward
    logic[4:0]          Rs1D;
    logic[4:0]          Rs2D;
    logic[4:0]          Rs1E;
    logic[4:0]          Rs2E;
    // stall
    logic               StallD;
    logic               StallF;
    //flush
    logic               FlushE;
    logic               FlushD;
    logic[31:0]          SrcA0E;
    logic[31:0]          SrcB0E;
    


PC my_pc(
    .clk(clk),
    .rst(rst),
    .en(StallF),
    // input
    .PCSrcE(PCSrcE),
    .JalSrcE(JalSrcE),
    .ImmExtE(ImmExtE),
    .PCE(PCE),
    .RD1E(RD1E),
    //output
    .PC_PlusF(PC_PlusF),
    .PCF(PCF)

);

Instruction my_InstrD_mem(
    .A(A),
    .RDi(RDi)
);

Stage1 Stage1(
    .clk(clk),
    .en(StallD),
    .clr(FlushD),
    
    .RDi(RDi),
    .PCF(PCF),
    .PC_PlusF(PC_PlusF),

    .InstrD(InstrD),
    .PCD(PCD),
    .PC_PlusD(PC_PlusD)
);

ControlUnit my_control_unit(
    .opcode(opcode),
    .funct3(funct3),
    .func75(func75),
    //outputs
    .ResultSrcD(ResultSrcD),
    .MemWriteD(MemWriteD),
    .ALUControlD(ALUControlD),
    .ALUSrcAD(ALUSrcAD),
    .ALUSrcBD(ALUSrcBD),
    .ImmSrcD(ImmSrcD),
    .RegWriteD(RegWriteD),
    .JumpD(JumpD),
    .BranchD(BranchD),
    .LdSrcD(LdSrcD),
    .StSrcD(StSrcD),
    .JalSrcD(JalSrcD)
);

RegFile my_reg_file(
    .clk(clk),
    .A1(A1),
    .A2(A2),
    .A3(RdW),
    .WD3(ResultW),
    .WE3(RegWriteW),
    .RD1(RD1),
    .RD2(RD2),

    .a0(a0),
    .trigger(trigger)
);

extend my_extend(
    .ImmSrcD(ImmSrcD),
    .Imm(Imm),
    .ImmExtD(ImmExtD)
);

Stage2 Stage2(
    .clk(clk),
    .clr(FlushE),

    .RegWriteD(RegWriteD),
    .ResultSrcD(ResultSrcD),
    .MemWriteD(MemWriteD),
    .JumpD(JumpD),
    .BranchD(BranchD),
    .ALUControlD(ALUControlD),
    .ALUSrcAD(ALUSrcAD),
    .ALUSrcBD(ALUSrcBD),
    .LdSrcD(LdSrcD),
    .StSrcD(StSrcD),
    .JalSrcD(JalSrcD),
    .RD1(RD1),
    .RD2(RD2),
    .RdD(RdD),
    .ImmExtD(ImmExtD),
    .PCD(PCD),
    .PC_PlusD(PC_PlusD),
    .RegWriteE(RegWriteE),
    .ResultSrcE(ResultSrcE),
    .MemWriteE(MemWriteE),
    .JumpE(JumpE),
    .BranchE(BranchE),
    .ALUControlE(ALUControlE),
    .ALUSrcAE(ALUSrcAE),
    .ALUSrcBE(ALUSrcBE),
    .LdSrcE(LdSrcE),
    .StSrcE(StSrcE),
    .JalSrcE(JalSrcE),
    .RD1E(RD1E),
    .RD2E(RD2E),
    .RdE(RdE),
    .ImmExtE(ImmExtE),
    .PCE(PCE),
    .PC_PlusE(PC_PlusE),
    .Rs1D(Rs1D),
    .Rs2D(Rs2D),
    .Rs1E(Rs1E),
    .Rs2E(Rs2E),
    .funct3(funct3),
    .funct3E(funct3E)
);

PCSrcE_decode PCSrcE_decode(
    .ZeroE(ZeroE),
    .BranchE(BranchE),
    .JumpE(JumpE),
    .funct3E(funct3E),
    .PCSrcE(PCSrcE)
);

ALU my_alu(
    .PCE(PCE),
    .SrcA0E(SrcA0E),
    .SrcB0E(SrcB0E),
    .ImmExtE(ImmExtE),
    .ALUControlE(ALUControlE),
    .ALUSrcAE(ALUSrcAE),
    .ALUSrcBE(ALUSrcBE),
    //outputs
    .ALUResult(ALUResult), 
    .ZeroE(ZeroE)
);

Stage3 Stage3(
    .clk(clk),
    .RegWriteE(RegWriteE),
    .ResultSrcE(ResultSrcE),
    .MemWriteE(MemWriteE),
    .StSrcE(StSrcE),
    .LdSrcE(LdSrcE),
    .ALUResult(ALUResult),
    .WriteDataE(SrcB0E),
    .RdE(RdE),
    .PC_PlusE(PC_PlusE),

    .RegWriteM(RegWriteM),
    .ResultSrcM(ResultSrcM),
    .MemWriteM(MemWriteM),
    .StSrcM(StSrcM),
    .LdSrcM(LdSrcM),
    .ALUResultM(ALUResultM),
    .WriteDataM(WriteDataM),
    .RdM(RdM),
    .PC_PlusM(PC_PlusM)
);

DataMemory my_data_memory(
    .clk(clk),
    .WE(MemWriteM),
    .StSrcM(StSrcM),
    .LdSrcM(LdSrcM),
    .A(ALUResultM),
    .WD(WriteDataM),
    .RD(RD)
);

Stage4 Stage4(
    .clk(clk),
    .RegWriteM(RegWriteM),
    .ResultSrcM(ResultSrcM),
    .ALUResultM(ALUResultM),
    .RD(RD),
    .RdM(RdM),
    .PC_PlusM(PC_PlusM),
    .RegWriteW(RegWriteW),
    .ResultSrcW(ResultSrcW),
    .ALUResultW(ALUResultW),
    .ReadDataW(ReadDataW),
    .RdW(RdW),
    .PC_PlusW(PC_PlusW)
);

DataMux my_DataMux(
    .ResultSrcW(ResultSrcW),
    .ALUResultW(ALUResultW),
    .ReadDataW(ReadDataW),
    .PC_PlusW(PC_PlusW),
    .ResultW(ResultW)
);

HazardUnit my_hazardunit(
    .RD1E(RD1E),
    .RD2E(RD2E),
    .Rs1E(Rs1E),
    .Rs2E(Rs2E),
    .RdM(RdM),
    .RdW(RdW),
    .RegWriteM(RegWriteM),
    .RegWriteW(RegWriteW),
    .ResultW(ResultW),
    .ALUResultM(ALUResultM),
    .SrcA0E(SrcA0E),
    .SrcB0E(SrcB0E),
    .Rs1D(Rs1D),
    .Rs2D(Rs2D),
    .RdE(RdE),
    .ResultSrcE(ResultSrcE),
    .StallF(StallF),
    .StallD(StallD),
    .FlushE(FlushE),
    .PCSrcE(PCSrcE),
    .FlushD(FlushD)
);

// assignment for Instr_mem
assign A = PCF[11:0];
// assignment for control_unit
assign opcode = InstrD[6:0];
assign funct3 = InstrD[14:12];
assign func75 = InstrD[30];
// assignment for reg_file
assign A1 = InstrD[19:15];
assign A2 = InstrD[24:20];
// assignment for extend
assign Imm = InstrD[31:7];
assign RdD =InstrD[11:7];

//forward
assign Rs1D = InstrD[19:15];
assign Rs2D = InstrD[24:20];


endmodule
