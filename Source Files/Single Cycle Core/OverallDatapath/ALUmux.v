module ALU_mux(ALUSrc,IMMEXT,RD2,B);
       input ALUSrc;
       input [63:0] IMMEXT,RD2;
       output [63:0] B;
       assign B=(ALUSrc)? IMMEXT:RD2;
endmodule
