class my_sequence extends uvm_sequence;
    `uvm_object_utils(my_sequence)

    function new(string name = "my_sequence");
        super.new(name);
    endfunction : new

    virtual task body();
        `uvm_info("SEQ", $sformatf("Starting Adder/Subtraction Module transactions... "), UVM_LOW)
        //unsigned addition stimuli
        repeat (25) begin
            my_transaction tx;
            tx = my_transaction::type_id::create("tx");
            start_item(tx);
            tx.randomize();
            tx.OP = 6'b000000;
            `uvm_info("SEQ", $sformatf("Generating new transaction (seq item): "), UVM_LOW)
            tx.print();
            finish_item(tx);
        end
        //signed addition stimuli
        repeat (25) begin
            my_transaction tx;
            tx = my_transaction::type_id::create("tx");
            start_item(tx);
            tx.randomize();
            tx.OP = 6'b000001;
            `uvm_info("SEQ", $sformatf("Generating new transaction (seq item): "), UVM_LOW)
            tx.print();
            finish_item(tx);
        end
        //Unsigned subtraction stimuli
        repeat (25) begin
            my_transaction tx;
            tx = my_transaction::type_id::create("tx");
            start_item(tx);
            tx.randomize();
            tx.OP = 6'b000010;
            `uvm_info("SEQ", $sformatf("Generating new transaction (seq item): "), UVM_LOW)
            tx.print();
            finish_item(tx);
        end
        //signed subtraction stimuli
        repeat (25) begin
            my_transaction tx;
            tx = my_transaction::type_id::create("tx");
            start_item(tx);
            tx.randomize();
            tx.OP = 6'b000011;
            `uvm_info("SEQ", $sformatf("Generating new transaction (seq item): "), UVM_LOW)
            tx.print();
            finish_item(tx);
        end
        `uvm_info("SEQ", $sformatf("Starting Multiplier Module transactions... "), UVM_LOW)
        //unsigned multiplication stimuli
        repeat (25) begin
            my_transaction tx;
            tx = my_transaction::type_id::create("tx");
            start_item(tx);
            tx.randomize();
            tx.OP = 6'b001000;
            `uvm_info("SEQ", $sformatf("Generating new transaction (seq item): "), UVM_LOW)
            tx.print();
            finish_item(tx);
        end
        //signed multiplication stimuli
        repeat (25) begin
            my_transaction tx;
            tx = my_transaction::type_id::create("tx");
            start_item(tx);
            tx.randomize();
            tx.OP = 6'b001001;
            `uvm_info("SEQ", $sformatf("Generating new transaction (seq item): "), UVM_LOW)
            tx.print();
            finish_item(tx);
        end
        `uvm_info("SEQ", $sformatf("Starting Shifter Module Transactions..."), UVM_LOW)
        //logical left shift stimuli
        repeat (25) begin
            my_transaction tx;
            tx = my_transaction::type_id::create("tx");
            start_item(tx);
            tx.randomize();
            tx.OP = 6'b010000;
            `uvm_info("SEQ", $sformatf("Generating new transaction (seq item): "), UVM_LOW)
            tx.print();
            finish_item(tx);
        end

        //logical right shift stimuli
        repeat (25) begin
            my_transaction tx;
            tx = my_transaction::type_id::create("tx");
            start_item(tx);
            tx.randomize();
            tx.OP = 6'b010001;
            `uvm_info("SEQ", $sformatf("Generating new transaction (seq item): "), UVM_LOW)
            tx.print();
            finish_item(tx);
        end

        //arithmetic right shift stimuli
        repeat (25) begin
            my_transaction tx;
            tx = my_transaction::type_id::create("tx");
            start_item(tx);
            tx.randomize();
            tx.OP = 6'b010011;
            `uvm_info("SEQ", $sformatf("Generating new transaction (seq item): "), UVM_LOW)
            tx.print();
            finish_item(tx);
        end

        //rotate left shift stimuli
        repeat (25) begin
            my_transaction tx;
            tx = my_transaction::type_id::create("tx");
            start_item(tx);
            tx.randomize();
            tx.OP = 6'b010100;
            `uvm_info("SEQ", $sformatf("Generating new transaction (seq item): "), UVM_LOW)
            tx.print();
            finish_item(tx);
        end

        //rotate right shift stimuli
        repeat (25) begin
            my_transaction tx;
            tx = my_transaction::type_id::create("tx");
            start_item(tx);
            tx.randomize();
            tx.OP = 6'b010101;
            `uvm_info("SEQ", $sformatf("Generating new transaction (seq item): "), UVM_LOW)
            tx.print();
            finish_item(tx);
        end
        `uvm_info("SEQ", $sformatf("Starting Comparator Module Transactions..."), UVM_LOW)
        // equality comparison stimuli // b100000
        repeat (25) begin
            my_transaction tx;
            tx = my_transaction::type_id::create("tx");
            start_item(tx);
            tx.randomize();
            tx.OP = 6'b100000;
            `uvm_info("SEQ", $sformatf("Generating new transaction (seq item): "), UVM_LOW)
            tx.print();
            finish_item(tx);
        end
        
        // unsigned greater than comparison stimuli b100001
        repeat (25) begin
            my_transaction tx;
            tx = my_transaction::type_id::create("tx");
            start_item(tx);
            tx.randomize();
            tx.OP = 6'b100001;
            `uvm_info("SEQ", $sformatf("Generating new transaction (seq item): "), UVM_LOW)
            tx.print();
            finish_item(tx);
        end
        // signed greater than comparison stimuli b100101
        repeat (25) begin
            my_transaction tx;
            tx = my_transaction::type_id::create("tx");
            start_item(tx);
            tx.randomize();
            tx.OP = 6'b100101;
            `uvm_info("SEQ", $sformatf("Generating new transaction (seq item): "), UVM_LOW)
            tx.print();
            finish_item(tx);
        end
        // unsigned less than comparison stimuli b100010
        repeat (25) begin
            my_transaction tx;
            tx = my_transaction::type_id::create("tx");
            start_item(tx);
            tx.randomize();
            tx.OP = 6'b100010;
            `uvm_info("SEQ", $sformatf("Generating new transaction (seq item): "), UVM_LOW)
            tx.print();
            finish_item(tx);
        end
        // signed less than comparison stimuli b100110
        repeat (25) begin
            my_transaction tx;
            tx = my_transaction::type_id::create("tx");
            start_item(tx);
            tx.randomize();
            tx.OP = 6'b100110;
            `uvm_info("SEQ", $sformatf("Generating new transaction (seq item): "), UVM_LOW)
            tx.print();
            finish_item(tx);
        end
        `uvm_info("SEQ", $sformatf("Starting Logic Module Transactions..."), UVM_LOW)
        //And stimuli
        repeat (25) begin
            my_transaction tx;
            tx = my_transaction::type_id::create("tx");
            start_item(tx);
            tx.randomize();
            tx.OP = 6'b011000;
            `uvm_info("SEQ", $sformatf("Generating new transaction (seq item): "), UVM_LOW)
            tx.print();
            finish_item(tx);
        end
        //Or stimuli
        repeat (25) begin
            my_transaction tx;
            tx = my_transaction::type_id::create("tx");
            start_item(tx);
            tx.randomize();
            tx.OP = 6'b011001;
            `uvm_info("SEQ", $sformatf("Generating new transaction (seq item): "), UVM_LOW)
            tx.print();
            finish_item(tx);
        end
        //Xor stimuli
        repeat (25) begin
            my_transaction tx;
            tx = my_transaction::type_id::create("tx");
            start_item(tx);
            tx.randomize();
            tx.OP = 6'b011010;
            `uvm_info("SEQ", $sformatf("Generating new transaction (seq item): "), UVM_LOW)
            tx.print();
            finish_item(tx);
        end
        //Not Stimuli
        repeat (25) begin
            my_transaction tx;
            tx = my_transaction::type_id::create("tx");
            start_item(tx);
            tx.randomize();
            tx.OP = 6'b011011;
            `uvm_info("SEQ", $sformatf("Generating new transaction (seq item): "), UVM_LOW)
            tx.print();
            finish_item(tx);
        end
        `uvm_info("SEQ", $sformatf("Done generating transactions"), UVM_LOW)
    endtask : body
endclass : my_sequence