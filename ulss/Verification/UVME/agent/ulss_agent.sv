class ulss_agent extends uvm_agent;
    //factory registration
    `uvm_component_utils(ulss_agent)

    //creating driver, monitor & sequencer handle
    ulss_driver drv;
    ulss_monitor mon;
    ulss_sequencer sqr;

    //constructor
    function new (string name = "ulss_agent", uvm_component parent=null);
      super.new(name, parent);
      `uvm_info("agent_class", "Inside constructor!", UVM_HIGH)
    endfunction
    
    //build phase
    function void build_phase (uvm_phase phase);
      super.build_phase(phase);
      drv = ulss_driver::type_id::create("drv",this);
      mon = ulss_monitor::type_id::create("mon",this);
      sqr = ulss_sequencer::type_id::create("sqr",this);
      `uvm_info("agent_class", "Inside Build Phase!", UVM_HIGH)
    endfunction
    
    //connect phase
    function void connect_phase (uvm_phase phase);
      super.connect_phase(phase);
      drv.seq_item_port.connect(sqr.seq_item_export);
      `uvm_info("agent_class", "Inside Connect Phase!", UVM_HIGH)
    endfunction

endclass

