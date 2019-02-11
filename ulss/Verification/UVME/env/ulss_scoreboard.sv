
class ulss_scoreboard extends uvm_scoreboard;
  // Factory registration
  `uvm_component_utils(ulss_scoreboard)
  
  // Analysis ports for DUT monitor
  uvm_analysis_imp#(ulss_tx, ulss_scoreboard) dut_analysis_imp;
  
  // Queues to store packets from DUT
  ulss_tx dut_tx_queue[$];
  
  // Queue for expected outputs from reference model
  typedef struct {
    bit [63:0] data;
    bit sop;
    bit eop;
    bit compared; // Flag to track if this expected output has been compared
    int cycle_id; // To track which cycle this output was generated in
  } expected_output_t;
  
  expected_output_t exp_outputs[4][$];
  
  // Transaction tracking
  int current_cycle_id; // Unique ID for each transaction cycle
  
  // Counters for tracking comparison results
  int match_count;
  int mismatch_count;
  
  // Tracking variables for debug/summary information
  static string active_inputs;
  static string active_grants;
  static string active_outputs;
  static int active_input_count;
  static int active_grant_count;
  static int active_output_count;
  static string summary;
  
  // For tracking transactions that have been processed
  bit [63:0] last_seen_data[4];
  bit last_seen_sop[4];
  bit last_seen_eop[4];
  bit output_already_processed[4];
  
  // Hash to track already seen transactions to avoid duplicate reporting
  bit [127:0] seen_transactions[bit[127:0]];
  
  // Constructor
  function new(string name = "ulss_scoreboard", uvm_component parent = null);
    super.new(name, parent);
    match_count = 0;
    mismatch_count = 0;
    active_inputs = "";
    active_grants = "";
    active_outputs = "";
    active_input_count = 0;
    active_grant_count = 0;
    active_output_count = 0;
    current_cycle_id = 0;
    
    // Initialize tracking variables
    foreach (last_seen_data[i]) begin
      last_seen_data[i] = 64'h0;
      last_seen_sop[i] = 0;
      last_seen_eop[i] = 0;
      output_already_processed[i] = 0;
    end
  endfunction
  
  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    // Create analysis ports
    dut_analysis_imp = new("dut_analysis_imp", this);
    
    `uvm_info(get_type_name(), "Scoreboard build phase completed", UVM_MEDIUM)
  endfunction
  
  // Connect phase
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info(get_type_name(), "Scoreboard connect phase completed", UVM_MEDIUM)
  endfunction
  
  // Generate a hash for the transaction to track duplicates
  function bit[127:0] generate_tx_hash(bit sop, bit [63:0] data, bit eop, int port);
    bit[127:0] hash;
    hash[0] = sop;
    hash[1] = eop;
    hash[65:2] = data;
    hash[71:66] = port[5:0];
    return hash;
  endfunction
  
  // Write function for DUT monitor transactions
  virtual function void write(ulss_tx tx);
    bit has_valid_data = 0;
    
    // Store the transaction for later processing
    dut_tx_queue.push_back(tx);
    
    // Check if this transaction has any valid data before processing
    has_valid_data = has_valid_inputs(tx) || has_valid_outputs(tx);
    
    if (has_valid_data) begin
      // Increment cycle counter for new transaction
      current_cycle_id++;
      
      // Reset output processing tracking
      foreach (output_already_processed[i]) begin
        output_already_processed[i] = 0;
      end
      
      // Process the input transaction through reference model to generate expected outputs
      reference_model(tx);
      
      // Compare DUT outputs with expected outputs
      check_outputs(tx);
      
      // Update summary information
      summary = $sformatf("[MON] Summary @ %0t: ", $time);
      
      `uvm_info(get_type_name(), $sformatf("Processed transaction from DUT monitor at time %0t", $time), UVM_HIGH)
    end
  endfunction
  
  // Check if transaction has any valid inputs
  function bit has_valid_inputs(ulss_tx tx);
    // Check for any valid input data with grants
    if ((tx.pck_rd_en_grnt_0 && (tx.in_sop_0 || tx.in_eop_0 || tx.in_stream_0 != 0)) ||
        (tx.pck_rd_en_grnt_1 && (tx.in_sop_1 || tx.in_eop_1 || tx.in_stream_1 != 0)) ||
        (tx.pck_rd_en_grnt_2 && (tx.in_sop_2 || tx.in_eop_2 || tx.in_stream_2 != 0)) ||
        (tx.pck_rd_en_grnt_3 && (tx.in_sop_3 || tx.in_eop_3 || tx.in_stream_3 != 0)) ||
        (tx.pck_rd_en_grnt_4 && (tx.in_sop_4 || tx.in_eop_4 || tx.in_stream_4 != 0)) ||
        (tx.pck_rd_en_grnt_5 && (tx.in_sop_5 || tx.in_eop_5 || tx.in_stream_5 != 0)) ||
        (tx.pck_rd_en_grnt_6 && (tx.in_sop_6 || tx.in_eop_6 || tx.in_stream_6 != 0)) ||
        (tx.pck_rd_en_grnt_7 && (tx.in_sop_7 || tx.in_eop_7 || tx.in_stream_7 != 0)) ||
        (tx.pck_rd_en_grnt_8 && (tx.in_sop_8 || tx.in_eop_8 || tx.in_stream_8 != 0)) ||
        (tx.pck_rd_en_grnt_9 && (tx.in_sop_9 || tx.in_eop_9 || tx.in_stream_9 != 0)) ||
        (tx.pck_rd_en_grnt_10 && (tx.in_sop_10 || tx.in_eop_10 || tx.in_stream_10 != 0)) ||
        (tx.pck_rd_en_grnt_11 && (tx.in_sop_11 || tx.in_eop_11 || tx.in_stream_11 != 0)) ||
        (tx.pck_rd_en_grnt_12 && (tx.in_sop_12 || tx.in_eop_12 || tx.in_stream_12 != 0)) ||
        (tx.pck_rd_en_grnt_13 && (tx.in_sop_13 || tx.in_eop_13 || tx.in_stream_13 != 0)) ||
        (tx.pck_rd_en_grnt_14 && (tx.in_sop_14 || tx.in_eop_14 || tx.in_stream_14 != 0)) ||
        (tx.pck_rd_en_grnt_15 && (tx.in_sop_15 || tx.in_eop_15 || tx.in_stream_15 != 0))) begin
      return 1;
    end
    return 0;
  endfunction
  
  // Check if transaction has any valid outputs
  function bit has_valid_outputs(ulss_tx tx);
    // Check for any valid output data
    if ((tx.out_sop_0 || tx.out_eop_0 || tx.out_stream_0 != 0) ||
        (tx.out_sop_1 || tx.out_eop_1 || tx.out_stream_1 != 0) ||
        (tx.out_sop_2 || tx.out_eop_2 || tx.out_stream_2 != 0) ||
        (tx.out_sop_3 || tx.out_eop_3 || tx.out_stream_3 != 0)) begin
      return 1;
    end
    return 0;
  endfunction
  
  // Determine which output port an input stream should be routed to based on the specific mapping tests
  function int get_output_port(int input_stream);
    // Map input streams to output ports according to test requirements
    // in_stream_zero_to_three_map_test: inputs 0-3 map to output 0
    // in_stream_four_to_seven_map_test: inputs 4-7 map to output 1
    // in_stream_eight_to_eleven_map_test: inputs 8-11 map to output 2
    // in_stream_twelve_to_fifteen_map_test: inputs 12-15 map to output 3
    
    if (input_stream >= 0 && input_stream <= 3)
      return 0;  // Map inputs 0-3 to output 0
    else if (input_stream >= 4 && input_stream <= 7)
      return 1;  // Map inputs 4-7 to output 1
    else if (input_stream >= 8 && input_stream <= 11)
      return 2;  // Map inputs 8-11 to output 2
    else if (input_stream >= 12 && input_stream <= 15)
      return 3;  // Map inputs 12-15 to output 3
    else
      return input_stream % 4; // Fallback to original mapping for any other cases
  endfunction
  
  // Reference model implementation
  virtual function void reference_model(ulss_tx tx);
    bit [15:0] grant_signals;
    bit valid_data;
    bit sop, eop;
    bit [63:0] data;
    int out_port;
    bit is_duplicate;
    expected_output_t new_exp;
    
    // Extract grant signals from transaction
    grant_signals[0] = tx.pck_rd_en_grnt_0;
    grant_signals[1] = tx.pck_rd_en_grnt_1;
    grant_signals[2] = tx.pck_rd_en_grnt_2;
    grant_signals[3] = tx.pck_rd_en_grnt_3;
    grant_signals[4] = tx.pck_rd_en_grnt_4;
    grant_signals[5] = tx.pck_rd_en_grnt_5;
    grant_signals[6] = tx.pck_rd_en_grnt_6;
    grant_signals[7] = tx.pck_rd_en_grnt_7;
    grant_signals[8] = tx.pck_rd_en_grnt_8;
    grant_signals[9] = tx.pck_rd_en_grnt_9;
    grant_signals[10] = tx.pck_rd_en_grnt_10;
    grant_signals[11] = tx.pck_rd_en_grnt_11;
    grant_signals[12] = tx.pck_rd_en_grnt_12;
    grant_signals[13] = tx.pck_rd_en_grnt_13;
    grant_signals[14] = tx.pck_rd_en_grnt_14;
    grant_signals[15] = tx.pck_rd_en_grnt_15;
    
    // Clear input tracking for this transaction
    active_inputs = "";
    active_input_count = 0;
    active_grants = "";
    active_grant_count = 0;
    
    // Determine which input streams are active and granted
    for (int i = 0; i < 16; i++) begin
      if (grant_signals[i]) begin
        valid_data = 0;
        sop = 0;
        eop = 0;
        data = 64'h0;
        
        // Get the appropriate signals based on stream index
        case (i)
          0: begin sop = tx.in_sop_0; data = tx.in_stream_0; eop = tx.in_eop_0; valid_data = tx.in_sop_0 || tx.in_eop_0 || (tx.in_stream_0 != 0); end
          1: begin sop = tx.in_sop_1; data = tx.in_stream_1; eop = tx.in_eop_1; valid_data = tx.in_sop_1 || tx.in_eop_1 || (tx.in_stream_1 != 0); end
          2: begin sop = tx.in_sop_2; data = tx.in_stream_2; eop = tx.in_eop_2; valid_data = tx.in_sop_2 || tx.in_eop_2 || (tx.in_stream_2 != 0); end
          3: begin sop = tx.in_sop_3; data = tx.in_stream_3; eop = tx.in_eop_3; valid_data = tx.in_sop_3 || tx.in_eop_3 || (tx.in_stream_3 != 0); end
          4: begin sop = tx.in_sop_4; data = tx.in_stream_4; eop = tx.in_eop_4; valid_data = tx.in_sop_4 || tx.in_eop_4 || (tx.in_stream_4 != 0); end
          5: begin sop = tx.in_sop_5; data = tx.in_stream_5; eop = tx.in_eop_5; valid_data = tx.in_sop_5 || tx.in_eop_5 || (tx.in_stream_5 != 0); end
          6: begin sop = tx.in_sop_6; data = tx.in_stream_6; eop = tx.in_eop_6; valid_data = tx.in_sop_6 || tx.in_eop_6 || (tx.in_stream_6 != 0); end
          7: begin sop = tx.in_sop_7; data = tx.in_stream_7; eop = tx.in_eop_7; valid_data = tx.in_sop_7 || tx.in_eop_7 || (tx.in_stream_7 != 0); end
          8: begin sop = tx.in_sop_8; data = tx.in_stream_8; eop = tx.in_eop_8; valid_data = tx.in_sop_8 || tx.in_eop_8 || (tx.in_stream_8 != 0); end
          9: begin sop = tx.in_sop_9; data = tx.in_stream_9; eop = tx.in_eop_9; valid_data = tx.in_sop_9 || tx.in_eop_9 || (tx.in_stream_9 != 0); end
          10: begin sop = tx.in_sop_10; data = tx.in_stream_10; eop = tx.in_eop_10; valid_data = tx.in_sop_10 || tx.in_eop_10 || (tx.in_stream_10 != 0); end
          11: begin sop = tx.in_sop_11; data = tx.in_stream_11; eop = tx.in_eop_11; valid_data = tx.in_sop_11 || tx.in_eop_11 || (tx.in_stream_11 != 0); end
          12: begin sop = tx.in_sop_12; data = tx.in_stream_12; eop = tx.in_eop_12; valid_data = tx.in_sop_12 || tx.in_eop_12 || (tx.in_stream_12 != 0); end
          13: begin sop = tx.in_sop_13; data = tx.in_stream_13; eop = tx.in_eop_13; valid_data = tx.in_sop_13 || tx.in_eop_13 || (tx.in_stream_13 != 0); end
          14: begin sop = tx.in_sop_14; data = tx.in_stream_14; eop = tx.in_eop_14; valid_data = tx.in_sop_14 || tx.in_eop_14 || (tx.in_stream_14 != 0); end
          15: begin sop = tx.in_sop_15; data = tx.in_stream_15; eop = tx.in_eop_15; valid_data = tx.in_sop_15 || tx.in_eop_15 || (tx.in_stream_15 != 0); end
        endcase
        
        if (valid_data) begin
          // Update active inputs tracking
          active_inputs = {active_inputs, $sformatf(" %0d", i)};
          active_input_count++;
          
          // Update active grants tracking
          active_grants = {active_grants, $sformatf(" %0d", i)};
          active_grant_count++;
          
          // Use the get_output_port function to determine which output port this input will be routed to
          out_port = get_output_port(i);
          
          // Check for duplicate expected outputs before adding to queue
          is_duplicate = 0;
          
          foreach (exp_outputs[out_port][j]) begin
            if (exp_outputs[out_port][j].data == data && 
                exp_outputs[out_port][j].sop == sop && 
                exp_outputs[out_port][j].eop == eop &&
                exp_outputs[out_port][j].cycle_id == current_cycle_id) begin
              is_duplicate = 1;
              break;
            end
          end
          
          if (!is_duplicate) begin
            // Create and add new expected output
            new_exp.data = data;
            new_exp.sop = sop;
            new_exp.eop = eop;
            new_exp.compared = 0; // Not compared yet
            new_exp.cycle_id = current_cycle_id; // Mark with current cycle ID
            
            // Add expected data to the correct output queue
            exp_outputs[out_port].push_back(new_exp);
            
            `uvm_info(get_type_name(), $sformatf("Reference model: Input stream %0d with data 0x%0h routed to output port %0d", 
                     i, data, out_port), UVM_HIGH)
          end
        end
      end
    end
  endfunction
  
  // Check function to compare DUT outputs with expected outputs
  virtual function void check_outputs(ulss_tx tx);
    bit actual_sop, actual_eop;
    bit [63:0] actual_data;
    bit data_valid;
    int match_idx;
    bit[127:0] tx_hash;
    
    // Check each output port
    for (int i = 0; i < 4; i++) begin
      actual_sop = 0;
      actual_eop = 0;
      actual_data = 0;
      data_valid = 0;
      
      // Get actual output data based on port index
      case (i)
        0: begin 
          actual_sop = tx.out_sop_0; 
          actual_data = tx.out_stream_0; 
          actual_eop = tx.out_eop_0;
          data_valid = actual_sop || actual_eop || (actual_data != 0);
        end
        1: begin 
          actual_sop = tx.out_sop_1; 
          actual_data = tx.out_stream_1; 
          actual_eop = tx.out_eop_1;
          data_valid = actual_sop || actual_eop || (actual_data != 0);
        end
        2: begin 
          actual_sop = tx.out_sop_2; 
          actual_data = tx.out_stream_2; 
          actual_eop = tx.out_eop_2;
          data_valid = actual_sop || actual_eop || (actual_data != 0);
        end
        3: begin 
          actual_sop = tx.out_sop_3; 
          actual_data = tx.out_stream_3; 
          actual_eop = tx.out_eop_3;
          data_valid = actual_sop || actual_eop || (actual_data != 0);
        end
      endcase
      
      // Only process if this output has valid data
      if (data_valid) begin
        // Generate a hash to check if we've seen this exact output before
        tx_hash = generate_tx_hash(actual_sop, actual_data, actual_eop, i);
        
        // Check if we've already compared this exact output in a previous cycle
        if (seen_transactions.exists(tx_hash)) begin
          // Already compared this exact output before, skip it
          continue;
        end
        
        // Mark this output as seen
        seen_transactions[tx_hash] = 1;
        
        // Store this output as processed
        last_seen_data[i] = actual_data;
        last_seen_sop[i] = actual_sop;
        last_seen_eop[i] = actual_eop;
        output_already_processed[i] = 1;
        
        // Update active outputs tracking
        active_outputs = {active_outputs, $sformatf(" %0d", i)};
        active_output_count++;
        
        // Find a match in expected outputs
        match_idx = -1;
        
        for (int j = 0; j < exp_outputs[i].size(); j++) begin
          if (!exp_outputs[i][j].compared && 
              actual_data === exp_outputs[i][j].data && 
              actual_sop === exp_outputs[i][j].sop && 
              actual_eop === exp_outputs[i][j].eop) begin
            match_idx = j;
            break;
          end
        end
        
        if (match_idx >= 0) begin
          // Found a match in expected outputs - only report once per unique output
          `uvm_info(get_type_name(), 
                   $sformatf("Output %0d MATCH - Expected: SOP=%0d, DATA=0x%0h, EOP=%0d, Actual: SOP=%0d, DATA=0x%0h, EOP=%0d", 
                   i, exp_outputs[i][match_idx].sop, exp_outputs[i][match_idx].data, exp_outputs[i][match_idx].eop, 
                   actual_sop, actual_data, actual_eop), UVM_MEDIUM)
          match_count++;
          
          // Mark the matched item as compared
          exp_outputs[i][match_idx].compared = 1;
        end else begin
          // No match found - this is an unexpected output
          `uvm_error(get_type_name(), 
                    $sformatf("Unexpected output on port %0d - SOP=%0d, DATA=0x%0h, EOP=%0d", 
                    i, actual_sop, actual_data, actual_eop))
          mismatch_count++;
        end
      end
    end
    
    // Clean up processed items from the expected output queues
    for (int i = 0; i < 4; i++) begin
      int j = 0;
      while (j < exp_outputs[i].size()) begin
        if (exp_outputs[i][j].compared || 
            // Also remove stale expected outputs from prior cycles
            (exp_outputs[i][j].cycle_id < current_cycle_id - 2)) begin
          // Remove this item
          exp_outputs[i].delete(j);
        end else begin
          j++;
        end
      end
    end
  endfunction
  
  // Report phase
  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    
    `uvm_info(get_type_name(), $sformatf("Scoreboard report - Match count: %0d, Mismatch count: %0d", 
             match_count, mismatch_count), UVM_LOW)
             
    // Check for any remaining expected outputs
    for (int i = 0; i < 4; i++) begin
      /*if (exp_outputs[i].size() > 0) begin
        `uvm_error(get_type_name(), 
                  $sformatf("End of test - %0d remaining expected outputs on port %0d not received", 
                  exp_outputs[i].size(), i))
      end*/
      exp_outputs[i].delete();
    end
    
    if (mismatch_count == 0 && match_count > 0) begin
      `uvm_info(get_type_name(), "TEST PASSED - All DUT outputs matched expected results", UVM_LOW)
    end else if (mismatch_count > 0) begin
      `uvm_error(get_type_name(), "TEST FAILED - DUT outputs did not match expected results")
    end else if (match_count == 0) begin
      `uvm_warning(get_type_name(), "No transactions were checked during the test")
    end
  endfunction
  
endclass



