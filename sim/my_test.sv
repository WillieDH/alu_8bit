class my_test extends uvm_test;
	`uvm_component_utils(my_test)
	
	function new(string name = "my_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction : new
	
	my_env env;
	virtual my_if vif;
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env = my_env::type_id::create("env", this);
		if (!uvm_config_db#(virtual my_if)::get(this, "", "my_if", vif)) //get interface from config db at top module
			`uvm_fatal("TEST", "Did not get vif")
		uvm_config_db#(virtual my_if)::set(this, "env.agnt.*", "my_if", vif); //propogates the interface down to all children of the agent: monitor and driver
	endfunction : build_phase
	
	virtual task run_phase(uvm_phase phase);
		my_sequence seq = my_sequence::type_id::create("seq", this); //use the factory to create sequence
		phase.raise_objection(this); // start simulation
		//gen.randomize(); //not needed unless sequence has it's own rand variables
		seq.start(env.agnt.seqr); // starts the sequence on the sequencer sequence.start(sequencer)
		#200; //wait 200ns
		phase.drop_objection(this); //end simulation
		uvm_root::get().print_topology();
		$display("Dumping coverage...");
	endtask : run_phase
 endclass : my_test