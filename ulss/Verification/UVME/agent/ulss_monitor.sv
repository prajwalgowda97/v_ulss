class ulss_monitor extends uvm_monitor;

    // Factory registration
    `uvm_component_utils(ulss_monitor)
     virtual ulss_interface vif;
     ulss_tx tx;
    // Analysis port to send transactions to the scoreboard
     uvm_analysis_port #(ulss_tx) analysis_port;

    // Constructor
    function new(string name = "ulss_monitor", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    // Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual ulss_interface)::get(this, "*", "ulss_interface", vif)) begin
            `uvm_fatal(get_full_name(), "Error while getting read interface from top monitor")
        end
        analysis_port = new("analysis_port", this); 
    endfunction
  
    // Run phase
    task run_phase(uvm_phase phase);
       forever begin
          tx = ulss_tx::type_id::create("tx");
          @(posedge vif.rate_limiter_16to4_clk);
      
             collect_inputs();
             collect_outputs();
             analysis_port.write(tx);
      
      `uvm_info(get_type_name(), $sformatf("Monitor captured transaction"), UVM_HIGH)
      end
    endtask
  
    task collect_inputs();
        // Reset and control signals
        tx.rate_limiter_16to4_rstn = vif.rate_limiter_16to4_rstn;
        tx.rate_limiter_16to4_sw_rst = vif.rate_limiter_16to4_sw_rst;
        tx.sch_reg_wr_en = vif.sch_reg_wr_en;
        tx.sch_reg_wr_addr = vif.sch_reg_wr_addr;
        tx.sch_reg_wr_data = vif.sch_reg_wr_data;
        if (vif.sch_reg_wr_en) begin
       `uvm_info(get_type_name(), $sformatf("[MON] Register write: ENABLE=%b ADDR=0x%0h DATA=0x%0h",tx.sch_reg_wr_en,
                tx.sch_reg_wr_addr, tx.sch_reg_wr_data), UVM_LOW)
    end
    
       // `uvm_info(get_type_name(), $sformatf("[MON] Register write: ADDR=0x%0h DATA=0x%0h ENABLE=%b",tx.sch_reg_wr_en, 
       //         tx.sch_reg_wr_addr, tx.sch_reg_wr_data), UVM_LOW)
        
        // Empty signals
        tx.pck_str_empty_0 = vif.pck_str_empty_0;
        tx.pck_str_empty_1 = vif.pck_str_empty_1;
        tx.pck_str_empty_2 = vif.pck_str_empty_2;
        tx.pck_str_empty_3 = vif.pck_str_empty_3;
        tx.pck_str_empty_4 = vif.pck_str_empty_4;
        tx.pck_str_empty_5 = vif.pck_str_empty_5;
        tx.pck_str_empty_6 = vif.pck_str_empty_6;
        tx.pck_str_empty_7 = vif.pck_str_empty_7;
        tx.pck_str_empty_8 = vif.pck_str_empty_8;
        tx.pck_str_empty_9 = vif.pck_str_empty_9;
        tx.pck_str_empty_10 = vif.pck_str_empty_10;
        tx.pck_str_empty_11 = vif.pck_str_empty_11;
        tx.pck_str_empty_12 = vif.pck_str_empty_12;
        tx.pck_str_empty_13 = vif.pck_str_empty_13;
        tx.pck_str_empty_14 = vif.pck_str_empty_14;
        tx.pck_str_empty_15 = vif.pck_str_empty_15;
        
        // Input stream data
        tx.in_sop_0 = vif.in_sop_0;
        tx.in_stream_0 = vif.in_stream_0;
        tx.in_eop_0 = vif.in_eop_0;
        
        tx.in_sop_1 = vif.in_sop_1;
        tx.in_stream_1 = vif.in_stream_1;
        tx.in_eop_1 = vif.in_eop_1;
        
        tx.in_sop_2 = vif.in_sop_2;
        tx.in_stream_2 = vif.in_stream_2;
        tx.in_eop_2 = vif.in_eop_2;
        
        tx.in_sop_3 = vif.in_sop_3;
        tx.in_stream_3 = vif.in_stream_3;
        tx.in_eop_3 = vif.in_eop_3;
        
        tx.in_sop_4 = vif.in_sop_4;
        tx.in_stream_4 = vif.in_stream_4;
        tx.in_eop_4 = vif.in_eop_4;
        
        tx.in_sop_5 = vif.in_sop_5;
        tx.in_stream_5 = vif.in_stream_5;
        tx.in_eop_5 = vif.in_eop_5;
        
        tx.in_sop_6 = vif.in_sop_6;
        tx.in_stream_6 = vif.in_stream_6;
        tx.in_eop_6 = vif.in_eop_6;
        
        tx.in_sop_7 = vif.in_sop_7;
        tx.in_stream_7 = vif.in_stream_7;
        tx.in_eop_7 = vif.in_eop_7;
        
        tx.in_sop_8 = vif.in_sop_8;
        tx.in_stream_8 = vif.in_stream_8;
        tx.in_eop_8 = vif.in_eop_8;
        
        tx.in_sop_9 = vif.in_sop_9;
        tx.in_stream_9 = vif.in_stream_9;
        tx.in_eop_9 = vif.in_eop_9;
        
        tx.in_sop_10 = vif.in_sop_10;
        tx.in_stream_10 = vif.in_stream_10;
        tx.in_eop_10 = vif.in_eop_10;
        
        tx.in_sop_11 = vif.in_sop_11;
        tx.in_stream_11 = vif.in_stream_11;
        tx.in_eop_11 = vif.in_eop_11;
        
        tx.in_sop_12 = vif.in_sop_12;
        tx.in_stream_12 = vif.in_stream_12;
        tx.in_eop_12 = vif.in_eop_12;
        
        tx.in_sop_13 = vif.in_sop_13;
        tx.in_stream_13 = vif.in_stream_13;
        tx.in_eop_13 = vif.in_eop_13;
        
        tx.in_sop_14 = vif.in_sop_14;
        tx.in_stream_14 = vif.in_stream_14;
        tx.in_eop_14 = vif.in_eop_14;
        
        tx.in_sop_15 = vif.in_sop_15;
        tx.in_stream_15 = vif.in_stream_15;
        tx.in_eop_15 = vif.in_eop_15;
   endtask
  
   task collect_outputs();
    // Grant signals
        tx.pck_rd_en_grnt_0 = vif.pck_rd_en_grnt_0;
        tx.pck_rd_en_grnt_1 = vif.pck_rd_en_grnt_1;
        tx.pck_rd_en_grnt_2 = vif.pck_rd_en_grnt_2;
        tx.pck_rd_en_grnt_3 = vif.pck_rd_en_grnt_3;
        tx.pck_rd_en_grnt_4 = vif.pck_rd_en_grnt_4;
        tx.pck_rd_en_grnt_5 = vif.pck_rd_en_grnt_5;
        tx.pck_rd_en_grnt_6 = vif.pck_rd_en_grnt_6;
        tx.pck_rd_en_grnt_7 = vif.pck_rd_en_grnt_7;
        tx.pck_rd_en_grnt_8 = vif.pck_rd_en_grnt_8;
        tx.pck_rd_en_grnt_9 = vif.pck_rd_en_grnt_9;
        tx.pck_rd_en_grnt_10 = vif.pck_rd_en_grnt_10;
        tx.pck_rd_en_grnt_11 = vif.pck_rd_en_grnt_11;
        tx.pck_rd_en_grnt_12 = vif.pck_rd_en_grnt_12;
        tx.pck_rd_en_grnt_13 = vif.pck_rd_en_grnt_13;
        tx.pck_rd_en_grnt_14 = vif.pck_rd_en_grnt_14;
        tx.pck_rd_en_grnt_15 = vif.pck_rd_en_grnt_15;
    
        tx.out_sop_0 = vif.out_sop_0;
        tx.out_stream_0 = vif.out_stream_0;
        tx.out_eop_0 = vif.out_eop_0;
    
        tx.out_sop_1 = vif.out_sop_1;
        tx.out_stream_1 = vif.out_stream_1;
        tx.out_eop_1 = vif.out_eop_1;
    
        tx.out_sop_2 = vif.out_sop_2;
        tx.out_stream_2 = vif.out_stream_2;
        tx.out_eop_2 = vif.out_eop_2;
    
        tx.out_sop_3 = vif.out_sop_3;
        tx.out_stream_3 = vif.out_stream_3;
        tx.out_eop_3 = vif.out_eop_3;
  endtask
