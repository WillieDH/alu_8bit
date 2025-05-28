class my_agent extends uvm_agent;
	`uvm_component_utils(my_agent)
	
	function new(string name = "my_agent", uvm_component parent = null); 
		super.new(name, parent);
	endfunction : new
	
	my_driver drv; // driver handle
	my_monitor mon; // monitor handle
	uvm_sequencer#(my_transaction) seqr; //seqr handle
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		//use factory to build sequencer, driver, and monitor
		seqr = uvm_sequencer#(my_transaction)::type_id::create("seqr", this);
		drv = my_driver::type_id::create("drv", this);
		mon = my_monitor::type_id::create("mon", this);
	endfunction : build_phase
	
	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		drv.seq_item_port.connect(seqr.seq_item_export);
	endfunction : connect_phase
 endclass : my_agent