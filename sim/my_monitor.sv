class my_monitor extends uvm_monitor;
	`uvm_component_utils(my_monitor)
	
	function new(string name = "my_monitor", uvm_component parent = null);
		super.new(name, parent);
	endfunction : new
	
	uvm_analysis_port#(my_transaction) mon_analysis_port;
	virtual my_if vif;
	//semaphore sema4; // not needed
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if (!uvm_config_db#(virtual my_if)::get(this, "", "my_if", vif))
			`uvm_fatal("MONITOR", "Could not get vif")
		mon_analysis_port = new("mon_analysis_port", this);
	endfunction : build_phase
	
	virtual task run_phase(uvm_phase phase);
		super.run_phase(phase);
		forever begin
			@(posedge vif.clk) begin
			    my_transaction tx;
			    tx = my_transaction::type_id::create("tx", this); //create container seq item
			    #1;
				tx.A = vif.A;
				tx.B = vif.B;
                tx.OP = vif.OP;
				`uvm_info(get_type_name(), $sformatf("Monitor found packet in Interface %s", tx.convert2str()), UVM_LOW)
				#20;
				mon_analysis_port.write(tx); //broadcast it to any components that's listening
				end
		end
	endtask : run_phase
endclass : my_monitor