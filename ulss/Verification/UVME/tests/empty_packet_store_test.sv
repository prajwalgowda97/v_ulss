class empty_packet_store_test extends ulss_base_test;
  // Factory registration
  `uvm_component_utils(empty_packet_store_test)
  
  // Constructor
  function new(string name = "empty_packet_store_test", uvm_component parent);
    super.new(name, parent);
  endfunction
 
  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
  // Run phase
  virtual task run_phase(uvm_phase phase);
    empty_packet_store_sequence  empty_packet_store_sequence_inst;  // Declare separate sequence instances
    
    `uvm_info(get_full_name(), $sformatf("it test first line"), UVM_MEDIUM)
     phase.raise_objection(this);
    `uvm_info(get_type_name(), $sformatf("inside the empty_packet_store_sequence_inst test"), UVM_MEDIUM)
       
    // Create and run scenario 2
    empty_packet_store_sequence_inst = empty_packet_store_sequence::type_id::create("empty_packet_store_sequence_inst");
    empty_packet_store_sequence_inst.scenario = 2;
    empty_packet_store_sequence_inst.start(env.agent.sqr);
    `uvm_info(get_type_name(), $sformatf("empty_packet_store_test scenario 2 is completed"), UVM_MEDIUM)
    
    // Add drain time to allow transactions to complete
    #1000;
    phase.drop_objection(this);
  endtask
endclass
