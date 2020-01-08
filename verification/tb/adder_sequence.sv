class adder_sequence extends uvm_sequence #(adder_transaction);
    `uvm_object_utils(adder_sequence)

    function new(string name="adder_sequence");
        super.new(name);
    endfunction: new

    task body;
        adder_transaction tr;

        forever begin
            tr = adder_transaction::type_id::create("tr");
            start_item(tr);
                assert(tr.randomize());
            finish_item(tr);
            //Alterar caso necessite de uma sequencia direcionada.
        end
    endtask: body
endclass