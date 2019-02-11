class stream_map_test extends ulss_base_test;
  // Factory registration
  `uvm_component_utils(stream_map_test)
  
  // Constructor
  function new(string name = "stream_map_test", uvm_component parent);
    super.new(name, parent);
  endfunction
 
  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
  // Run phase
  virtual task run_phase(uvm_phase phase);
    stream_map_sequence  stream_map_sequence_inst;  // Declare separate sequence instances
    
    `uvm_info(get_full_name(), $sformatf("it test first line"), UVM_MEDIUM)
     phase.raise_objection(this);
    `uvm_info(get_type_name(), $sformatf("inside the stream_map_sequence_inst test"), UVM_MEDIUM)
   /*    stream_map_sequence_inst = stream_map_sequence::type_id::create("stream_map_sequence_inst");
    stream_map_sequence_inst.scenario = 1;
    stream_map_sequence_inst.start(env.agent.sqr);*/
    // Create and run scenario 2
    stream_map_sequence_inst = stream_map_sequence::type_id::create("stream_map_sequence_inst");
    repeat (50)
    stream_map_sequence_inst.scenario = 2;
    stream_map_sequence_inst.start(env.agent.sqr);
    `uvm_info(get_type_name(), $sformatf("stream_map_test scenario 2 is completed"), UVM_MEDIUM)
    
    // Add drain time to allow transactions to complete
    #1000;
    phase.drop_objection(this);
  endtask
endclass
