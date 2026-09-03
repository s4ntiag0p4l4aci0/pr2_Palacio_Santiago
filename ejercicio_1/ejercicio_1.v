//Descripción a nivel de compuertas del decodificador 2 a 4
module ejercicio_1(iA,iB,iE,oD);
input iA, iB, iE;
wire A, B, E;
assign A = ~iA;
assign B = ~iB;
assign E = ~iE;

output [0:3]oD;
wire Anot, Bnot, Enot;
not g1(Anot,A),
g2(Bnot,B),
g3(Enot,E);
nand g4(oD[0],Anot,Bnot,Enot),
g5(oD[1],Anot,B,Enot),
g6(oD[2],A,Bnot,Enot),
g7(oD[3],A,B,Enot);
endmodule