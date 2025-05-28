class my_transaction extends uvm_sequence_item;
	//`uvm_object_utils(my_transaction) //Register with UVM Factory only use if i'm not using the other utility macros
	
	rand logic	[7:0]	A;
	rand logic	[7:0]	B;
	logic		[5:0]	OP;
    // logic               Cin;
    // logic               Add_mode;

	
	//Utility macros so when i use .print() on a transaction it'll show me A and bit = full field handling
	`uvm_object_utils_begin(my_transaction)
		`uvm_field_int(A, UVM_DEFAULT)
		`uvm_field_int(B, UVM_DEFAULT)
        `uvm_field_int(OP, UVM_DEFAULT)
	`uvm_object_utils_end
	
	function new(string name = "my_transaction");
		super.new(name);
	endfunction : new
	
	//custom string formatter so if i call `uvm_info("TX", tx.convert2str(), UVM_MEDIUM); it should post like: TX [INFO]: A = value B = value
	virtual function string convert2str();
		return $sformatf("A = %0b B = %0b OP = %b", A, B, OP);
	endfunction : convert2str
endclass : my_transaction