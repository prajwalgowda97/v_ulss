class soft_reset_test extends ulss_base_test;

  //factory registration
  `uvm_component_utils(soft_reset_test)
   soft_reset_sequence soft_reset_sequence_inst;

  //constructor
  function new(string name = "soft_reset_test",uvm_component parent);
    super.new(name,parent);
    soft_reset_sequence_inst = soft_reset_sequence::type_id::create("soft_reset_sequence_inst");
  endfunction
 
  //build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  //run phase
  virtual task run_phase(uvm_phase phase);
    `uvm_info(get_full_name(),$sformatf("it test first line"),UVM_MEDIUM)
     phase.raise_objection(this);

    `uvm_info(get_type_name(),$sformatf("inside the soft_reset test"),UVM_MEDIUM)
    
    begin
        soft_reset_sequence_inst.scenario = 1;
        soft_reset_sequence_inst.start(env.agent.sqr);
    end  
    `uvm_info(get_type_name(),$sformatf("soft_reset scenario 1 is completed"),UVM_MEDIUM)
    
      // phase.phase_done.set_drain_time(this,1000);
#1000;
     phase.drop_objection(this);
  endtask

endclass 

