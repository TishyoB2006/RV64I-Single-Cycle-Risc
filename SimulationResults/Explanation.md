##EXPLANATION OF WORKING
**1.Sim1:**
   **This Runs the Assembly Code:** 
       addi x1,x0,10
       addi x2,x0,20 
       add x3,x1,x2
       sub x4,x2,x1
       and x5,x1,x2
       or x6,x1,x2
       sd x3,0(x0)
       ld x7,0(x0)
       beq x7,x3,+8
       addi x8,x0,99
   **Simulation Explanation:** 
    1.The blue waveform depicts the clock cycle.
    2.The pink waveform depicts the PC which correctly increments by 4 after each instruction and
      increments by 8 when the beq statment is encountered.
    3.The waveform just below the PC are the instructions passed to the Processor.
    4.The Dark Blue waveform is the ALU CONTROL output.
    5.The Last 7 waveforms depict the contents of the 7 registers x1 to x7
    6.Being a single cycle risc 2nd Instruction starts only after 1st Instruction is complete
    7.So,x1 = x0+10 = 10
         x2 = x0+20 = 20
         x3 = x1+x2 = 30
         x4 = x2-x1 = 10
         x5 = x1&x2(bitwise) = 0
         x6 = x1|x2(bitwise) = 30
     Now contents of x3 are stored at memory address zero and then it is loaded to x7
     So, x7 = 30
     As beq statement gets executed the last instruction is never executed as PC increments by 8.
    
