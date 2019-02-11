class maximun_packet_count_test extends ulss_base_test;
  // Factory registration
  `uvm_component_utils(maximun_packet_count_test)
  
  // Constructor
  function new(string name = "maximun_packet_count_test", uvm_component parent);
    super.new(name, parent);
  endfunction
 
  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     // Configure timeout settings for driver using configuration database
   // uvm_config_db#(int)::set(this, "env.agent.drv", "wait_timeout_cycles", 200);
   // uvm_config_db#(int)::set(this, "env.agent.drv", "simulation_timeout_cycles", 2000);
    
  endfunction
  
  // Run phase
  virtual task run_phase(uvm_phase phase);
    maximun_packet_count_sequence  maximun_packet_count_sequence_inst;  // Declare separate maximun_packet_count_sequence_instuence instances
    
    `uvm_info(get_full_name(), $sformatf("it test first line"), UVM_MEDIUM)
     phase.raise_objection(this);
    `uvm_info(get_type_name(), $sformatf("inside the packet_count_limit_maximun_packet_count_sequence_instuence_inst test"), UVM_MEDIUM)
       
    // Create and run scenario 2
    maximun_packet_count_sequence_inst = maximun_packet_count_sequence::type_id::create("maximun_packet_count_sequence_inst");
   // maximun_packet_count_sequence_inst.scenario = 2;
    maximun_packet_count_sequence_inst.num_packets = 611;           // Send 10 packets
    maximun_packet_count_sequence_inst.delay_between_packets = 0; // Wait 10 cycles between packets
    maximun_packet_count_sequence_inst.token_wait = 3;             // Set token wait to 5
    maximun_packet_count_sequence_inst.tokens_per_packet = 1;      // Set tokens per packet to 2
    maximun_packet_count_sequence_inst.start(env.agent.sqr);
    `uvm_info(get_type_name(), $sformatf("maximun_packet_count_test scenario 2 is completed"), UVM_MEDIUM)
    
    // Add drain time to allow transactions to complete
    #1000;
    phase.drop_objection(this);
  endtask
endclass
