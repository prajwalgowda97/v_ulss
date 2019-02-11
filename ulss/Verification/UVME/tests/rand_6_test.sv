class rand_6_test extends ulss_base_test;
  // Factory registration
  `uvm_component_utils(rand_6_test)
  
  // Constructor
  function new(string name = "rand_6_test", uvm_component parent);
    super.new(name, parent);
  endfunction
 
  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
  // Run phase
  virtual task run_phase(uvm_phase phase);
    rand_6_seq rand_6_seq_seq;// Declare separate sequence instances
    
    `uvm_info(get_full_name(), $sformatf("it test first line"), UVM_MEDIUM)
     phase.raise_objection(this);
    `uvm_info(get_type_name(), $sformatf("inside the rand_6_seq test"), UVM_MEDIUM)
    
    // Create and run scenario 1
    rand_6_seq_seq = rand_6_seq::type_id::create("rand_6_seq_seq");
    rand_6_seq_seq.scenario = 1;
    rand_6_seq_seq.start(env.agent.sqr);
    `uvm_info(get_type_name(), $sformatf("rand_6_seq scenario 1 is completed"), UVM_MEDIUM)
    
       // Add drain time to allow transactions to complete
    #1000;
    phase.drop_objection(this);
  endtask
endclass
