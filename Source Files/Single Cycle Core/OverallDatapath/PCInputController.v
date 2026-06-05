//This decides the next instruction to be input to the prgram counter
module PC_InputController(PC_previous,ImmExt,BranchEQ,BranchNEQ,Zero,PC_next);
       input [63:0] PC_previous;   //THIS IS BASICALLY THE OUTPUT OF THE PC AT THE PREV STATE
       input [63:0] ImmExt;        // Extracted from ImmGenerator block
       input BranchEQ,BranchNEQ,Zero;          //Extracted from MAIN CONTROL UNIT and ALU respectively
       output [63:0] PC_next;
       
       wire PC_src;
       assign PC_src =(BranchEQ &  Zero) | (BranchNEQ & ~Zero);  //Control signal for MUX generated
       assign PC_next = (PC_src)? (PC_previous + (ImmExt)):(PC_previous + 64'd4);
endmodule
