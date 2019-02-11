class ulss_sequencer extends uvm_sequencer#(ulss_tx);

  //factory registration
  `uvm_component_utils(ulss_sequencer)

  //constructor
  function new(string name="ulss_sequencer",uvm_component parent=null);
        super.new(name,parent);
  endfunction
  
endclass
