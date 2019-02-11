
class reset_test extends ulss_base_test;
  // Factory registration
  `uvm_component_utils(reset_test)
  
  // Constructor
  function new(string name = "reset_test", uvm_component parent);
    super.new(name, parent);
  endfunction
 
  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
  // Run phase
  virtual task run_phase(uvm_phase phase);
    reset_sequence reset_seq_1;// Declare separate sequence instances
    
    `uvm_info(get_full_name(), $sformatf("it test first line"), UVM_MEDIUM)
     phase.raise_objection(this);
    `uvm_info(get_type_name(), $sformatf("inside the reset test"), UVM_MEDIUM)
    
    // Create and run scenario 1
    reset_seq_1 = reset_sequence::type_id::create("reset_seq_1");
    reset_seq_1.scenario = 1;
    reset_seq_1.start(env.agent.sqr);
    `uvm_info(get_type_name(), $sformatf("reset scenario 1 is completed"), UVM_MEDIUM)
    
       // Add drain time to allow transactions to complete
    #1000;
    phase.drop_objection(this);
  endtask
endclass


