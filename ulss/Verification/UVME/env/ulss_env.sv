class ulss_env extends uvm_env;

  //factory registration
  `uvm_component_utils(ulss_env)

  //creating agent handle
   ulss_agent agent;
  ulss_coverage cov;
  //ulss_scoreboard sbd;

  //constructor
  function new(string name = "ulss_env",uvm_component parent=null);
    super.new(name,parent);
    `uvm_info("env_class", "Inside constructor!", UVM_HIGH)
  endfunction

  //build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent = ulss_agent::type_id::create("ulss_agent",this); 
    cov = ulss_coverage::type_id::create("cov",this);
   //sbd = ulss_scoreboard::type_id::create("sbd",this);
   `uvm_info("env_class", "Inside Build Phase!", UVM_HIGH)
  endfunction

  //connect phase
  function void connect_phase(uvm_phase phase);
    agent.mon.analysis_port.connect(cov.analysis_export);
    //agent.mon.sop_analysis_port.connect(cov.sop_analysis_export);
    //agent.mon.eop_analysis_port.connect(cov.eop_analysis_export);
    //agent.mon.stream_analysis_port.connect(cov.stream_analysis_export);
       //agent.mon.analysis_port.connect(sbd.dut_analysis_imp);

    //  agent.mon.mon_ap.connect(cov.analysis_export);
   // agent.mon.mon_ap.connect(sbd.dut_analysis_imp);

   `uvm_info("env_class", "Inside connect Phase!", UVM_HIGH)
  endfunction
  
endclass



/*class ulss_env extends uvm_env;
    // Factory registration
    `uvm_component_utils(ulss_env)
    
    // Creating handles
    ulss_agent agent;
    ulss_coverage cov;
    ulss_scoreboard sbd;
    
    // Constructor
    function new(string name = "ulss_env", uvm_component parent=null);
        super.new(name, parent);
        `uvm_info("env_class", "Inside constructor!", UVM_HIGH)
    endfunction
    
    // Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agent = ulss_agent::type_id::create("agent", this);
        cov = ulss_coverage::type_id::create("cov", this);
        sbd = ulss_scoreboard::type_id::create("sbd", this);
        `uvm_info("env_class", "Inside Build Phase!", UVM_HIGH)
    endfunction
    
    // Connect phase
    function void connect_phase(uvm_phase phase);
        // Connect only the main analysis port which should be properly defined
        agent.mon.analysis_port.connect(cov.analysis_export);
       // agent.mon.analysis_port.connect(sbd.analysis_imp);
        
        // Remove the problematic connections to the specialized ports
        // that are causing compilation errors
        
        `uvm_info("env_class", "Inside connect Phase!", UVM_HIGH)
    endfunction
endclass*/
