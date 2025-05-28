class my_driver extends uvm_driver #(my_transaction);
    `uvm_component_utils(my_driver)

    function new(string name = "my_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new

    virtual my_if vif;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual my_if)::get(this, "", "my_if", vif))
            `uvm_fatal("DRV", "Could not get virtual interface vif")
    endfunction : build_phase

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            my_transaction tx;
            `uvm_info("DRV", $sformatf("Wait for Item from Sequencer"), UVM_LOW)
            seq_item_port.get_next_item(tx);
            `uvm_info("DRV", $sformatf("Recieved Item from Sequencer"), UVM_LOW)
            drive_item(tx);
            seq_item_port.item_done();
        end
    endtask : run_phase
    
    virtual task drive_item(my_transaction tx);
        @(posedge vif.clk);
            vif.A = tx.A;
            vif.B = tx.B;
            vif.OP = tx.OP;
            `uvm_info("DRV", $sformatf("Driving A = %0b B = %0b Operation = %0b", tx.A, tx.B, tx.OP), UVM_LOW)
    endtask : drive_item
endclass : my_driver