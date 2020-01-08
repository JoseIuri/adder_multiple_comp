package adder_pkg;
    `include "uvm_macros.svh"
    import uvm_pkg::*;


    `include "./adder_types.svh"
    `include "./adder_transaction.sv"
    
    `include "./adder_sequence.sv"
    `include "./adder_driver.sv"
    `include "./adder_monitor.sv"
    `include "./adder_agent.sv"

    `include "./adder_cover.sv"
    `include "./adder_refmod.sv"
    `include "./adder_scoreboard.sv"
    `include "./adder_env.sv"

    `include "./simple_test.sv"
endpackage