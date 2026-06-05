module Output_MUX(Data_mem_op,ALU_op,MemtoReg,result);
      input [63:0] Data_mem_op,ALU_op;  //ALU and Data Memory outputs are fed to MUX
      input MemtoReg;  //This signal from main control unit acts as a select line for the MUX
      output [63:0] result;
      assign result = (MemtoReg)?Data_mem_op:ALU_op;
endmodule
