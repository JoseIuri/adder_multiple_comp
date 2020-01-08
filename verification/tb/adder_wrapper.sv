module adder_wrapper (adder_if bus);


    adder adder_sv (
        .reset(bus.reset),
        .clk(bus.clk),
        .a(bus.a),
        .b(bus.b),
        .valid(bus.valid),
        .c(bus.c));

endmodule