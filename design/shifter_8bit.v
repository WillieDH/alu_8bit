`timescale 1ns / 1ps

module shifter_8bit(
    input wire [7:0] i,
    input wire lr,
    input wire la,
    input wire rot,
    output wire [7:0] result
    );
//shifter temp values
    wire [7:0] lleftTemp;
    wire [7:0] lrightTemp;
    wire [7:0] arightTemp;
    wire [7:0] rolTemp;
    wire [7:0] rorTemp;
//logical shifters
    assign lleftTemp = {i[6:0], 1'b0}; //logical and arithmetic left are identical
    assign lrightTemp = {1'b0, i[7:1]};
//arithmetic shifters
    assign arightTemp = {i[7], i[7:1]};
//rotations
    assign rolTemp = {i[6:0], i[7]};
    assign rorTemp = {i[0], i[7:1]};
//TernOp to choose type and direction
    assign result = (rot)? //0 for no rotation 1 for rotations
    ((lr)? //0 for left, 1 for right
    (rorTemp):
    (rolTemp)):
    ((lr)? 
    ( (la) ? (arightTemp) : (lrightTemp) ): //0 for logical 1 for arithmetic
    ( lleftTemp )); //lr 0 is the same regardless of shifttype
endmodule