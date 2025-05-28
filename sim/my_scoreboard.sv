class my_scoreboard extends uvm_scoreboard;
	`uvm_component_utils(my_scoreboard)
	
	function new(string name = "my_scoreboard", uvm_component parent = null);
		super.new(name, parent);
	endfunction : new
	
	uvm_analysis_imp#(my_transaction, my_scoreboard) m_analysis_imp; //special implementation port used to receive seq items sent from the monitor's uvm_analysis_port
	virtual my_if vif;
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		m_analysis_imp = new("m_analysis_imp", this);
	endfunction : build_phase
	
	//this is where I make a reference model that works to test against my design
	virtual function void write(my_transaction tx);
		logic	[15:0]	expected;
        //logic       E_Cout;
        logic       	E_v_flag;
		logic	[7:0]	B_actual;
		//calculating B_actual for signed subtraction
		B_actual = ~(tx.B);
	//adder/subtractor reference model
		//unsigned addition reference model
		if (tx.OP == 6'b000000) begin
			expected = tx.A + tx.B + tx.OP[1]; //reference model expected value
        	E_v_flag = vif.resultF[8];
			//Check addition
			if (vif.resultF[7:0] !== expected[7:0])
				`uvm_error("SCOREBOARD", $sformatf("Mismatch! Got %0b, expected %0b, A = %0b B = %0b", vif.resultF[7:0], expected[7:0], vif.A, vif.B)) //if the design gets it wrong it'll drop this error
			else
				`uvm_info("SCOREBOARD", $sformatf("[PASS] Unsigned Addition! %0b + %0b = %0b Mode = [%0b]", vif.A, vif.B, vif.resultF[7:0], vif.OP), UVM_LOW) //otherwise it says we passed this check
			//check overflow
        	if (vif.resultF[9]  !== E_v_flag)
            	`uvm_error("SCOREBOARD" , $sformatf("Overflow Mismatch! Got %0b, expected %0b, A = %0b B = %0b", vif.resultF[8], E_v_flag, vif.A, vif.B))
        	else
            	`uvm_info("SCOREBOARD", $sformatf("[PASS] Correct Overflow Flag! %0b + %0b = %0b Overflow = %0b", vif.A, vif.B, vif.resultF[7:0], vif.resultF[8]), UVM_LOW)
		end
		// //signed addition reference model
		if ( tx.OP == 6'b000001 ) begin
			expected = $signed(tx.A) + $signed(tx.B) + tx.OP[1]; //reference model expected value
        	E_v_flag = ( (tx.A[7] == tx.B[7]) && (vif.resultF[7] != tx.A[7]) );
			//Check addition
			if ($signed(vif.resultF[7:0]) !== $signed(expected[7:0]))
				`uvm_error("SCOREBOARD", $sformatf("Mismatch! Got %0b, expected %0b, A = %0b B = %0b", $signed(vif.resultF[7:0]), $signed(expected[7:0]), $signed(vif.A), $signed(vif.B))) //if the design gets it wrong it'll drop this error
			else
				`uvm_info("SCOREBOARD", $sformatf("[PASS] Signed Addition! %0d + %0d = %0d Mode = [%0b]", $signed(vif.A), $signed(vif.B), $signed(vif.resultF[7:0]), $signed(vif.OP)), UVM_LOW) //otherwise it says we passed this check
			//check overflow
        	if (vif.resultF[9]  !== E_v_flag)
            	`uvm_error("SCOREBOARD" , $sformatf("Overflow Mismatch! Got %0b, expected %0b, A = %0b B = %0b", vif.resultF[9], E_v_flag, $signed(vif.A), $signed(vif.B)))
        	else
            	`uvm_info("SCOREBOARD", $sformatf("[PASS] Correct Overflow Flag! %0b + %0b = %0b Overflow = %0b", $signed(vif.A), $signed(vif.B), $signed(vif.resultF[7:0]), vif.resultF[9]), UVM_LOW)			
		end
		// //unsigned subtraction reference model
		if ( tx.OP == 6'b000010 ) begin
			expected = tx.A - tx.B; //reference model expected value
        	E_v_flag = ( ~vif.resultF[8] );
			//Check subtraction
			if (vif.resultF[7:0] !== expected[7:0])
				`uvm_error("SCOREBOARD", $sformatf("Mismatch! Got %0b, expected %0b, A = %0b B = %0b", vif.resultF[7:0], expected[7:0], vif.A, vif.B)) //if the design gets it wrong it'll drop this error
			else
				`uvm_info("SCOREBOARD", $sformatf("[PASS] Unsigned Subtraction! %0d - %0d = %0d Mode = [%0b]", vif.A, vif.B, vif.resultF[7:0], vif.OP), UVM_LOW) //otherwise it says we passed this check
			//check overflow
        	if (vif.resultF[9]  !== E_v_flag)
            	`uvm_error("SCOREBOARD" , $sformatf("Overflow Mismatch! Got %0b, expected %0b, A = %0b B = %0b", vif.resultF[9], E_v_flag, vif.A, vif.B))
        	else
            	`uvm_info("SCOREBOARD", $sformatf("[PASS] Correct Overflow Flag! %0b - %0b = %0b Overflow = %0b", vif.A, vif.B, vif.resultF[7:0], vif.resultF[9]), UVM_LOW)			
		end
		// //signed subtraction reference model
		if ( tx.OP == 6'b000011 ) begin
			expected = $signed(tx.A) - $signed(tx.B); //reference model expected value
        	E_v_flag = ( (tx.A[7] == B_actual[7]) && (vif.resultF[7] != tx.A[7]) );
			//Check Subtraction
			if ($signed(vif.resultF[7:0]) !== $signed(expected[7:0]))
				`uvm_error("SCOREBOARD", $sformatf("Mismatch! Got %0b, expected %0b, A = %0b B = %0b", $signed(vif.resultF[7:0]), $signed(expected[7:0]), $signed(vif.A), $signed(vif.B))) //if the design gets it wrong it'll drop this error
			else
				`uvm_info("SCOREBOARD", $sformatf("[PASS] Signed Subtraction! %0d - %0d = %0d Mode = [%0b]", $signed(vif.A), $signed(vif.B), $signed(vif.resultF[7:0]), vif.OP), UVM_LOW) //otherwise it says we passed this check
			//check overflow
        	if (vif.resultF[9]  !== E_v_flag)
            	`uvm_error("SCOREBOARD" , $sformatf("Overflow Mismatch! Got %0b, expected %0b, A = %0b B = %0b", vif.resultF[9], E_v_flag, $signed(vif.A), $signed(vif.B)))
        	else
            	`uvm_info("SCOREBOARD", $sformatf("[PASS] Correct Overflow Flag! %0b - %0b = %0b Overflow = %0b", $signed(vif.A), $signed(vif.B), $signed(vif.resultF[7:0]), vif.resultF[9]), UVM_LOW)	
		end
	//multiplier reference model
		//unsigned multiplication reference model
		if ( tx.OP == 6'b001000 ) begin
			expected = tx.A * tx.B; //reference model expected value
			//Check Subtraction
			if (vif.resultF !== expected)
				`uvm_error("SCOREBOARD", $sformatf("Mismatch! Got %0b, expected %0b, A = %0b B = %0b", vif.resultF, expected, vif.A, vif.B)) //if the design gets it wrong it'll drop this error
			else
				`uvm_info("SCOREBOARD", $sformatf("[PASS] Unsigned Multiplication! %0d * %0d = %0d Mode = [%0b]", vif.A, vif.B, vif.resultF, vif.OP), UVM_LOW) //otherwise it says we passed this check
		end	
		//signed multiplication reference model
		if ( tx.OP == 6'b001001 ) begin
			expected = $signed(tx.A) * $signed(tx.B); //reference model expected value
			//Check Multiplication
			if ($signed(vif.resultF) !== $signed(expected))
				`uvm_error("SCOREBOARD", $sformatf("Mismatch! Got %0b, expected %0b, A = %0b B = %0b", $signed(vif.resultF), $signed(expected), $signed(vif.A), $signed(vif.B))) //if the design gets it wrong it'll drop this error
			else
				`uvm_info("SCOREBOARD", $sformatf("[PASS] Signed Multiplication! %0d * %0d = %0d Mode = [%0b]", $signed(vif.A), $signed(vif.B), $signed(vif.resultF), vif.OP), UVM_LOW) //otherwise it says we passed this check
		end
	//Shifter reference model
		//Logical Left reference model
		if ( tx.OP == 6'b010000 ) begin
			expected = {tx.A[6:0], 1'b0}; //reference model expected value
			//Check Shift
			if (vif.resultF[7:0] !== expected[7:0])
				`uvm_error("SCOREBOARD", $sformatf("Mismatch! Got %0b, expected %0b, A = %0b", vif.resultF[7:0], expected[7:0], vif.A)) //if the design gets it wrong it'll drop this error
			else
				`uvm_info("SCOREBOARD", $sformatf("[PASS] Logical/Arithmetic Left Shift! %0b << = %0b Mode = [%0b]", vif.A, vif.resultF[7:0], vif.OP), UVM_LOW) //otherwise it says we passed this check
		end
		//Logical Right reference model
		if ( tx.OP == 6'b010001 ) begin
			expected = {1'b0, tx.A[7:1]}; //reference model expected value
			//Check Shift
			if (vif.resultF[7:0] !== expected[7:0])
				`uvm_error("SCOREBOARD", $sformatf("Mismatch! Got %0b, expected %0b, A = %0b", vif.resultF[7:0], expected[7:0], vif.A)) //if the design gets it wrong it'll drop this error
			else
				`uvm_info("SCOREBOARD", $sformatf("[PASS] Logical Right Shift! %0b >> = %0b Mode = [%0b]", vif.A, vif.resultF[7:0], vif.OP), UVM_LOW) //otherwise it says we passed this check
		end
		//Arithmetic Right reference model
		if ( tx.OP == 6'b010011 ) begin
			expected = {tx.A[7], tx.A[7:1]}; //reference model expected value
			//Check Shift
			if (vif.resultF[7:0] !== expected[7:0])
				`uvm_error("SCOREBOARD", $sformatf("Mismatch! Got %0b, expected %0b, A = %0b", vif.resultF[7:0], expected[7:0], vif.A)) //if the design gets it wrong it'll drop this error
			else
				`uvm_info("SCOREBOARD", $sformatf("[PASS] Arithmetic Right Shift! %0b >> = %0b Mode = [%0b]", vif.A, vif.resultF[7:0], vif.OP), UVM_LOW) //otherwise it says we passed this check
		end
		//Rotate left reference model
		if ( tx.OP == 6'b010100 ) begin
			expected = {tx.A[6:0], tx.A[7]}; //reference model expected value
			//Check Shift
			if (vif.resultF[7:0] !== expected[7:0])
				`uvm_error("SCOREBOARD", $sformatf("Mismatch! Got %0b, expected %0b, A = %0b", vif.resultF[7:0], expected[7:0], vif.A)) //if the design gets it wrong it'll drop this error
			else
				`uvm_info("SCOREBOARD", $sformatf("[PASS] Left Rotate %0b ROL = %0b Mode = [%0b]", vif.A, vif.resultF[7:0], vif.OP), UVM_LOW) //otherwise it says we passed this check
		end
		//Rotate right reference model
		if ( tx.OP == 6'b010101 ) begin
			expected = {tx.A[0], tx.A[7:1]}; //reference model expected value
			//Check Shift
			if (vif.resultF[7:0] !== expected[7:0])
				`uvm_error("SCOREBOARD", $sformatf("Mismatch! Got %0b, expected %0b, A = %0b", vif.resultF[7:0], expected[7:0], vif.A)) //if the design gets it wrong it'll drop this error
			else
				`uvm_info("SCOREBOARD", $sformatf("[PASS] Right Rotation! %0b ROR = %0b Mode = [%0b]", vif.A, vif.resultF[7:0], vif.OP), UVM_LOW) //otherwise it says we passed this check
		end
	//Comparator reference model
		//equal to reference model
		if ( tx.OP == 6'b100000 ) begin
			expected[15:1] = 15'b0;
			expected[0] = (tx.A == tx.B); //reference model expected value
			//Check Compare
			if (vif.resultF !== expected)
				`uvm_error("SCOREBOARD", $sformatf("Mismatch! Got %0b, expected %0b, A = %0b, B = %0b", vif.resultF[0], expected[0], vif.A, vif.B)) //if the design gets it wrong it'll drop this error
			else
				`uvm_info("SCOREBOARD", $sformatf("[PASS] Equality Comparison! %0d == %0d = %0d Mode = [%0b]", vif.A, vif.B, vif.resultF[0], vif.OP), UVM_LOW) //otherwise it says we passed this check
		end
		//unsigned greater than reference model
		if ( tx.OP == 6'b100001 ) begin
			expected[15:1] = 15'b0;
			expected[0] = (tx.A > tx.B); //reference model expected value
			//Check Compare
			if (vif.resultF !== expected)
				`uvm_error("SCOREBOARD", $sformatf("Mismatch! Got %0b, expected %0b, A = %0b, B = %0b", vif.resultF[0], expected[0], vif.A, vif.B)) //if the design gets it wrong it'll drop this error
			else
				`uvm_info("SCOREBOARD", $sformatf("[PASS] Unsigned Greater Than Comparison! %0d > %0d = %0d Mode = [%0b]", vif.A, vif.B, vif.resultF[0], vif.OP), UVM_LOW) //otherwise it says we passed this check
		end
		//signed greater than reference model
		if ( tx.OP == 6'b100101 ) begin
			expected[15:1] = 15'b0;
			expected[0] = ($signed(tx.A) > $signed(tx.B)); //reference model expected value
			//Check Compare
			if (vif.resultF !== expected)
				`uvm_error("SCOREBOARD", $sformatf("Mismatch! Got %0b, expected %0b, A = %0b, B = %0b", vif.resultF[0], expected[0], $signed(vif.A), $signed(vif.B))) //if the design gets it wrong it'll drop this error
			else
				`uvm_info("SCOREBOARD", $sformatf("[PASS] Signed Greater Than Comparison! %0d > %0d = %0d Mode = [%0b]", $signed(vif.A), $signed(vif.B), vif.resultF[0], vif.OP), UVM_LOW) //otherwise it says we passed this check
		end
		//unsigned less than reference model
		if ( tx.OP == 6'b100010 ) begin
			expected[15:1] = 15'b0;
			expected[0] = (tx.A < tx.B); //reference model expected value
			//Check Compare
			if (vif.resultF !== expected)
				`uvm_error("SCOREBOARD", $sformatf("Mismatch! Got %0b, expected %0b, A = %0b, B = %0b", vif.resultF[0], expected[0], vif.A, vif.B)) //if the design gets it wrong it'll drop this error
			else
				`uvm_info("SCOREBOARD", $sformatf("[PASS] Unsigned Less Than Comparison! %0d < %0d = %0d Mode = [%0b]", vif.A, vif.B, vif.resultF[0], vif.OP), UVM_LOW) //otherwise it says we passed this check
		end 
		//signed less than reference model
		if ( tx.OP == 6'b100110 ) begin
			expected[15:1] = 15'b0;
			expected[0] = ($signed(tx.A) < $signed(tx.B)); //reference model expected value
			//Check Compare
			if (vif.resultF !== expected)
				`uvm_error("SCOREBOARD", $sformatf("Mismatch! Got %0b, expected %0b, A = %0b, B = %0b", vif.resultF[0], expected[0], $signed(vif.A), $signed(vif.B))) //if the design gets it wrong it'll drop this error
			else
				`uvm_info("SCOREBOARD", $sformatf("[PASS] Signed Less Than Comparison! %0d < %0d = %0d Mode = [%0b]", $signed(vif.A), $signed(vif.B), vif.resultF[0], vif.OP), UVM_LOW) //otherwise it says we passed this check
		end
	//Logic reference model
		//And referemce model
		if ( tx.OP == 6'b011000 ) begin
			expected[15:8] = 8'b0;
			expected[7:0] = (tx.A & tx.B); //reference model expected value
			//Check Logic
			if (vif.resultF !== expected)
				`uvm_error("SCOREBOARD", $sformatf("Mismatch! Got %0b, expected %0b, A = %0b, B = %0b", vif.resultF[7:0], expected[7:0], vif.A, vif.B)) //if the design gets it wrong it'll drop this error
			else
				`uvm_info("SCOREBOARD", $sformatf("[PASS] And Logic! %0b & %0b = %0b Mode = [%0b]", vif.A, vif.B, vif.resultF[7:0], vif.OP), UVM_LOW) //otherwise it says we passed this check
		end 
		//Or reference model
		if ( tx.OP == 6'b011001 ) begin
			expected[15:8] = 8'b0;
			expected[7:0] = (tx.A | tx.B); //reference model expected value
			//Check Logic
			if (vif.resultF !== expected)
				`uvm_error("SCOREBOARD", $sformatf("Mismatch! Got %0b, expected %0b, A = %0b, B = %0b", vif.resultF[7:0], expected[7:0], vif.A, vif.B)) //if the design gets it wrong it'll drop this error
			else
				`uvm_info("SCOREBOARD", $sformatf("[PASS] Or Logic! %0b | %0b = %0b Mode = [%0b]", vif.A, vif.B, vif.resultF[7:0], vif.OP), UVM_LOW) //otherwise it says we passed this check
		end 
		//Xor reference model
		if ( tx.OP == 6'b011010 ) begin
			expected[15:8] = 8'b0;
			expected[7:0] = (tx.A ^ tx.B); //reference model expected value
			//Check Logic
			if (vif.resultF !== expected)
				`uvm_error("SCOREBOARD", $sformatf("Mismatch! Got %0b, expected %0b, A = %0b, B = %0b", vif.resultF[7:0], expected[7:0], vif.A, vif.B)) //if the design gets it wrong it'll drop this error
			else
				`uvm_info("SCOREBOARD", $sformatf("[PASS] Xor Logic! %0b ^ %0b = %0b Mode = [%0b]", vif.A, vif.B, vif.resultF[7:0], vif.OP), UVM_LOW) //otherwise it says we passed this check
		end 
		//NOT reference model
		if ( tx.OP == 6'b011011 ) begin
			expected[15:8] = 8'b0;
			expected[7:0] = (~tx.A); //reference model expected value
			//Check Logic
			if (vif.resultF !== expected)
				`uvm_error("SCOREBOARD", $sformatf("Mismatch! Got %0b, expected %0b, A = %0b", vif.resultF[7:0], expected[7:0], vif.A)) //if the design gets it wrong it'll drop this error
			else
				`uvm_info("SCOREBOARD", $sformatf("[PASS] Not Logic! ~%0b = %0b Mode = [%0b]", vif.A, vif.resultF[7:0], vif.OP), UVM_LOW) //otherwise it says we passed this check
		end 
	endfunction : write
endclass : my_scoreboard