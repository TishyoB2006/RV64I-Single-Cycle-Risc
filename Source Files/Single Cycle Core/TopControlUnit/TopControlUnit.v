//THIS IS THE TOP MOST LEVEL CONTROLLER OF THE CPU...CONSISTS OF THE ALU CONTROL AND THE MAIN CONTROL UNIT
module Top_Control_Unit(
       input [6:0] opcode,
       input [2:0] funct3,
       input funct7_30,
       
       output BranchEQ, BranchNEQ, MemRead, MemWrite, MemtoReg, RegWrite, ALUSrc,
       output [3:0] alucs
);
       
       wire [1:0] ALUOP;
       
       // Instantiation of Main Control Unit
       MainControlUnit MainControlUnit_inst(
                       .Opcode(opcode), 
                       .funct3(funct3),
                       .BranchEQ(BranchEQ),
                       .BranchNEQ(BranchNEQ),
                       .MemRead(MemRead),
                       .MemWrite(MemWrite),
                       .RegWrite(RegWrite),
                       .ALUSrc(ALUSrc),
                       .MemtoReg(MemtoReg),
                       .ALUOP(ALUOP)
       );

       // Instantiation of ALU Control
       ALU_Control ALU_Control_inst(
                  .ALUOP(ALUOP),
                  .opcode(opcode),
                  .funct3(funct3),
                  .funct7_30(funct7_30),
                  .alucs(alucs)
       );

endmodule
