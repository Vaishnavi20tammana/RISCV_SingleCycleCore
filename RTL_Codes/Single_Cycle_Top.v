`include "PC.v"
`include "Instruction_Memory.v"
`include "Register_File.v"
`include "Sign_Extend.v"
`include "ALU.v"
`include "Control_Unit_Top.v"
`include "Data_Memory.v"
`include "PC_Adder.v"
`include "Mux.v"
/*
module Single_Cycle_Top(rst,clk);

    wire [31:0] PC_Top,PC_Next_Top,RD_Top,SrcA,SrcB,ALU_Result,Read_data_top;
    wire [2:0]ALUControl_top;
    wire Regwrite_top,MemWrite_top;

    input rst,clk;

    PC PC0(.clk(clk),.rst(rst),.PC(PC_Top),.PC_Next(PC_Next_Top));

    Instruction_Memory IM0(.rst(rst),.A(PC_Top),.RD(RD_Top));

    Register_File RF0(.clk(clk),.rst(rst),.WE3(Regwrite_top),.WD3(Read_data_top),.A1(RD_Top[19:15]),.A2(),.A3(RD_Top[11:7]),.RD1(SrcA),.RD2());

    ALU ALU0(.A(SrcA),.B(SrcB),.Result(ALU_Result),.ALUControl(ALUControl_top),.OverFlow(),.Carry(),.Zero(),.Negative());
    
    Sign_Extend SE0(.In(),.Imm_Ext(),.ImmSrc());

    Data_Memory DM0(.clk(clk),.rst(rst),.WE(MemWrite_top),.WD(),.A(ALU_Result),.RD(Read_data_top));

    PC_Adder PC_Add0(.a(PC_Top),.b(32'b100),.c(PC_Next_Top));

    Control_Unit_Top CUT0(.Op(RD_Top[6:0]),.RegWrite(Regwrite_top),.ImmSrc(),.ALUSrc(),.MemWrite(MemWrite_top),.ResultSrc(),.Branch(),.funct3(RD_Top[14:12]),.funct7(RD_Top[6:0]),.ALUControl(ALUControl_top));

endmodule
*/
module Single_Cycle_Top(clk,rst);

    input clk,rst;

    wire [31:0] PC_Top,RD_Instr,RD1_Top,Imm_Ext_Top,ALUResult,ReadData,PCPlus4,RD2_Top,SrcB,Result;
    wire RegWrite,MemWrite,ALUSrc,ResultSrc;
    wire [1:0]ImmSrc;
    wire [2:0]ALUControl_Top;

    PC PC0(
        .clk(clk),
        .rst(rst),
        .PC(PC_Top),
        .PC_Next(PCPlus4)
    );

    PC_Adder PC_Adder(
                    .a(PC_Top),
                    .b(32'd4),
                    .c(PCPlus4)
    );
    
    Instruction_Memory Instruction_Memory(
                            .rst(rst),
                            .A(PC_Top),
                            .RD(RD_Instr)
    );

    Register_File Register_File(
                            .clk(clk),
                            .rst(rst),
                            .WE3(RegWrite),
                            .WD3(Result),
                            .A1(RD_Instr[19:15]),
                            .A2(RD_Instr[24:20]),
                            .A3(RD_Instr[11:7]),
                            .RD1(RD1_Top),
                            .RD2(RD2_Top)
    );

    Sign_Extend Sign_Extend(
                        .In(RD_Instr),
                        .ImmSrc(ImmSrc[0]),
                        .Imm_Ext(Imm_Ext_Top)
    );

    Mux Mux_Register_to_ALU(
                            .a(RD2_Top),
                            .b(Imm_Ext_Top),
                            .s(ALUSrc),
                            .c(SrcB)
    );

    ALU ALU(
            .A(RD1_Top),
            .B(SrcB),
            .Result(ALUResult),
            .ALUControl(ALUControl_Top),
            .OverFlow(),
            .Carry(),
            .Zero(),
            .Negative()
    );

    Control_Unit_Top Control_Unit_Top(
                            .Op(RD_Instr[6:0]),
                            .RegWrite(RegWrite),
                            .ImmSrc(ImmSrc),
                            .ALUSrc(ALUSrc),
                            .MemWrite(MemWrite),
                            .ResultSrc(ResultSrc),
                            .Branch(),
                            .funct3(RD_Instr[14:12]),
                            .funct7(RD_Instr[6:0]),
                            .ALUControl(ALUControl_Top)
    );

    Data_Memory Data_Memory(
                        .clk(clk),
                        .rst(rst),
                        .WE(MemWrite),
                        .WD(RD2_Top),
                        .A(ALUResult),
                        .RD(ReadData)
    );

    Mux Mux_DataMemory_to_Register(
                            .a(ALUResult),
                            .b(ReadData),
                            .s(ResultSrc),
                            .c(Result)
    );

endmodule