class my_subscriber extends uvm_subscriber #(my_transaction);
    `uvm_component_utils(my_subscriber)
    
    function new(string name = "my_subscriber", uvm_component parent = null);
        super.new(name, parent);
        cov_trans = new();
    endfunction : new
    
    //declare my covergroup
    covergroup cov_trans @(posedge clk);
        option.per_instance = 1;
        A_cp: coverpoint tx.A {
            bins A_low = { [0:84] };
            bins A_mid = { [85:169] };
            bins A_high = { [170:255] };
        }
        B_cp: coverpoint tx.B {
            bins B_low = { [0:84] };
            bins B_mid = { [85:169] };
            bins B_high = { [170:255] };
        }
        add_cp: coverpoint tx.OP {
            bins uadd = { 6'b000000 };
            bins sadd = { 6'b000001 };
            bins usub = { 6'b000010 };
            bins ssub = { 6'b000011 };
        }
        mult_cp: coverpoint tx.OP {
            bins umult = { 6'b001000 };
            bins smult = { 6'b001001 };
        }
        shift_cp: coverpoint tx.OP {
            bins ll = { 6'b010000 };
            bins lr = { 6'b010001 };
            bins ar = { 6'b010011 };
            bins rol = { 6'b010100 };
            bins ror = { 6'b010101 };
        }
        comp_cp: coverpoint tx.OP {
            bins et = { 6'b100000 };
            bins gt = { 6'b100001 };
            bins lt = { 6'b100010 };
            bins sgt = { 6'b100101 };
            bins slt = { 6'b100110 };
        }
        logic_cp: coverpoint tx.OP {
            bins Land = { 6'b011000 };
            bins Lor = { 6'b011001 };
            bins Lxor = { 6'b011010 };
            bins Lnot = { 6'b011011 };
        }
        A_B_Cross: cross A_cp, B_cp;
    endgroup
    
    my_transaction tx;
    logic clk;
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction : build_phase
    
    virtual function void write(my_transaction t);
        tx = t;
        cov_trans.sample();
        `uvm_info("COV", $sformatf("Sampled A = %0d B = %0d", tx.A, tx.B), UVM_LOW)
        `uvm_info("COV", $sformatf("Coverage A = %0.2f %%, Coverage B = %0.2f %% Adder/Subtractor Module Operation coverage = %0.2f %% Multiplier Module Operation coverage = %0.2f %% Shifter Module Operation coverage = %0.2f %% Comparator Module Operation coverage = %0.2f %% Logic Module Operation coverage = %0.2f %% Overall Coverage = %0.2f %% ", cov_trans.A_cp.get_inst_coverage(), cov_trans.B_cp.get_inst_coverage(), cov_trans.add_cp.get_inst_coverage(), cov_trans.mult_cp.get_inst_coverage(), cov_trans.shift_cp.get_inst_coverage(), cov_trans.comp_cp.get_inst_coverage(), cov_trans.logic_cp.get_inst_coverage(), cov_trans.get_inst_coverage()), UVM_LOW)
    endfunction : write
endclass : my_subscriber