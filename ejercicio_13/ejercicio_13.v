// ============================================================
// ALU de 5 bits
// ============================================================

// Módulo principal
module ejercicio_13(
    input [4:0] iA,
    input [4:0] iB,
    input [3:0] iKeys,
    output [4:0] oLEDs_Res,
    output oLED_Carry,
    output [6:0] o7segD,
    output [6:0] o7segU
);

    wire [4:0] wResultado;   
    wire wCarryOut;          
    wire [3:0] wBCD_Decenas; 
    wire [3:0] wBCD_Unidades;
    reg [2:0] wSel;          

    // Decodificar los botones (activos en bajo) ordenados según la secuencia
    always @(*) begin
        casex (~iKeys) 
            4'b0001: wSel = 3'd0; // Key 0 -> Item 5: F = A + B' + 1
            4'b0010: wSel = 3'd1; // Key 1 -> Item 9: F = B'
            4'b0100: wSel = 3'd2; // Key 2 -> Item 4: F = A - B[cite: 3, 4]
            4'b1000: wSel = 3'd3; // Key 3 -> Item B: F = A(+)B (XOR)[cite: 3, 4]
            default: wSel = 3'd4; // Ningún botón -> Item F: F = (A = B)[cite: 3, 4]
        endcase
    end

    // Llamado al core de mi alu
    my_alu_core u_core (
        .iA(iA),
        .iB(iB),
        .iSel(wSel),
        .oResultado(wResultado),
        .oCarry(wCarryOut)
    );

    // Salidas a los leds
    assign oLEDs_Res = wResultado;
    assign oLED_Carry = wCarryOut;

    // Bloque para pasar a bcd
    my_bin_to_bcd u_bin2bcd (
        .iBinario(wResultado),
        .oDecenas(wBCD_Decenas),
        .oUnidades(wBCD_Unidades)
    );

    // Conexión para los displays de 7 segmentos
    my_deco_7seg u_deco_decenas (
        .iBCD(wBCD_Decenas),
        .oSegmentos(o7segD)
    );
    
    my_deco_7seg u_deco_unidades (
        .iBCD(wBCD_Unidades),
        .oSegmentos(o7segU)
    );

endmodule


// ============================================================
// Submódulo: Core de la ALU
// ============================================================
module my_alu_core(
    input [4:0] iA,
    input [4:0] iB,
    input [2:0] iSel,
    output reg [4:0] oResultado,
    output reg oCarry
);

    wire [5:0] wRest;
    wire [4:0] wB_invertido;
    wire [4:0] wXor;
    wire [4:0] wCompEq;
    
    assign wB_invertido = ~iB; 
    assign wRest = {1'b0, iA} + {1'b0, wB_invertido} + 1'b1;
    assign wXor = iA ^ iB;                               // Item B: A(+)B (XOR)[cite: 3, 4]
    assign wCompEq = (iA == iB) ? 5'd1 : 5'd0;             // Item F: F = (A = B)[cite: 3, 4]

    always @(*) begin
        oResultado = 5'b0;
        oCarry = 1'b0;
        
        case (iSel)
            3'd0 : begin // Item 5 (Key 0): A + B' + 1[cite: 3, 4]
                oResultado = wRest[4:0];
                oCarry = wRest[5];
            end
            3'd1 : begin // Item 9 (Key 1): B'[cite: 3, 4]
                oResultado = wB_invertido;
                oCarry = 1'b0;
            end
            3'd2 : begin // Item 4 (Key 2): A - B[cite: 3, 4]
                oResultado = wRest[4:0];
                oCarry = wRest[5];
            end
            3'd3 : begin // Item B (Key 3): A(+)B (XOR)[cite: 3, 4]
                oResultado = wXor;
                oCarry = 1'b0;
            end
            3'd4 : begin // Item F (Por defecto): (A = B)[cite: 3, 4]
                oResultado = wCompEq;
                oCarry = 1'b0;
            end
            default : begin
                oResultado = 5'b0;
                oCarry = 1'b0;
            end
        endcase
    end
endmodule


// ============================================================
// Submódulo: Conversor Binario a BCD
// ============================================================
module my_bin_to_bcd(
    input [4:0] iBinario,
    output reg [3:0] oDecenas,
    output reg [3:0] oUnidades
);
    always @(*) begin
        if (iBinario >= 30) begin
            oDecenas = 4'd3;
            oUnidades = iBinario - 30;
        end else if (iBinario >= 20) begin
            oDecenas = 4'd2;
            oUnidades = iBinario - 20;
        end else if (iBinario >= 10) begin
            oDecenas = 4'd1;
            oUnidades = iBinario - 10;
        end else begin
            oDecenas = 4'd0;
            oUnidades = iBinario[3:0];
        end
    end
endmodule


// ============================================================
// Submódulo: Decodificador de 7 segmentos
// ============================================================
module my_deco_7seg(
    input [3:0] iBCD,
    output reg [6:0] oSegmentos
);
    always @*
    case (iBCD)
        4'b0000 : oSegmentos = 7'b1000000; // 0
        4'b0001 : oSegmentos = 7'b1111001; // 1
        4'b0010 : oSegmentos = 7'b0100100; // 2
        4'b0011 : oSegmentos = 7'b0110000; // 3
        4'b0100 : oSegmentos = 7'b0011001; // 4
        4'b0101 : oSegmentos = 7'b0010010; // 5
        4'b0110 : oSegmentos = 7'b0000010; // 6
        4'b0111 : oSegmentos = 7'b1111000; // 7
        4'b1000 : oSegmentos = 7'b0000000; // 8
        4'b1001 : oSegmentos = 7'b0010000; // 9
        default : oSegmentos = 7'b1111111; // apagao
    endcase
endmodule