class adder_driver extends uvm_driver#(adder_transaction);
    `uvm_component_utils(adder_driver)

    typedef virtual adder_if vif;
    typedef adder_transaction tr_type;
    typedef enum {WAIT_ADDR, WAIT_DATA, WAIT_RESP} state_rw;

    vif dut_vif;
    tr_type tr;
    bit item_done;
    event begin_record,end_record;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(vif)::get(this, "", "dut_vif", dut_vif)) begin
            `uvm_fatal("NOVIF", "failed to get virtual interface")
        end
    endfunction

    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        fork
            reset_signals();
            get_and_drive(phase);
            record_tr();
        join
    endtask

    virtual protected task reset_signals();
        wait (dut_vif.rst === 1);
        forever begin
            dut_vif.valid <= '0;
            dut_vif.A <= 'x;
            dut_vif.B <= 'x;
            @(posedge dut_vif.rst);
        end
    endtask

    virtual protected task get_and_drive(uvm_phase phase);
        wait(dut_vif.rst === 1);
        @(negedge dut_vif.rst);
        @(posedge dut_vif.clk);

        forever begin
            seq_item_port.get(req);
            -> begin_record;
            drive_transfer(req);
        end
    endtask

    virtual protected task drive_transfer(adder_transaction tr);
        dut_vif.A = tr.A;
        dut_vif.B = tr.B;
        dut_vif.valid = 1;

        @(posedge dut_vif.clk)

        while(!dut_vif.ready)
        @(posedge dut_vif.clk);

        -> end_record;
        @(posedge dut_vif.clk); //hold time
        dut_vif.valid = 0;
        @(posedge dut_vif.clk);
    endtask

    virtual task record_tr();
        forever begin
            @(begin_record);
            begin_tr(req, "driver");
            @(end_record);
            end_tr(req);
        end
    endtask
endclass: adder_driver