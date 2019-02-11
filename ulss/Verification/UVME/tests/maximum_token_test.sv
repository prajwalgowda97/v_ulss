class maximum_token_test extends ulss_base_test;
  // Factory registration
  `uvm_component_utils(maximum_token_test)
  // int wait_timeout_cycles =36000;       // Default for regular tests
  //int simulation_timeout_cycles = 36000;
  // Constructor
  function new(string name = "maximum_token_test", uvm_component parent);
    super.new(name, parent);
  endfunction
 
  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
   // uvm_config_db#(int)::set(this, "env.agent.drv", "wait_timeout_cycles", 36000);
    //uvm_config_db#(int)::set(this, "env.agent.drv", "simulation_timeout_cycles", 36000);

     //uvm_config_db#(int)::set(this, "","wait_timeout_cycles", 36000);
   // uvm_config_db#(int)::set(this, "", "simulation_timeout_cycles", 36000);
    

  endfunction
  
  // Run phase
  virtual task run_phase(uvm_phase phase);
    maximum_token_sequence  maximum_token_sequence_inst;  // Declare separate sequence instances
    
    `uvm_info(get_full_name(), $sformatf("it test first line"), UVM_MEDIUM)
     phase.raise_objection(this);
    `uvm_info(get_type_name(), $sformatf("inside the maximum_token_sequence_inst test"), UVM_MEDIUM)
       
    // Create and run scenario 2
    maximum_token_sequence_inst = maximum_token_sequence::type_id::create("maximum_token_sequence_inst");
    maximum_token_sequence_inst.scenario = 2;
    maximum_token_sequence_inst.start(env.agent.sqr);
    `uvm_info(get_type_name(), $sformatf("maximum_token_sequence scenario 2 is completed"), UVM_MEDIUM)
    
    // Add drain time to allow transactions to complete
    #1000;
    phase.drop_objection(this);
  endtask
endclass
