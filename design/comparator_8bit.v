`timescale 1ns / 1ps

module comparator_8bit(
    input wire [7:0] A,
    input wire [7:0] B,
    input wire [1:0] op,
    input wire S,
    output wire result
    );
//temp values for comparisons
    wire equalTo;
    wire greaterThan;
    wire lessThan;
    wire sgreaterThan;
    wire slessThan;
    
    assign equalTo = (A == B);
    assign greaterThan = (A > B);
    assign lessThan = (A <  B);
    
    assign sgreaterThan = (A[7] & ~B[7]) ? 1'b0 :
    ((~A[7] & B[7]) ? 1'b1 :
    (greaterThan));
    
    assign slessThan = (A[7] & ~B[7]) ? 1'b1 :
    ((~A[7] & B[7]) ? 1'b0 :
    (lessThan));
    
    assign result = (S) ? 
    (op == 2'b00 ? equalTo : op == 2'b01 ? sgreaterThan : slessThan) :
    (op == 2'b00 ? equalTo : op == 2'b01 ? greaterThan : lessThan) ;
endmodule

