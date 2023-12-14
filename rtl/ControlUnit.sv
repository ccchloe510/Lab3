module ControlUnit (
    input logic [6:0]   opcode,
    input logic [2:0]   funct3,
    input logic         func75,
    //output
    output logic        RegWriteD,
    output logic [1:0]  ResultSrcD,
    output logic        MemWriteD,
    output logic        JumpD,
    output logic        BranchD,
    output logic [2:0]  ALUControlD,
    output logic        ALUSrcAD, 
    output logic        ALUSrcBD,
    output logic [2:0]  ImmSrcD, 
    output logic        LdSrcD, 
    output logic        StSrcD, 
    output logic        JalSrcD
);

logic [1:0]             ALUOpD;
logic [1:0]             ALUDecode;
logic                   op5;

assign op5 = opcode[5];

// main decode
always_comb begin

    case (opcode)
    7'b0110011: begin           //R-type
        BranchD = 0; 
        JumpD = 0; 
        ResultSrcD = 2'b00;
        MemWriteD = 0;
        ALUSrcAD = 0;
        ALUSrcBD = 0;
        ImmSrcD = 3'b000;
        RegWriteD = 1;
        ALUOpD = 2'b10;
        LdSrcD = 0;
        StSrcD = 0;
        JalSrcD = 0;
    end

    7'b0010011: begin           //I-type ALU
        BranchD = 0; 
        JumpD = 0; 
        ResultSrcD = 2'b00;
        MemWriteD = 0;
        ALUSrcAD = 0;
        ALUSrcBD = 1;
        ImmSrcD = 3'b000;
        RegWriteD = 1;
        ALUOpD = 2'b00;
        LdSrcD = 0;
        StSrcD = 0;
        JalSrcD = 0;
    end

    7'b0000011: begin           //I-type load
        BranchD = 0; 
        JumpD = 0; 
        ResultSrcD = 2'b01;
        MemWriteD = 0;
        ALUSrcAD = 0;
        ALUSrcBD = 1;
        ImmSrcD = 3'b000;
        RegWriteD = 1;
        ALUOpD = 2'b00;
        LdSrcD = {funct3[2]};
        StSrcD = 0;
        JalSrcD = 0;
    end

    7'b1100111: begin           //I-type JumpD
        BranchD = 0; 
        JumpD = 1; 
        ResultSrcD = 2'b10;
        MemWriteD = 0;
        ALUSrcAD = 0;
        ALUSrcBD = 1;
        ImmSrcD = 3'b000;
        RegWriteD = 1;
        ALUOpD = 2'b00;
        LdSrcD = 0;
        StSrcD = 0;
        JalSrcD = 1'b0;
    end

    7'b0100011: begin           //S-type
        BranchD = 0; 
        JumpD = 0; 
        ResultSrcD = 2'b00;
        MemWriteD = 1;
        ALUSrcAD = 0;
        ALUSrcBD = 1;
        ImmSrcD = 3'b001;
        RegWriteD = 0;
        ALUOpD = 2'b00;
        LdSrcD = 0;
        StSrcD = ~{|funct3};
        JalSrcD = 0;
    end

    7'b1100011: begin           //B-type
        BranchD = 1; 
        JumpD = 0; 
        ResultSrcD = 2'b00;
        MemWriteD = 0;
        ALUSrcAD = 0;
        ALUSrcBD = 0;
        ImmSrcD = 3'b010;
        RegWriteD = 0;
        ALUOpD = 2'b01;
        LdSrcD = 0;
        StSrcD = 0;
        JalSrcD = 1;
    end

    7'b0110111: begin           //U-type LUI
        BranchD = 0; 
        JumpD = 0; 
        ResultSrcD = 2'b00;
        MemWriteD = 0;
        ALUSrcAD = 0;
        ALUSrcBD = 1'b1;
        ImmSrcD = 3'b100;
        RegWriteD = 1;
        ALUOpD = 2'b11;
        LdSrcD = 0;
        StSrcD = 0;
        JalSrcD = 0;
    end

    7'b0010111: begin           //U-type AUIPC
        BranchD = 0; 
        JumpD = 0; 
        ResultSrcD = 2'b00;
        MemWriteD = 0;
        ALUSrcAD = 1'b1;
        ALUSrcBD = 1'b1;
        ImmSrcD = 3'b100;
        RegWriteD = 1;
        ALUOpD = 2'b11;
        LdSrcD = 0;
        StSrcD = 0;
        JalSrcD = 0;
    end

    7'b1101111: begin           //J-type
        BranchD = 0; 
        JumpD = 1; 
        ResultSrcD = 2'b10;
        MemWriteD = 0;
        ALUSrcAD = 0;
        ALUSrcBD = 0;
        ImmSrcD = 3'b011;
        RegWriteD = 1;
        ALUOpD = 2'b00;
        LdSrcD = 0;
        StSrcD = 0;
        JalSrcD = 1'b1;
    end

    default: begin
        BranchD = 0; 
        JumpD = 0; 
        ResultSrcD = 2'b00;
        MemWriteD = 0;
        ALUSrcAD = 0;
        ALUSrcBD = 0;
        ImmSrcD = 3'b000;
        RegWriteD = 0;
        ALUOpD = 2'b00;
        LdSrcD = 0;
        StSrcD = 0;
        JalSrcD = 0;
    end

    endcase

end


// ALU ALUDecode
assign ALUDecode = {op5, func75};

always_comb begin
    if (ALUOpD == 2'b00) begin                                  //I-type & S-type
        if (funct3 == 3'b001) ALUControlD = 3'b111;             //shift to left
        else if (funct3 == 3'b101) ALUControlD = 3'b100;        //shift to right
        else if (funct3 == 3'b111) ALUControlD = 3'b010;        //and
        else ALUControlD = 3'b000;                              //add
    end 
    else if (ALUOpD == 2'b01) ALUControlD = 3'b001;             //sub for B-type
    else if (ALUOpD == 2'b10) begin
        if (funct3 == 3'b000) begin
            if (ALUDecode == 2'b00) ALUControlD = 3'b000;       //add
            else if (ALUDecode == 2'b01) ALUControlD = 3'b000;  //add
            else if (ALUDecode == 2'b10) ALUControlD = 3'b000;  //add
            else  ALUControlD = 3'b001;                         //sub， ALUDecode == 2'b11
        end
        else if (funct3 == 3'b100) ALUControlD = 3'b101;        //xor
        else if (funct3 == 3'b110) ALUControlD = 3'b011;        //or
        else if (funct3 == 3'b111) ALUControlD = 3'b010;        //and
        else ALUControlD = 3'b000;
    end
    else if (ALUOpD == 2'b11) begin                             //U-type
        if (op5 == 0) ALUControlD = 3'b000;                     // add
        else  ALUControlD = 3'b110;                             // extract out SrcB, op5 == 1
    end
    else ALUControlD = 3'b000;
end


endmodule
