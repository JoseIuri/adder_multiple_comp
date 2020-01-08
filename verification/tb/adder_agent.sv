class adder_agent extends uvm_agent;
    uvm_sequencer#(adder_transaction) sqr;
    adder_driver    drv;
    adder_monitor   mon;

    uvm_analysis_port #(adder_transaction) agt_resp_port;
    uvm_analysis_port #(adder_transaction) agt_req_port;

    `uvm_component_utils(adder_agent)

    function new(string name = "adder_agent", uvm_component parent = null);
        super.new(name, parent);
        agt_resp_port = new("agt_resp_port", this);
        agt_req_port = new("agt_req_port", this);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        mon = adder_monitor::type_id::create("mon", this);
        sqr = uvm_sequencer#(adder_transaction)::type_id::create("sqr", this);
        drv = adder_driver::type_id::create("drv", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        mon.req_tr_port.connect(agt_req_port);
        mon.resp_tr_port.connect(agt_resp_port);
        drv.seq_item_port.connect(sqr.seq_item_export);
    endfunction
endclass: adder_agent