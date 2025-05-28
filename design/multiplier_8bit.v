`timescale 1ns / 1ps

module multiplier_8bit(
    input wire [7:0] A,
    input wire [7:0]  B,
    input wire multMode,
    output wire [15:0]  P
    );
// unsigned/signed temp wires
    wire [15:0] tempProduct;
    wire [7:0] tempA, tempB;
    wire [15:0] stempProduct;
// handle signed bits if signed mode
    assign tempA = (multMode && A[7]) ? ((A ^ {8{multMode}}) + 1) : (A);
    assign tempB = (multMode && B[7]) ? ((B ^ {8{multMode}}) + 1) : (B);
// multiplication
    assign tempProduct = tempA * tempB;
// negative if - * + or + * -
    assign stempProduct = ( A[7] ^ B[7] ) ? ( (( tempProduct ^ {16{multMode}}) + 1) ) : tempProduct; ///xor bitflip Bits ^ bits{1}
// mode select unsigned/signed
    assign P = (multMode) ? (stempProduct) : (tempProduct); //0 unsigned, 1 signed
endmodule
