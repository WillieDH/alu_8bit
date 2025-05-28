`timescale 1ns / 1ps
import uvm_pkg::*;
import my_pkg::*;

interface my_if(input logic clk);
	logic	[7:0]	A;
	logic	[7:0]	B;
    logic   [5:0]   OP;
    logic   [15:0]  resultF;
	// logic	[7:0]	Sum;
	// logic			Cin, Add_mode, Cout, v_flag;
endinterface : my_if

module tb_top();
//clk signal 
logic clk = 0;
initial forever #20 clk = ~clk;

my_if vif_inst(clk);

virtual my_if vif;

alu_8bit DUT(.A(vif_inst.A), .B(vif_inst.B), .OP(vif_inst.OP), .resultF(vif_inst.resultF));
initial begin
    vif = vif_inst;
    uvm_config_db#(virtual my_if)::set(null, "*", "my_if", vif);
    
    run_test("my_test");
    $finish;
end
endmodule
