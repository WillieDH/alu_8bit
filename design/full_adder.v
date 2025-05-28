`timescale 1ns / 1ps

module full_adder(
    input   wire    A,
    input   wire    B,
    input   wire    Cin,
    output  wire    Sum,
    output  wire    Cout
    );
    
    wire s1, c1, c2; //internal half-adder results
    
    half_adder i0 (.A(A), .B(B), .Sum(s1), .Carry(c1));
    half_adder i1 (.A(s1), .B(Cin), .Sum(Sum), .Carry(c2));
    
    assign Cout = c1 | c2;

endmodule