class my_env extends uvm_env;
	`uvm_component_utils(my_env)
	
	function new(string name = "my_env", uvm_component parent = null);
		super.new(name, parent);
	endfunction : new
	
	my_agent agnt; //agent handle
	my_scoreboard scbd; //scoreboard handle
	my_subscriber cov; //coverage handle
	
	//use factory to build agent and scoreboard components 
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		agnt = my_agent::type_id::create("agnt", this);
		scbd = my_scoreboard::type_id::create("scbd", this);
		cov = my_subscriber::type_id::create("cov", this);
		 if (!uvm_config_db#(virtual my_if)::get(this, "", "my_if", scbd.vif))
            `uvm_fatal("ENV", "Did not get vif for scoreboard")  
	endfunction : build_phase
	
	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		//connect agent's monitor port to scoreboard's analysis implementation port
		agnt.mon.mon_analysis_port.connect(scbd.m_analysis_imp);
		agnt.mon.mon_analysis_port.connect(cov.analysis_export);
	endfunction : connect_phase
endclass : my_env