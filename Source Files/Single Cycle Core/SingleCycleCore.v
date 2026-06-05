//This is the main core of the CPU
module CPU_core(
       input clk,reset,cpu_shutdown_button,
       input [31:0] Instruction,
       input [63:0] ReadData,    //Comes from Data Memory
       
       output [63:0] ProgramCounter,
       output [63:0] ALUResult,WriteData,
       output MemWrite,MemRead,
       output wire Zero);
       
       wire BranchEQ,BranchNEQ,RegWrite,ALUSrc,MemtoReg;
       wire [3:0] alucs;
       
       Top_Control_Unit Top_Control_Unit(
                        .opcode(Instruction[6:0]),
                        .funct3(Instruction[14:12]),
                        .funct7_30(Instruction[30]),
                        .BranchEQ(BranchEQ),
                        .BranchNEQ(BranchNEQ),
                        .MemRead(MemRead),
                        .MemWrite(MemWrite),
                        .MemtoReg(MemtoReg),
                        .RegWrite(RegWrite),
                        .ALUSrc(ALUSrc),
                        .alucs(alucs));
       
       OverallDatapath OverallDatapath(
                       .clk(clk),
                       .reset(reset),
                       .cpu_shutdown_button(cpu_shutdown_button),
                       .Instruction(Instruction),
                       .BranchEQ(BranchEQ),
                       .BranchNEQ(BranchNEQ), 
                       .MemtoReg(MemtoReg),
                       .RegWrite(RegWrite),
                       .ALUSrc(ALUSrc),
                       .alucs(alucs),
                       .ReadData(ReadData),
                       .ProgCounter(ProgramCounter),
                       .WriteData(WriteData),
                       .ALUResult(ALUResult),
                       .Zero(Zero));
endmodule
