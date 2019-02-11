class reg_fifteen_test extends ulss_base_test;
  // Factory registration
  `uvm_component_utils(reg_fifteen_test)
  
  // Constructor
  function new(string name = "reg_fifteen_test", uvm_component parent);
    super.new(name, parent);
  endfunction
 
  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
  // Run phase
  virtual task run_phase(uvm_phase phase);
    reg_fifteen  reg_fifteen_inst;  // Declare separate sequence instances
    
    `uvm_info(get_full_name(), $sformatf("it test first line"), UVM_MEDIUM)
     phase.raise_objection(this);
    `uvm_info(get_type_name(), $sformatf("inside the in_stream_zero_reg test"), UVM_MEDIUM)
       
    // Create and run scenario 2
    reg_fifteen_inst = reg_fifteen::type_id::create("reg_fifteen_inst");
    reg_fifteen_inst.scenario = 2;
    reg_fifteen_inst.start(env.agent.sqr);
    `uvm_info(get_type_name(), $sformatf("reg_fifteen_test scenario 2 is completed"), UVM_MEDIUM)
    
    // Add drain time to allow transactions to complete
    #1000;
    phase.drop_objection(this);
  endtask
endclass