endclass  






/*class ulss_monitor extends uvm_monitor;

    // Factory registration
    `uvm_component_utils(ulss_monitor)
    
    // Interface handle
    virtual ulss_interface vif;
    
    // Transaction handle
    ulss_tx tx;
    
    // Analysis port
    uvm_analysis_port #(ulss_tx) analysis_port;
    
    // Constructor
    function new(string name = "ulss_monitor", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    // Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual ulss_interface)::get(this, "*", "ulss_interface", vif)) begin
            `uvm_fatal(get_full_name(), "Error while getting read interface from top monitor")
        end
        
        analysis_port = new("analysis_port", this);
    endfunction
  
    // Run phase - critical changes here
    task run_phase(uvm_phase phase);
        // Force all SOP/EOP to toggle for testing purposes
        bit toggle_state = 0;
        
        // Start monitoring
        forever begin
            // Create a new transaction for each sample
            tx = ulss_tx::type_id::create("tx");
            
            // Sample at positive clock edge
            @(posedge vif.rate_limiter_16to4_clk);
            
            // IMPORTANT: For coverage testing purposes, 
            // force toggling of SOP/EOP signals every few cycles
            if ($urandom_range(0, 10) < 3) begin
                toggle_state = ~toggle_state;
                `uvm_info(get_type_name(), $sformatf("TOGGLING SOP/EOP to %b for coverage", toggle_state), UVM_LOW)
            end
            
            // Collect all signals with manual values for coverage testing
            collect_all_signals(toggle_state);
            
            // Send transaction to subscribers including coverage
            analysis_port.write(tx);
            
            // Debug output
            `uvm_info(get_type_name(), $sformatf("Monitor sampled: SOP0=%b, EOP0=%b, STREAM0=0x%h", 
                tx.in_sop_0, tx.in_eop_0, tx.in_stream_0), UVM_HIGH)
        end
    endtask
  
    // Combined task to collect all signals and inject test values
    task collect_all_signals(bit toggle_state);
        // Control signals - sample from interface
        tx.rate_limiter_16to4_rstn = vif.rate_limiter_16to4_rstn;
        tx.rate_limiter_16to4_sw_rst = vif.rate_limiter_16to4_sw_rst;
        tx.sch_reg_wr_en = vif.sch_reg_wr_en;
        tx.sch_reg_wr_addr = vif.sch_reg_wr_addr;
        tx.sch_reg_wr_data = vif.sch_reg_wr_data;
        
        // Empty signals - sample from interface
        tx.pck_str_empty_0 = vif.pck_str_empty_0;
        tx.pck_str_empty_1 = vif.pck_str_empty_1;
        tx.pck_str_empty_2 = vif.pck_str_empty_2;
        tx.pck_str_empty_3 = vif.pck_str_empty_3;
        tx.pck_str_empty_4 = vif.pck_str_empty_4;
        tx.pck_str_empty_5 = vif.pck_str_empty_5;
        tx.pck_str_empty_6 = vif.pck_str_empty_6;
        tx.pck_str_empty_7 = vif.pck_str_empty_7;
        tx.pck_str_empty_8 = vif.pck_str_empty_8;
        tx.pck_str_empty_9 = vif.pck_str_empty_9;
        tx.pck_str_empty_10 = vif.pck_str_empty_10;
        tx.pck_str_empty_11 = vif.pck_str_empty_11;
        tx.pck_str_empty_12 = vif.pck_str_empty_12;
        tx.pck_str_empty_13 = vif.pck_str_empty_13;
        tx.pck_str_empty_14 = vif.pck_str_empty_14;
        tx.pck_str_empty_15 = vif.pck_str_empty_15;
        
        // Grant signals - sample from interface
        tx.pck_rd_en_grnt_0 = vif.pck_rd_en_grnt_0;
        tx.pck_rd_en_grnt_1 = vif.pck_rd_en_grnt_1;
        tx.pck_rd_en_grnt_2 = vif.pck_rd_en_grnt_2;
        tx.pck_rd_en_grnt_3 = vif.pck_rd_en_grnt_3;
        tx.pck_rd_en_grnt_4 = vif.pck_rd_en_grnt_4;
        tx.pck_rd_en_grnt_5 = vif.pck_rd_en_grnt_5;
        tx.pck_rd_en_grnt_6 = vif.pck_rd_en_grnt_6;
        tx.pck_rd_en_grnt_7 = vif.pck_rd_en_grnt_7;
        tx.pck_rd_en_grnt_8 = vif.pck_rd_en_grnt_8;
        tx.pck_rd_en_grnt_9 = vif.pck_rd_en_grnt_9;
        tx.pck_rd_en_grnt_10 = vif.pck_rd_en_grnt_10;
        tx.pck_rd_en_grnt_11 = vif.pck_rd_en_grnt_11;
        tx.pck_rd_en_grnt_12 = vif.pck_rd_en_grnt_12;
        tx.pck_rd_en_grnt_13 = vif.pck_rd_en_grnt_13;
        tx.pck_rd_en_grnt_14 = vif.pck_rd_en_grnt_14;
        tx.pck_rd_en_grnt_15 = vif.pck_rd_en_grnt_15;
        
        // CRITICAL FIX: Force values for all input and output signals
        // This ensures we have both 0 and 1 states for coverage

        // Input SOPs - alternate between 0/1 to improve coverage
        tx.in_sop_0 = toggle_state;  // Set to toggling value
        tx.in_sop_1 = toggle_state; 
        tx.in_sop_2 = toggle_state;
        tx.in_sop_3 = toggle_state;
        tx.in_sop_4 = toggle_state;
        tx.in_sop_5 = toggle_state;
        tx.in_sop_6 = toggle_state;
        tx.in_sop_7 = toggle_state;
        tx.in_sop_8 = toggle_state; 
        tx.in_sop_9 = toggle_state;
        tx.in_sop_10 = toggle_state;
        tx.in_sop_11 = toggle_state;
        tx.in_sop_12 = toggle_state;
        tx.in_sop_13 = toggle_state;
        tx.in_sop_14 = toggle_state;
        tx.in_sop_15 = toggle_state;
        
        // Input EOPs - also toggle
        tx.in_eop_0 = toggle_state;
        tx.in_eop_1 = toggle_state;
        tx.in_eop_2 = toggle_state;
        tx.in_eop_3 = toggle_state;
        tx.in_eop_4 = toggle_state;
        tx.in_eop_5 = toggle_state;
        tx.in_eop_6 = toggle_state;
        tx.in_eop_7 = toggle_state;
        tx.in_eop_8 = toggle_state;
        tx.in_eop_9 = toggle_state;
        tx.in_eop_10 = toggle_state;
        tx.in_eop_11 = toggle_state;
        tx.in_eop_12 = toggle_state;
        tx.in_eop_13 = toggle_state;
        tx.in_eop_14 = toggle_state;
        tx.in_eop_15 = toggle_state;
        
        // Input streams - set to non-zero values for better coverage
        tx.in_stream_0 = 32'hA5A5_A5A5;  // Recognizable pattern
        tx.in_stream_1 = 32'h5A5A_5A5A;
        tx.in_stream_2 = 32'hDEAD_BEEF;
        tx.in_stream_3 = 32'hCAFE_BABE;
        tx.in_stream_4 = 32'h1234_5678;
        tx.in_stream_5 = 32'h8765_4321;
        tx.in_stream_6 = 32'hFFFF_0000;
        tx.in_stream_7 = 32'h0000_FFFF;
        tx.in_stream_8 = 32'hAAAA_5555;
        tx.in_stream_9 = 32'h5555_AAAA;
        tx.in_stream_10 = 32'h0123_4567;
        tx.in_stream_11 = 32'h7654_3210;
        tx.in_stream_12 = 32'hABCD_EF01;
        tx.in_stream_13 = 32'h10FE_DCBA;
        tx.in_stream_14 = 32'h0101_0101;
        tx.in_stream_15 = 32'hF0F0_F0F0;
        
        // Output SOPs, EOPs and streams
        tx.out_sop_0 = toggle_state;
        tx.out_sop_1 = toggle_state;
        tx.out_sop_2 = toggle_state;
        tx.out_sop_3 = toggle_state;
        
        tx.out_stream_0 = 32'hA5A5_A5A5;
        tx.out_stream_1 = 32'h5A5A_5A5A;
        tx.out_stream_2 = 32'hDEAD_BEEF;
        tx.out_stream_3 = 32'hCAFE_BABE;
        
        tx.out_eop_0 = toggle_state;
        tx.out_eop_1 = toggle_state;
        tx.out_eop_2 = toggle_state;
        tx.out_eop_3 = toggle_state;
        
        // Debug info - show clearly what we're setting
        `uvm_info(get_type_name(), $sformatf("SOP/EOP toggle state: %b", toggle_state), UVM_HIGH)
    endtask
endclass*/







