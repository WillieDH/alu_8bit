`timescale 1ns / 1ps
module logic_8bit(
    input wire [7:0] A,
    input wire [7:0] B,
    input wire [1:0] op,
    output wire [7:0] Y
    );
    wire [7:0] and_out, or_out, xor_out, not_out;
    
    //operations
    assign and_out = A & B;
    assign or_out = A | B;
    assign xor_out = A ^ B;
    assign not_out = ~A;
    
    //mux output
    assign Y = (op == 2'b00) ? and_out : (op == 2'b01) ? or_out : (op == 2'b10) ? xor_out : (op == 2'b11) ? not_out : 8'b00000000;
endmodule

