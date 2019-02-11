class all_streams_active_test extends ulss_base_test;
  // Factory registration
  `uvm_component_utils(all_streams_active_test)
  
  // Constructor
  function new(string name = "all_streams_active_test", uvm_component parent);
    super.new(name, parent);
  endfunction
 
  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
  // Run phase
  virtual task run_phase(uvm_phase phase);
    all_streams_active_sequence  all_streams_active_sequence_inst;  // Declare separate sequence instances
    
    `uvm_info(get_full_name(), $sformatf("it test first line"), UVM_MEDIUM)
     phase.raise_objection(this);
    `uvm_info(get_type_name(), $sformatf("inside the all_streams_active_sequence_inst_inst test"), UVM_MEDIUM)
       
    // Create and run scenario 2
    all_streams_active_sequence_inst = all_streams_active_sequence::type_id::create("all_streams_active_sequence_inst");
    all_streams_active_sequence_inst.scenario = 2;
    all_streams_active_sequence_inst.start(env.agent.sqr);
    `uvm_info(get_type_name(), $sformatf("all_streams_active_sequence_inst scenario 2 is completed"), UVM_MEDIUM)
    
    // Add drain time to allow transactions to complete
    #1000;
    phase.drop_objection(this);
  endtask
endclass
