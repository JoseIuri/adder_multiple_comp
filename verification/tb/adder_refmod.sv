class adder_refmod extends uvm_component;
    `uvm_component_utils(adder_refmod)
    
    adder_transaction tr_in;
    adder_transaction tr_out;
    integer a, b;
    uvm_analysis_imp #(adder_transaction, adder_refmod) in;
    uvm_analysis_export #(adder_transaction) out;
    
    function new(string name = "adder_refmod", uvm_component parent);
        super.new(name, parent);
        in = new("in", this);
        out = new("out", this);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        tr_out = adder_transaction::type_id::create("tr_out", this);
    endfunction: build_phase
    
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        
        forever begin
            @begin_refmodtask;
            //tr_out.data = sum(tr_in.A, tr_in.B);
            out.write(tr_out);
        end
    endtask: run_phase

    virtual function write (adder_transaction t);
        tr_in = adder_transaction::type_id::create("tr_in", this);
        tr_in.copy(t);
        -> begin_refmodtask;
    endfunction
endclass: adder_refmod