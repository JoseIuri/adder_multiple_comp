interface adder_if (input logic clk, reset);

    logic  [1-1:0] reset;

    logic  [4-1:0] a;

    logic  [4-1:0] b;

    logic  [1-1:0] valid;

    logic  [7-1:0] c;

    modport port(
        input   reset,
        input   clk,
        input   a,
        input   b,
        input   valid,
        output   c
    );
endinterface : adder_if