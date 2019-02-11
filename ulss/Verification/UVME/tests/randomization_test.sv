class randomization_test extends ulss_base_test;
  // Factory registration
  `uvm_component_utils(randomization_test)
  
  // Constructor
  function new(string name = "randomization_test", uvm_component parent);
    super.new(name, parent);
  endfunction
 
  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
  // Run phase
  virtual task run_phase(uvm_phase phase);
    randomization_seq randomization_seq_inst;// Declare separate sequence instances
    
    `uvm_info(get_full_name(), $sformatf("it test first line"), UVM_MEDIUM)
     phase.raise_objection(this);
    `uvm_info(get_type_name(), $sformatf("inside the randomization_seq test"), UVM_MEDIUM)
    
    // Create and run scenario 1
    randomization_seq_inst = randomization_seq::type_id::create("randomization_seq_inst");
    randomization_seq_inst.scenario = 1;
    randomization_seq_inst.start(env.agent.sqr);
    `uvm_info(get_type_name(), $sformatf("randomization_seq scenario 1 is completed"), UVM_MEDIUM)
    
    
       // Add drain time to allow transactions to complete
    #1000;
    phase.drop_objection(this);
  endtask
endclass


