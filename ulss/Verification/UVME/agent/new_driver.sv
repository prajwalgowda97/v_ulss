class ulss_driver extends uvm_driver #(ulss_tx);

  // Factory registration
  `uvm_component_utils_begin(ulss_driver)
    `uvm_field_int(wait_timeout_cycles, UVM_ALL_ON)
    `uvm_field_int(simulation_timeout_cycles, UVM_ALL_ON)
  `uvm_component_utils_end

  // Creating interface and sequence item handle
  ulss_tx tx;
  virtual ulss_interface vif;

  // Control flags - Defines a control flag to gracefully stop the driver when needed
  bit stop_driver = 0;
  
  // Timeout parameters for wait statements - Made configurable
  int wait_timeout_cycles = 100;       // Default for regular tests
  int simulation_timeout_cycles = 10000; // Default for regular tests

  // Constructor
  function new(string name = "ulss_driver", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    tx = ulss_tx::type_id::create("tx");
    if(!uvm_config_db#(virtual ulss_interface)::get(this,"*","ulss_interface",vif))
      `uvm_fatal(get_full_name(),"Unable to get interface in driver")
      
    // Get timeout configurations from test if provided
    void'(uvm_config_db#(int)::get(this, "", "wait_timeout_cycles", wait_timeout_cycles));
    void'(uvm_config_db#(int)::get(this, "", "simulation_timeout_cycles", simulation_timeout_cycles));
    
    `uvm_info(get_type_name(), $sformatf("Using wait_timeout_cycles=%0d, simulation_timeout_cycles=%0d", 
              wait_timeout_cycles, simulation_timeout_cycles), UVM_LOW)
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    
    // Initial setup 
    vif.rate_limiter_16to4_rstn <= 1'b0;
    vif.rate_limiter_16to4_sw_rst <= 1'b1;
    vif.sch_reg_wr_en <= 1'b0;
    vif.sch_reg_wr_addr <= 5'b0;
    vif.sch_reg_wr_data <= 64'b0;
    
    // Initialize all input stream signals
    initialize_all_streams();
    
    // Hold reset for enough cycles for stable reset
    repeat(10) @(posedge vif.rate_limiter_16to4_clk); 
    
    // Release reset
    vif.rate_limiter_16to4_rstn <= 1'b1;
    vif.rate_limiter_16to4_sw_rst <= 1'b0;
    
    // Additional stabilization after reset release
    repeat(10) @(posedge vif.rate_limiter_16to4_clk); 

    fork
      // Main driver process
      begin
        while (!stop_driver) begin
          seq_item_port.get_next_item(tx);
          
          `uvm_info(get_type_name(), $sformatf("Driver received item: rst=%0d", tx.rate_limiter_16to4_rstn), UVM_DEBUG)
          
          // Apply transaction to the interface
          drive_transaction(tx);
          
          // Mark transaction as done - CORRECTLY PAIRED with get_next_item()
          seq_item_port.item_done();
          
          // Wait for one clock cycle before next transaction
          @(posedge vif.rate_limiter_16to4_clk);
        end
      end
      
      // Simulation watchdog - Now using configurable timeout
      begin
        // Overall simulation timeout (configurable)
        repeat(simulation_timeout_cycles) @(posedge vif.rate_limiter_16to4_clk);
        `uvm_warning(get_type_name(), $sformatf("Global simulation timeout reached (%0d cycles), ending simulation", simulation_timeout_cycles))
        stop_driver = 1;
      end
    join_any
    
    // Wait a few more cycles to complete any pending transactions
    repeat(10) @(posedge vif.rate_limiter_16to4_clk);
    phase.drop_objection(this);
  endtask
  
  task initialize_all_streams();
    // Initialize all input stream signals to 1'b0
    vif.in_sop_0 <= 1'b0; vif.in_stream_0 <= 64'b0; vif.in_eop_0 <= 1'b0;
    vif.in_sop_1 <= 1'b0; vif.in_stream_1 <= 64'b0; vif.in_eop_1 <= 1'b0;
    vif.in_sop_2 <= 1'b0; vif.in_stream_2 <= 64'b0; vif.in_eop_2 <= 1'b0;
    vif.in_sop_3 <= 1'b0; vif.in_stream_3 <= 64'b0; vif.in_eop_3 <= 1'b0;
    vif.in_sop_4 <= 1'b0; vif.in_stream_4 <= 64'b0; vif.in_eop_4 <= 1'b0;
    vif.in_sop_5 <= 1'b0; vif.in_stream_5 <= 64'b0; vif.in_eop_5 <= 1'b0;
    vif.in_sop_6 <= 1'b0; vif.in_stream_6 <= 64'b0; vif.in_eop_6 <= 1'b0;
    vif.in_sop_7 <= 1'b0; vif.in_stream_7 <= 64'b0; vif.in_eop_7 <= 1'b0;
    vif.in_sop_8 <= 1'b0; vif.in_stream_8 <= 64'b0; vif.in_eop_8 <= 1'b0;
    vif.in_sop_9 <= 1'b0; vif.in_stream_9 <= 64'b0; vif.in_eop_9 <= 1'b0;
    vif.in_sop_10 <= 1'b0; vif.in_stream_10 <= 64'b0; vif.in_eop_10 <= 1'b0;
    vif.in_sop_11 <= 1'b0; vif.in_stream_11 <= 64'b0; vif.in_eop_11 <= 1'b0;
    vif.in_sop_12 <= 1'b0; vif.in_stream_12 <= 64'b0; vif.in_eop_12 <= 1'b0;
    vif.in_sop_13 <= 1'b0; vif.in_stream_13 <= 64'b0; vif.in_eop_13 <= 1'b0;
    vif.in_sop_14 <= 1'b0; vif.in_stream_14 <= 64'b0; vif.in_eop_14 <= 1'b0;
    vif.in_sop_15 <= 1'b0; vif.in_stream_15 <= 64'b0; vif.in_eop_15 <= 1'b0;

    // Initialize all pck_str_empty signals to 1'b1 (empty)
    vif.pck_str_empty_0 <= 1'b1;
    vif.pck_str_empty_1 <= 1'b1;
    vif.pck_str_empty_2 <= 1'b1;
    vif.pck_str_empty_3 <= 1'b1;
    vif.pck_str_empty_4 <= 1'b1;
    vif.pck_str_empty_5 <= 1'b1;
    vif.pck_str_empty_6 <= 1'b1;
    vif.pck_str_empty_7 <= 1'b1;
    vif.pck_str_empty_8 <= 1'b1;
    vif.pck_str_empty_9 <= 1'b1;
    vif.pck_str_empty_10 <= 1'b1;
    vif.pck_str_empty_11 <= 1'b1;
    vif.pck_str_empty_12 <= 1'b1;
    vif.pck_str_empty_13 <= 1'b1;
    vif.pck_str_empty_14 <= 1'b1;
    vif.pck_str_empty_15 <= 1'b1;
  endtask
  
  // Task to drive a single transaction
  task drive_transaction(ulss_tx tx);
    
    if (tx.sch_reg_wr_en) begin
      vif.sch_reg_wr_addr <= tx.sch_reg_wr_addr;
      vif.sch_reg_wr_data <= tx.sch_reg_wr_data;

      `uvm_info(get_type_name(), $sformatf("[DRV] WRITE ADDR=%0d DATA=0x%0h", tx.sch_reg_wr_addr, tx.sch_reg_wr_data), UVM_LOW)
      // Assert sch_reg_wr_en for ONLY ONE cycle
      vif.sch_reg_wr_en <= 1'b1;
      @(posedge vif.rate_limiter_16to4_clk);
      vif.sch_reg_wr_en <= 1'b0;
      
      
      // Allow some time for register write to take effect
      repeat(5) @(posedge vif.rate_limiter_16to4_clk);
    end 

    // If reset is inactive, then proceed with packet transfer
    if (tx.rate_limiter_16to4_rstn == 1'b1 && tx.rate_limiter_16to4_sw_rst == 1'b0) begin
      // Set all pck_str_empty signals according to the transaction
      drive_pck_str_empty_signals(tx);
      
         
     drive_all_streams(tx);
  end

  endtask
  
  // Helper task to set all pck_str_empty signals
  task drive_pck_str_empty_signals(ulss_tx tx);
    vif.pck_str_empty_0 <= tx.pck_str_empty_0;
    vif.pck_str_empty_1 <= tx.pck_str_empty_1;
    vif.pck_str_empty_2 <= tx.pck_str_empty_2;
    vif.pck_str_empty_3 <= tx.pck_str_empty_3;
    vif.pck_str_empty_4 <= tx.pck_str_empty_4;
    vif.pck_str_empty_5 <= tx.pck_str_empty_5;
    vif.pck_str_empty_6 <= tx.pck_str_empty_6;
    vif.pck_str_empty_7 <= tx.pck_str_empty_7;
    vif.pck_str_empty_8 <= tx.pck_str_empty_8;
    vif.pck_str_empty_9 <= tx.pck_str_empty_9;
    vif.pck_str_empty_10 <= tx.pck_str_empty_10;
    vif.pck_str_empty_11 <= tx.pck_str_empty_11;
    vif.pck_str_empty_12 <= tx.pck_str_empty_12;
    vif.pck_str_empty_13 <= tx.pck_str_empty_13;
    vif.pck_str_empty_14 <= tx.pck_str_empty_14;
    vif.pck_str_empty_15 <= tx.pck_str_empty_15;
    
    // Allow two clock cycles for pck_str_empty signals to propagate
    repeat(2) @(posedge vif.rate_limiter_16to4_clk);
  endtask


  ///////////////////////////////////////////////////////
  // Task to drive all streams regardless of empty status
task drive_all_streams(ulss_tx tx);
  // Drive all 16 streams
  for (int i = 0; i < 16; i++) begin
    if (get_stream_empty(tx, i) == 1'b0) begin
      // If stream is not empty, drive the actual data
      drive_stream(i, tx);
    end else begin
      // If stream is empty, explicitly drive idle values
      case (i)
        0: begin vif.in_sop_0 <= 1'b0; vif.in_stream_0 <= 64'h0; vif.in_eop_0 <= 1'b0; end
        1: begin vif.in_sop_1 <= 1'b0; vif.in_stream_1 <= 64'h0; vif.in_eop_1 <= 1'b0; end
        2: begin vif.in_sop_2 <= 1'b0; vif.in_stream_2 <= 64'h0; vif.in_eop_2 <= 1'b0; end
        3: begin vif.in_sop_3 <= 1'b0; vif.in_stream_3 <= 64'h0; vif.in_eop_3 <= 1'b0; end
        4: begin vif.in_sop_4 <= 1'b0; vif.in_stream_4 <= 64'h0; vif.in_eop_4 <= 1'b0; end
        5: begin vif.in_sop_5 <= 1'b0; vif.in_stream_5 <= 64'h0; vif.in_eop_5 <= 1'b0; end
        6: begin vif.in_sop_6 <= 1'b0; vif.in_stream_6 <= 64'h0; vif.in_eop_6 <= 1'b0; end
        7: begin vif.in_sop_7 <= 1'b0; vif.in_stream_7 <= 64'h0; vif.in_eop_7 <= 1'b0; end
        8: begin vif.in_sop_8 <= 1'b0; vif.in_stream_8 <= 64'h0; vif.in_eop_8 <= 1'b0; end
        9: begin vif.in_sop_9 <= 1'b0; vif.in_stream_9 <= 64'h0; vif.in_eop_9 <= 1'b0; end
        10: begin vif.in_sop_10 <= 1'b0; vif.in_stream_10 <= 64'h0; vif.in_eop_10 <= 1'b0; end
        11: begin vif.in_sop_11 <= 1'b0; vif.in_stream_11 <= 64'h0; vif.in_eop_11 <= 1'b0; end
        12: begin vif.in_sop_12 <= 1'b0; vif.in_stream_12 <= 64'h0; vif.in_eop_12 <= 1'b0; end
        13: begin vif.in_sop_13 <= 1'b0; vif.in_stream_13 <= 64'h0; vif.in_eop_13 <= 1'b0; end
        14: begin vif.in_sop_14 <= 1'b0; vif.in_stream_14 <= 64'h0; vif.in_eop_14 <= 1'b0; end
        15: begin vif.in_sop_15 <= 1'b0; vif.in_stream_15 <= 64'h0; vif.in_eop_15 <= 1'b0; end
      endcase
      
      `uvm_info(get_type_name(), $sformatf("[DRV] Setting stream %0d to idle state", i), UVM_DEBUG)
    end
  end
  
  // Wait for one clock cycle to ensure all values are properly latched
  @(posedge vif.rate_limiter_16to4_clk);
endtask
  
  // Helper function to get the empty status for a specific stream
  function bit get_stream_empty(ulss_tx tx, int stream_num);
    case (stream_num)
      0: return tx.pck_str_empty_0;
      1: return tx.pck_str_empty_1;
      2: return tx.pck_str_empty_2;
      3: return tx.pck_str_empty_3;
      4: return tx.pck_str_empty_4;
      5: return tx.pck_str_empty_5;
      6: return tx.pck_str_empty_6;
      7: return tx.pck_str_empty_7;
      8: return tx.pck_str_empty_8;
      9: return tx.pck_str_empty_9;
      10: return tx.pck_str_empty_10;
      11: return tx.pck_str_empty_11;
      12: return tx.pck_str_empty_12;
      13: return tx.pck_str_empty_13;
      14: return tx.pck_str_empty_14;
      15: return tx.pck_str_empty_15;
      default: return 1'b1;
    endcase
  endfunction
  
  // Drive a specific stream - Now with adaptive timeout based on test needs
  task drive_stream(int stream_num, ulss_tx tx);
    bit timeout = 0;
    bit wait_grant_done = 0;
    string rd_en_grnt_name = $sformatf("pck_rd_en_grnt_%0d", stream_num);
    
    // First check if grant is already active
    if (is_grant_active(stream_num)) begin
      wait_grant_done = 1;
      `uvm_info(get_type_name(), $sformatf("[DRV] Grant for stream %0d already active", stream_num), UVM_LOW)
    end
    
    // Only wait for grant if not already active
    if (!wait_grant_done) begin
      // Wait for the grant signal or timeout with configurable timeout
      fork
        begin
          case (stream_num)
            0: wait(vif.pck_rd_en_grnt_0);
            1: wait(vif.pck_rd_en_grnt_1);
            2: wait(vif.pck_rd_en_grnt_2);
            3: wait(vif.pck_rd_en_grnt_3);
            4: wait(vif.pck_rd_en_grnt_4);
            5: wait(vif.pck_rd_en_grnt_5);
            6: wait(vif.pck_rd_en_grnt_6);
            7: wait(vif.pck_rd_en_grnt_7);
            8: wait(vif.pck_rd_en_grnt_8);
            9: wait(vif.pck_rd_en_grnt_9);
            10: wait(vif.pck_rd_en_grnt_10);
            11: wait(vif.pck_rd_en_grnt_11);
            12: wait(vif.pck_rd_en_grnt_12);
            13: wait(vif.pck_rd_en_grnt_13);
            14: wait(vif.pck_rd_en_grnt_14);
            15: wait(vif.pck_rd_en_grnt_15);
          endcase
          wait_grant_done = 1;
        end
        begin
          repeat(wait_timeout_cycles) @(posedge vif.rate_limiter_16to4_clk);
          timeout = 1;
        end
      join_any
      disable fork;
    end
    
    // Check if timed out
    if (timeout) begin
      bit is_granted = is_grant_active(stream_num);
      
      if (!is_granted) begin
        // Try to recover by clearing and resetting empty signal
        `uvm_warning(get_type_name(), $sformatf("Timeout waiting for %s after %0d cycles - attempting recovery", 
                                               rd_en_grnt_name, wait_timeout_cycles))
        
        // Toggle the empty signal to attempt recovery
        case (stream_num)
          0: vif.pck_str_empty_0 = 1'b1;
          1: vif.pck_str_empty_1 = 1'b1;
          2: vif.pck_str_empty_2 = 1'b1;
          3: vif.pck_str_empty_3 = 1'b1;
          4: vif.pck_str_empty_4 = 1'b1;
          5: vif.pck_str_empty_5 = 1'b1;
          6: vif.pck_str_empty_6 = 1'b1;
          7: vif.pck_str_empty_7 = 1'b1;
          8: vif.pck_str_empty_8 = 1'b1;
          9: vif.pck_str_empty_9 = 1'b1;
          10: vif.pck_str_empty_10 = 1'b1;
          11: vif.pck_str_empty_11 = 1'b1;
          12: vif.pck_str_empty_12 = 1'b1;
          13: vif.pck_str_empty_13 = 1'b1;
          14: vif.pck_str_empty_14 = 1'b1;
          15: vif.pck_str_empty_15 = 1'b1;
        endcase
        
        repeat(10) @(posedge vif.rate_limiter_16to4_clk);
        
        // Try again
        case (stream_num)
          0: vif.pck_str_empty_0 = tx.pck_str_empty_0;
          1: vif.pck_str_empty_1 = tx.pck_str_empty_1;
          2: vif.pck_str_empty_2 = tx.pck_str_empty_2;
          3: vif.pck_str_empty_3 = tx.pck_str_empty_3;
          4: vif.pck_str_empty_4 = tx.pck_str_empty_4;
          5: vif.pck_str_empty_5 = tx.pck_str_empty_5;
          6: vif.pck_str_empty_6 = tx.pck_str_empty_6;
          7: vif.pck_str_empty_7 = tx.pck_str_empty_7;
          8: vif.pck_str_empty_8 = tx.pck_str_empty_8;
          9: vif.pck_str_empty_9 = tx.pck_str_empty_9;
          10: vif.pck_str_empty_10 = tx.pck_str_empty_10;
          11: vif.pck_str_empty_11 = tx.pck_str_empty_11;
          12: vif.pck_str_empty_12 = tx.pck_str_empty_12;
          13: vif.pck_str_empty_13 = tx.pck_str_empty_13;
          14: vif.pck_str_empty_14 = tx.pck_str_empty_14;
          15: vif.pck_str_empty_15 = tx.pck_str_empty_15;
        endcase
        
        repeat(20) @(posedge vif.rate_limiter_16to4_clk);
        
        // Check again
        is_granted = is_grant_active(stream_num);
        
        if (!is_granted)
          `uvm_error(get_type_name(), $sformatf("Recovery failed for %s - skipping packet", rd_en_grnt_name))
          return; // Skip driving this stream if recovery failed
      end
    end
    
    // Drive the stream data
    case (stream_num)
      0: begin 
        vif.in_sop_0 <= tx.in_sop_0; 
        vif.in_stream_0 <= tx.in_stream_0; 
        vif.in_eop_0 <= tx.in_eop_0; 
        `uvm_info(get_type_name(), $sformatf("[DRV] Driving stream 0: data=0x%0h, sop=%0d, eop=%0d", 
                 tx.in_stream_0, tx.in_sop_0, tx.in_eop_0), UVM_LOW)
      end
      1: begin vif.in_sop_1 <= tx.in_sop_1; vif.in_stream_1 <= tx.in_stream_1; vif.in_eop_1 <= tx.in_eop_1; end
      2: begin vif.in_sop_2 <= tx.in_sop_2; vif.in_stream_2 <= tx.in_stream_2; vif.in_eop_2 <= tx.in_eop_2; end
      3: begin vif.in_sop_3 <= tx.in_sop_3; vif.in_stream_3 <= tx.in_stream_3; vif.in_eop_3 <= tx.in_eop_3; end
      4: begin vif.in_sop_4 <= tx.in_sop_4; vif.in_stream_4 <= tx.in_stream_4; vif.in_eop_4 <= tx.in_eop_4; end
      5: begin vif.in_sop_5 <= tx.in_sop_5; vif.in_stream_5 <= tx.in_stream_5; vif.in_eop_5 <= tx.in_eop_5; end
      6: begin vif.in_sop_6 <= tx.in_sop_6; vif.in_stream_6 <= tx.in_stream_6; vif.in_eop_6 <= tx.in_eop_6; end
      7: begin vif.in_sop_7 <= tx.in_sop_7; vif.in_stream_7 <= tx.in_stream_7; vif.in_eop_7 <= tx.in_eop_7; end
      8: begin vif.in_sop_8 <= tx.in_sop_8; vif.in_stream_8 <= tx.in_stream_8; vif.in_eop_8 <= tx.in_eop_8; end
      9: begin vif.in_sop_9 <= tx.in_sop_9; vif.in_stream_9 <= tx.in_stream_9; vif.in_eop_9 <= tx.in_eop_9; end
      10: begin vif.in_sop_10 <= tx.in_sop_10; vif.in_stream_10 <= tx.in_stream_10; vif.in_eop_10 <= tx.in_eop_10; end
      11: begin vif.in_sop_11 <= tx.in_sop_11; vif.in_stream_11 <= tx.in_stream_11; vif.in_eop_11 <= tx.in_eop_11; end
      12: begin vif.in_sop_12 <= tx.in_sop_12; vif.in_stream_12 <= tx.in_stream_12; vif.in_eop_12 <= tx.in_eop_12; end
      13: begin vif.in_sop_13 <= tx.in_sop_13; vif.in_stream_13 <= tx.in_stream_13; vif.in_eop_13 <= tx.in_eop_13; end
      14: begin vif.in_sop_14 <= tx.in_sop_14; vif.in_stream_14 <= tx.in_stream_14; vif.in_eop_14 <= tx.in_eop_14; end
      15: begin vif.in_sop_15 <= tx.in_sop_15; vif.in_stream_15 <= tx.in_stream_15; vif.in_eop_15 <= tx.in_eop_15; end
    endcase
    
    // Hold data for one clock cycle to ensure it's sampled
    @(posedge vif.rate_limiter_16to4_clk);
  endtask
  
  // Helper function to check if grant is active
  function bit is_grant_active(int stream_num);
    case (stream_num)
      0: return vif.pck_rd_en_grnt_0;
      1: return vif.pck_rd_en_grnt_1;
      2: return vif.pck_rd_en_grnt_2;
      3: return vif.pck_rd_en_grnt_3;
      4: return vif.pck_rd_en_grnt_4;
      5: return vif.pck_rd_en_grnt_5;
      6: return vif.pck_rd_en_grnt_6;
      7: return vif.pck_rd_en_grnt_7;
      8: return vif.pck_rd_en_grnt_8;
      9: return vif.pck_rd_en_grnt_9;
      10: return vif.pck_rd_en_grnt_10;
      11: return vif.pck_rd_en_grnt_11;
      12: return vif.pck_rd_en_grnt_12;
      13: return vif.pck_rd_en_grnt_13;
      14: return vif.pck_rd_en_grnt_14;
      15: return vif.pck_rd_en_grnt_15;
      default: return 1'b0;
    endcase
  endfunction
endclass

