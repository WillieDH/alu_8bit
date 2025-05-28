package my_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    //UVM components
    //Interface
    //`include "my_if.sv" //illegal to include interfaces inside of the package
    //seq items/transactions/packets
    `include "my_transaction.sv"
    //sequence/generator
    `include "my_sequence.sv"
    //driver
    `include "my_driver.sv"
    //monitor
    `include "my_monitor.sv"
    //agent/sequencer
    `include "my_agent.sv"
    //scoreboard
    `include "my_scoreboard.sv"
    //subscriber/coverage
    `include "my_subscriber.sv"
    //env
    `include "my_env.sv"
    //test
    `include "my_test.sv"
endpackage : my_pkg