// ==========================================
// MÓDULO PRINCIPAL
// ==========================================
module ejercicio_12(
    input [3:0] iEntrada,         // 4 switches de entrada
    output [6:0] oDisplay1,       // Display para los valores 0 y 9
    output [6:0] oDisplay2,       // Display para valores 7 y 8
    output [6:0] oDisplay3,       // Display para valores 5 y 6
    output [6:0] oDisplay4,       // Display para valores 3 y 4
    output [6:0] oDisplay5,       // Display para valores 1 y 2
    output [6:0] oDisplay6,       // Display exclusivo para Error ('E')
    output [3:0] oLEDs_Gray       // Salida independiente para los LEDs en Código Gray
);

    wire [15:0] wDeco16;          // Líneas activas del decodificador 4 a 16
    wire [3:0] wApagado = 4'hF;   // Código interno para apagar el display
    
    // Datos enrutados por los demultiplexores hacia cada display
    wire [3:0] d1, d2, d3, d4, d5, d6;

    // 1. MÓDULO INDEPENDIENTE: Código Gray directo hacia los LEDs
    my_gray_converter IC_Gray (
        .iBinario(iEntrada),
        .oGray(oLEDs_Gray)
    );

    // 2. BLOQUE DECODIFICADOR: De 4 bits a 16 líneas individuales (0 al 15)
    my_decoder_4to16 IC_Decoder (
        .iBin(iEntrada),
        .oDeco(wDeco16)
    );

    // 3. BLOQUES DEMULTIPLEXORES (Agrupados por parejas para cada display)
    
    // DEMUX para Display 5 (Activo cuando la entrada es 1 o 2)
    my_demux_par demux5 (
        .iVal(iEntrada),
        .sel1(wDeco16[1]), 
        .sel2(wDeco16[2]), 
        .oDato(d5)
    );

    // DEMUX para Display 4 (Activo cuando la entrada es 3 o 4)
    my_demux_par demux4 (
        .iVal(iEntrada),
        .sel1(wDeco16[3]), 
        .sel2(wDeco16[4]), 
        .oDato(d4)
    );

    // DEMUX para Display 3 (Activo cuando la entrada es 5 o 6)
    my_demux_par demux3 (
        .iVal(iEntrada),
        .sel1(wDeco16[5]), 
        .sel2(wDeco16[6]), 
        .oDato(d3)
    );

    // DEMUX para Display 2 (Activo cuando la entrada es 7 o 8)
    my_demux_par demux2 (
        .iVal(iEntrada),
        .sel1(wDeco16[7]), 
        .sel2(wDeco16[8]), 
        .oDato(d2)
    );

    // DEMUX para Display 1 (Activo cuando la entrada es 0 o 9)
    my_demux_par demux1 (
        .iVal(iEntrada),
        .sel1(wDeco16[0]),  
        .sel2(wDeco16[9]),  
        .oDato(d1)
    );

    // DEMUX / Control para Display 6 (Error: valores del 10 al 15 muestran 'E')
    wire wErrorActive = wDeco16[10] | wDeco16[11] | wDeco16[12] | wDeco16[13] | wDeco16[14] | wDeco16[15];
    assign d6 = wErrorActive ? 4'hE : wApagado;


    // 4. BANCO DE DECODIFICADORES DE 7 SEGMENTOS
    mydeco_display7 deco_disp1 (.Seg(oDisplay1), .A(d1));
    mydeco_display7 deco_disp2 (.Seg(oDisplay2), .A(d2));
    mydeco_display7 deco_disp3 (.Seg(oDisplay3), .A(d3));
    mydeco_display7 deco_disp4 (.Seg(oDisplay4), .A(d4));
    mydeco_display7 deco_disp5 (.Seg(oDisplay5), .A(d5));
    mydeco_display7 deco_disp6 (.Seg(oDisplay6), .A(d6));

endmodule


// ==========================================
// SUBMÓDULO: DECODIFICADOR DE 4 A 16 LÍNEAS
// ==========================================
module my_decoder_4to16(iBin, oDeco);
    input [3:0] iBin;
    output reg [15:0] oDeco;
    
    always @(*) begin
        oDeco = 16'b0;
        oDeco[iBin] = 1'b1; 
    end
endmodule


// ==========================================
// SUBMÓDULO: DEMULTIPLEXOR PARA PARES DE VALORES
// ==========================================
module my_demux_par(iVal, sel1, sel2, oDato);
    input [3:0] iVal;
    input sel1, sel2;
    output [3:0] oDato;
    
    assign oDato = (sel1 | sel2) ? iVal : 4'hF;
endmodule


// ==========================================
// SUBMÓDULO: CONVERSOR DE BINARIO A CÓDIGO GRAY (LEDs)
// ==========================================
module my_gray_converter(iBinario, oGray);
    input [3:0] iBinario;
    output [3:0] oGray;

    assign oGray[3] = iBinario[3];
    assign oGray[2] = iBinario[3] ^ iBinario[2];
    assign oGray[1] = iBinario[2] ^ iBinario[1];
    assign oGray[0] = iBinario[1] ^ iBinario[0];
endmodule


// ==========================================
// SUBMÓDULO: DECODIFICADOR DE 7 SEGMENTOS
// ==========================================
module mydeco_display7(Seg, A);
    input [3:0] A;
    output reg [6:0] Seg;
    
    always @*
    case (A) 
        4'b0000 : Seg <= 7'b1000000; // 0: Muestra el dígito 0 en el Display 1
        4'b0001 : Seg <= 7'b1111001; // 1
        4'b0010 : Seg <= 7'b0100100; // 2
        4'b0011 : Seg <= 7'b0110000; // 3
        4'b0100 : Seg <= 7'b0011001; // 4
        4'b0101 : Seg <= 7'b0010010; // 5
        4'b0110 : Seg <= 7'b0000010; // 6
        4'b0111 : Seg <= 7'b1111000; // 7
        4'b1000 : Seg <= 7'b0000000; // 8
        4'b1001 : Seg <= 7'b0011000; // 9
        4'b1110 : Seg <= 7'b0000110; // Letra 'E'
        default : Seg <= 7'b1111111; // Apagado por defecto (4'hF)
    endcase
endmodule