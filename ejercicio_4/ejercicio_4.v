//Descripción de un multiplexor 2 a 1 usando buffer de 3 estados
module ejercicio_4(iA, iB, iSelector, oSalida);
input iA, iB, iSelector;
output tri oSalida; // Declaración correcta de salida tipo tri-estado

// Se añadió un nombre de instancia (b1 y b2) obligatorio para primitivas en Quartus
bufif1 b1 (oSalida, iA, iSelector);
bufif0 b2 (oSalida, iB, iSelector);
endmodule