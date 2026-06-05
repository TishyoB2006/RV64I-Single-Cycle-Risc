//Main Datapath of the CPU CORE
module OverallDatapath(
       input clk,reset,
       input [31:0] Instruction,
       input BranchEQ,BranchNEQ,RegWrite,ALUSrc,MemtoReg,
       input [3:0] alucs,   //From Top Control Unit
       input cpu_shutdown_button,
       input [63:0] ReadData,  //Comes from Data Memory
       
       output [63:0] ProgCounter,
       output Zero,
       output [63:0] WriteData,ALUResult); //This is of Data Memory
       wire [63:0] PCnext,IMMExt;
       wire [63:0] Result;
       wire [63:0] A,B; //
        PC PC(
           .clk(clk),
           .reset(reset),
           .PCNext(PCnext),
           .PC(ProgCounter));   //o
        PC_InputController PC_InputController(
                          .PC_previous(ProgCounter),
                          .ImmExt(IMMExt),
                          .BranchEQ(BranchEQ),
                          .BranchNEQ(BranchNEQ),
                          .Zero(Zero),
                          .PC_next(PCnext));  //o
        RegisterFile RegisterFile(
                     .clk(clk),
                     .RegWrite(RegWrite),
                     .ra1(Instruction[19:15]),
                     .ra2(Instruction[24:20]),
                     .wa(Instruction[11:7]),
                     .wd(Result),
                     .rd1(A),  //A input of ALU
                     .rd2(WriteData));
        ImmGen ImmGen(
                     .instruction(Instruction),
                     .Immediate_SgnExt(IMMExt));
        ALU_mux ALU_mux(
                .ALUSrc(ALUSrc),
                .IMMEXT(IMMExt),
                .RD2(WriteData),    //Basically the second output of register file which is same as WriteData of Data Memory
                .B(B));
        ALU ALU(
            .a(A),
            .b(B),
            .cpu_shutdown_button(cpu_shutdown_button),
            .alucs(alucs),
            .c(ALUResult),
            .z(Zero));
        Output_MUX Output_MUX(
                   .ALU_op(ALUResult),
                   .Data_mem_op(ReadData),
                   .MemtoReg(MemtoReg),
                   .result(Result));
endmodule
