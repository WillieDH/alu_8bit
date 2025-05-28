`timescale 1ns / 1ps

module alu_8bit(
    input wire [7:0] A, B,     
    input wire [5:0] OP,
    output reg [15:0] resultF
    );
//Internal output wires
    wire [7:0] logicOut;
    wire [7:0] shiftOut;
    wire cmpOut;
    wire [9:0] adderOut;
    wire [15:0] multOut;
//Instantiating all my ALU modules
//Adder
    //OP[0] 0 is unsigned | 1 is signed
    //OP[1] 0 is add | 1 is sub
    adder_8bit addM(.A(A), .B(B), .Cin(OP[1]), .Add_mode(OP[0]), .Sum(adderOut[7:0]), .Cout(adderOut[8]), .v_flag(adderOut[9]));
//Multiplier
    //OP[0] 0 is unsigned | 1 is signed
    multiplier_8bit multM(.A(A), .B(B), .multMode(OP[0]), .P(multOut));
    
//Shifter
    //OP[0] 0 is left | 1 is right
    //OP[1] 0 is logical | 1 is arithmetic
    //OP[2] 0 is rotate off | 1 is rotate on
    shifter_8bit shiftM(.i(A), .lr(OP[0]), .la(OP[1]), .rot(OP[2]), .result(shiftOut));
     
//Logic
    //OP[1:0] 00 and | 01 or | 10 xor | 11 not
    logic_8bit logicM( .A(A), .B(B), .op(OP[1:0]), .Y(logicOut));
    
//Comparator
    //OP[1:0] 00 == | 01 > | 10 and 11 < |
    //OP[2] 0 is unsigned | 1 is signed
    comparator_8bit compM( .A(A), .B(B), .op(OP[1:0]), .S(OP[2]), .result(cmpOut));
    
    always @(*) begin
        case (OP[5:3])
            3'b000: resultF = {6'b0, adderOut};
            3'b001: resultF = multOut;
            3'b010: resultF = {8'b0, shiftOut};
            3'b011: resultF = {8'b0, logicOut};
            3'b100: resultF = {15'b0, cmpOut};
            default: resultF = 16'b0;
        endcase
    end
endmodule
