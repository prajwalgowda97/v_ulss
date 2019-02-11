class ulss_base_test extends uvm_test;

  //factory registration
  `uvm_component_utils(ulss_base_test)

  //creating environment and sequence handle
   ulss_env env;
   ulss_base_sequence base_seq;

  
  //constructor
  function new(string name = "ulss_base_test",uvm_component parent=null);
    super.new(name,parent);
  endfunction
 
  //build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = ulss_env::type_id::create("env",this);
    base_seq = ulss_base_sequence::type_id::create("base_seq"); 

  endfunction


//end of elaboration phase
	function void end_of_elaboration_phase(uvm_phase phase);
		uvm_top.print_topology();
	endfunction

task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    #1000;
   `uvm_info(get_name(),$sformatf("inside the base test"),UVM_MEDIUM)
    phase.drop_objection(this);
  endtask

endclass 

