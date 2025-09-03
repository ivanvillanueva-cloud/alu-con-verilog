`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.09.2025 10:27:44
// Design Name: 
// Module Name: tarea2
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tarea2 (
  input  logic [2:0] seleccion,
  input  logic [3:0] A, B,
  output logic [3:0] resultado,
  output logic carry, borrow, zero, negativo, overflow
);

  logic [4:0] suma,amenosb, bmenosa;

  always_comb 
  begin
    
    suma      = {1'b0, A} + {1'b0, B};
    amenosb = {1'b0, A} + {1'b0, ~B} + 5'd1; // A - B
    bmenosa = {1'b0, B} + {1'b0, ~A} + 5'd1; // B - A

    
    resultado       = 4'b0000;
    carry    = 1'b0;
    borrow   = 1'b0;
    overflow = 1'b0;

    if (seleccion == 3'b000) 
    begin
      resultado = A;

    end
     else if (seleccion == 3'b001) begin
      resultado       = suma[3:0];
      carry    = suma[4];
      overflow = (A[3] == B[3]) && (resultado[3] != A[3]);

    end
     else if (seleccion == 3'b010) begin
      resultado       = amenosb[3:0];
      borrow   = ~amenosb[4];
      overflow = (A[3] != B[3]) && (resultado[3] != A[3]);

    end
     else if (seleccion == 3'b011) begin
      resultado       = bmenosa[3:0];
      borrow   = ~bmenosa[4];
      overflow = (B[3] != A[3]) && (resultado[3] != B[3]);

    end
     else if (seleccion == 3'b100) begin
      resultado = ~A;

    end
     else if (seleccion == 3'b101) begin
      resultado = A & B;

    end
     else if (seleccion == 3'b110) begin
      resultado = A | B;

    end
     else if (seleccion == 3'b111) begin
      resultado = A ^ B;
    end

 
    zero     = (resultado == 4'b0000);
    negativo = resultado[3]; 
  end

endmodule
