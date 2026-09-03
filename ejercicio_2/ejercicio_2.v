//Descripción a nivel de compuertas de un circuito combinacional básico
//Salida = (A & B) | C
module ejercicio_2(iEntrada,oY);
input [2:0] iEntrada;
output oY;
wire E0,E1,E2;
wire [2:0] E;
assign E = ~iEntrada;
wire X;
and g1(X,E[0],E[1]);
or g2(oY,X,E[2]);
endmodule