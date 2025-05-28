`timescale 1ns / 1ps

module adder_8bit(
    input   wire    [7:0]   A, B,
    input   wire    Cin,
    input   wire    Add_mode,
    output  wire    [7:0] Sum,
    output  wire    Cout,
    output  wire     v_flag
    );
    wire c0, c1, c2, c3, c4, c5, c6, v_flag_addition, v_flag_subtraction; //internal wires for carryouts
    wire    [7:0]   B_actual; // actual value of A based on sub control bit and the control bit itself
    //instantiate full-adders
    full_adder i0 (.A(A[0]), .B(B_actual[0]), .Cin(Cin), .Sum(Sum[0]), .Cout(c0));
    full_adder i1 (.A(A[1]), .B(B_actual[1]), .Cin(c0), .Sum(Sum[1]), .Cout(c1));
    full_adder i2 (.A(A[2]), .B(B_actual[2]), .Cin(c1), .Sum(Sum[2]), .Cout(c2));
    full_adder i3 (.A(A[3]), .B(B_actual[3]), .Cin(c2), .Sum(Sum[3]), .Cout(c3));
    full_adder i4 (.A(A[4]), .B(B_actual[4]), .Cin(c3), .Sum(Sum[4]), .Cout(c4));
    full_adder i5 (.A(A[5]), .B(B_actual[5]), .Cin(c4), .Sum(Sum[5]), .Cout(c5));
    full_adder i6 (.A(A[6]), .B(B_actual[6]), .Cin(c5), .Sum(Sum[6]), .Cout(c6));
    full_adder i7 (.A(A[7]), .B(B_actual[7]), .Cin(c6), .Sum(Sum[7]), .Cout(Cout));
    //unsigned addition overflow is carryout bit / signed addition overflow if + + = - or - - = +
    assign v_flag_addition = (Add_mode) ? ( (A[7] == B_actual[7] ) && ( Sum[7] != A[7]) ) : Cout;
    assign v_flag_subtraction = (Add_mode) ? ( (A[7] == B_actual[7] ) && ( Sum[7] != A[7]) ) : ~Cout;
    assign v_flag = (Cin) ? v_flag_subtraction : v_flag_addition;
    //subtract when Cin = 1 (A + ~B + 1) 
    assign B_actual = B ^ {8{Cin}}; 
endmodule
