/*class zero_packet_count_test extends ulss_base_test;
  // Factory registration
  `uvm_component_utils(zero_packet_count_test)
  
  // Constructor
  function new(string name = "zero_packet_count_test", uvm_component parent);
    super.new(name, parent);
  endfunction
 
  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
  // Run phase
  virtual task run_phase(uvm_phase phase);
    zero_packet_count_sequence  zero_packet_count_sequence_inst;  // Declare separate sequence instances
    
    `uvm_info(get_full_name(), $sformatf("it test first line"), UVM_MEDIUM)
     phase.raise_objection(this);
    `uvm_info(get_type_name(), $sformatf("inside the zero_packet_count_sequence_inst test"), UVM_MEDIUM)
       
    // Create and run scenario 2
    zero_packet_count_sequence_inst = zero_packet_count_sequence::type_id::create("zero_packet_count_sequence_inst");
   // zero_packet_count_sequence_inst.scenario = 2;
    zero_packet_count_sequence_inst.start(env.agent.sqr);
    `uvm_info(get_type_name(), $sformatf("zero_packet_count_sequence scenario 2 is completed"), UVM_MEDIUM)
    
    // Add drain time to allow transactions to complete
    #1000;
    phase.drop_objection(this);
  endtask
endclass*/


class zero_packet_count_test extends ulss_base_test;
  // Factory registration
  `uvm_component_utils(zero_packet_count_test)
  
  // Constructor
  function new(string name = "zero_packet_count_test", uvm_component parent);
    super.new(name, parent);
  endfunction
 
  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
  // Run phase
  virtual task run_phase(uvm_phase phase);
    zero_packet_count_sequence  zero_packet_count_sequence_inst;  // Declare separate zero_packet_count_sequence_instuence instances
    
    `uvm_info(get_full_name(), $sformatf("it test first line"), UVM_MEDIUM)
     phase.raise_objection(this);
    `uvm_info(get_type_name(), $sformatf("inside the packet_count_limit_zero_packet_count_sequence_instuence_inst test"), UVM_MEDIUM)
       
    // Create and run scenario 2
    zero_packet_count_sequence_inst = zero_packet_count_sequence::type_id::create("zero_packet_count_sequence_inst");
   // zero_packet_count_sequence_inst.scenario = 2;
    zero_packet_count_sequence_inst.num_packets = 0;           // Send 10 packets
    zero_packet_count_sequence_inst.delay_between_packets = 0; // Wait 10 cycles between packets
    zero_packet_count_sequence_inst.token_wait = 3;             // Set token wait to 5
    zero_packet_count_sequence_inst.tokens_per_packet = 1;      // Set tokens per packet to 2
    zero_packet_count_sequence_inst.start(env.agent.sqr);
    `uvm_info(get_type_name(), $sformatf("zero_packet_count_test scenario 2 is completed"), UVM_MEDIUM)
    
    // Add drain time to allow transactions to complete
    #1000;
    phase.drop_objection(this);
  endtask
endclass
