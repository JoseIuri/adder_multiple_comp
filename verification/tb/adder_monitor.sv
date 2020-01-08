class adder_monitor extends uvm_monitor;

    virtual adder_if  adder_vif;
    event begin_record, end_record;
    adder_transaction tr;
    uvm_analysis_port #(adder_transaction) req_tr_port;
    uvm_analysis_port #(adder_transaction) resp_tr_port;
    `uvm_component_utils(adder_monitor)
   
    function new(string name, uvm_component parent);
        super.new(name, parent);
        req_tr_port = new("req_tr_port", this);
        resp_tr_port = new("resp_tr_port", this);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        assert(uvm_config_db#(virtual adder_if)::get(this, "", "adder_vif", adder_vif));
        tr = adder_transaction::type_id::create("tr", this);
    endfunction

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        fork
            collect_transactions(phase);
            record_tr();
        join
    endtask

    virtual task collect_transactions(uvm_phase phase);
        wait(adder_vif.rst === 1);
        @(negedge adder_vif.rst);
        
        forever begin
            do begin
                @(posedge adder_vif.clk);
            end while (adder_vif.valid === 0 || adder_vif.ready === 0);
            -> begin_record;
            
            tr.A = adder_vif.A;
            tr.B = adder_vif.B;
            req_tr_port.write(tr);
            resp_tr_port.write(tr);

            @(posedge adder_vif.clk);
            -> end_record;
        end
    endtask

    virtual task record_tr();
        forever begin
            @(begin_record);
            begin_tr(tr, "adder_monitor");
            @(end_record);
            end_tr(tr);
        end
    endtask
endclass: adder_monitor