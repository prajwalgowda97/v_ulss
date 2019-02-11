class packet_count_limit_test extends ulss_base_test;
  // Factory registration
  `uvm_component_utils(packet_count_limit_test)
  
  // Constructor
  function new(string name = "packet_count_limit_test", uvm_component parent);
    super.new(name, parent);
  endfunction
 
  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
  // Run phase
  virtual task run_phase(uvm_phase phase);
    packet_count_limit_sequence  packet_count_limit_sequence_inst;  // Declare separate packet_count_limit_sequence_instuence instances
    
    `uvm_info(get_full_name(), $sformatf("it test first line"), UVM_MEDIUM)
     phase.raise_objection(this);
    `uvm_info(get_type_name(), $sformatf("inside the packet_count_limit_packet_count_limit_sequence_instuence_inst test"), UVM_MEDIUM)
       
    // Create and run scenario 2
    packet_count_limit_sequence_inst = packet_count_limit_sequence::type_id::create("packet_count_limit_sequence_inst");
repeat(50)
// packet_count_limit_sequence_inst.scenario = 2;
    packet_count_limit_sequence_inst.num_packets = 5;           // Send 10 packets
    packet_count_limit_sequence_inst.delay_between_packets = 0; // Wait 10 cycles between packets
    packet_count_limit_sequence_inst.token_wait = 3;             // Set token wait to 5
    packet_count_limit_sequence_inst.tokens_per_packet = 1;      // Set tokens per packet to 2
    packet_count_limit_sequence_inst.start(env.agent.sqr);
    `uvm_info(get_type_name(), $sformatf("packet_count_limit_test scenario 2 is completed"), UVM_MEDIUM)
    
    // Add drain time to allow transactions to complete
    #1000;
    phase.drop_objection(this);
  endtask
endclass
