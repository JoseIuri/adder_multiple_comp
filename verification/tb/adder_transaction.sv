class adder_transaction extends uvm_sequence_item;
    rand integer A;
    rand integer B;
    //Alterar os dados para sua aplicação

    `uvm_object_utils_begin(adder_transaction)
        `uvm_field_int(A, UVM_ALL_ON|UVM_HEX)
        `uvm_field_int(B, UVM_ALL_ON|UVM_HEX)
    `uvm_object_utils_end

    function new(string name="adder_transaction");
        super.new(name);
    endfunction: new

    function string convert2string();
        return $sformatf("{A = \%h, B = \%h}", A, B);
    endfunction
endclass: adder_transaction