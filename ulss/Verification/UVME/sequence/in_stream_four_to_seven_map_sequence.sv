
  class in_stream_four_to_seven_map_sequence extends uvm_sequence#(ulss_tx);

  // Factory registration
  `uvm_object_utils(in_stream_four_to_seven_map_sequence)

  // Creating sequence item handle
  ulss_tx tx;

  int scenario = 2; // Default scenario
  int config_setup_delay = 10; // Delay between config stages
  int packet_process_delay = 50; // Increased delay for packet processing

  // Constructor
  function new(string name="in_stream_four_to_seven_map_sequence");
    super.new(name);
  endfunction
  
  task body();
    `uvm_info(get_type_name(), "in_stream_four_to_seven_map_sequence: starting sequence", UVM_LOW)
    
    if(scenario == 2) begin
       // repeat(1000)
      //------------------------------------------------------------------
      // Phase 1: Configure scheduler registers - OUTPUT STREAM MAPPING
      //------------------------------------------------------------------
                // Assert reset (active low)
   `uvm_do_with(tx, {
      tx.rate_limiter_16to4_rstn == 1'b0;
      tx.sch_reg_wr_en == 1'b0;
        tx.in_sop_4        == 1'b0;
        tx.in_stream_4     == 1'b0;
        tx.in_eop_4        == 1'b0;
        tx.in_sop_5        == 1'b0;
        tx.in_stream_5     == 1'b0;
        tx.in_eop_5        == 1'b0;
        
        tx.in_sop_6        == 1'b0;
        tx.in_stream_6     == 1'b0;
        tx.in_eop_6        == 1'b0;
        
        tx.in_sop_7        == 1'b0;
        tx.in_stream_7     == 1'b0;
        tx.in_eop_7        == 1'b0;

    });
    
    // Allow some cycles for reset
    repeat(5) #50;
    
 
      // Configure output stream 1 mapping
      `uvm_do_with(tx, { 
        tx.rate_limiter_16to4_rstn == 1;
        tx.sch_reg_wr_en   == 1'b1;
        tx.sch_reg_wr_addr == 5'd1; // OUT_STREAM_1_REG
        tx.sch_reg_wr_data == 64'h0000_0000_0000_00f0; // Maps to input streams 4-7
        
        // Keep all streams inactive during configuration
        tx.pck_str_empty_0 == 1'b1;
        tx.pck_str_empty_1 == 1'b1;
        tx.pck_str_empty_2 == 1'b1;
        tx.pck_str_empty_3 == 1'b1;
        tx.pck_str_empty_4 == 1'b1;
        tx.pck_str_empty_5 == 1'b1;
        tx.pck_str_empty_6 == 1'b1;
        tx.pck_str_empty_7 == 1'b1;
        tx.pck_str_empty_8 == 1'b1;
        tx.pck_str_empty_9 == 1'b1;
        tx.pck_str_empty_10 == 1'b1;
        tx.pck_str_empty_11 == 1'b1;
        tx.pck_str_empty_12 == 1'b1;
        tx.pck_str_empty_13 == 1'b1;
        tx.pck_str_empty_14 == 1'b1;
        tx.pck_str_empty_15 == 1'b1;
        tx.in_sop_4        == 1'b0;
        tx.in_stream_4     == 1'b0;
        tx.in_eop_4        == 1'b0;
        tx.in_sop_5        == 1'b0;
        tx.in_stream_5     == 1'b0;
        tx.in_eop_5        == 1'b0;
        
        tx.in_sop_6        == 1'b0;
        tx.in_stream_6     == 1'b0;
        tx.in_eop_6        == 1'b0;
        
        tx.in_sop_7        == 1'b0;
        tx.in_stream_7     == 1'b0;
        tx.in_eop_7        == 1'b0;


      });
      
      `uvm_info(get_type_name(), $sformatf("out_stream_1_reg=0x%0h", tx.sch_reg_wr_data), UVM_LOW)
      
      // Allow configuration to take effect with longer delay
      #(config_setup_delay * 3);
      
      //------------------------------------------------------------------
      // Phase 2: Configure INPUT STREAM registers all at once
      //------------------------------------------------------------------
      
      // Configure input stream 4
      `uvm_do_with(tx, {
        tx.rate_limiter_16to4_rstn == 1;
        tx.sch_reg_wr_en   == 1'b1;
        tx.sch_reg_wr_addr == 5'd8; // IN_STREAM_4_REG 
        tx.sch_reg_wr_data[15:0]  == 16'd3;  // 3 tokens wait
        tx.sch_reg_wr_data[63:16] == 48'd1;  // 1 packet
        
        // Keep all streams inactive during configuration
        tx.pck_str_empty_0 == 1'b1;
        tx.pck_str_empty_1 == 1'b1;
        tx.pck_str_empty_2 == 1'b1;
        tx.pck_str_empty_3 == 1'b1;
        tx.pck_str_empty_4 == 1'b1;
        tx.pck_str_empty_5 == 1'b1;
        tx.pck_str_empty_6 == 1'b1;
        tx.pck_str_empty_7 == 1'b1;
        tx.pck_str_empty_8 == 1'b1;
        tx.pck_str_empty_9 == 1'b1;
        tx.pck_str_empty_10 == 1'b1;
        tx.pck_str_empty_11 == 1'b1;
        tx.pck_str_empty_12 == 1'b1;
        tx.pck_str_empty_13 == 1'b1;
        tx.pck_str_empty_14 == 1'b1;
        tx.pck_str_empty_15 == 1'b1;
        tx.in_sop_4        == 1'b0;
        tx.in_stream_4     == 1'b0;
        tx.in_eop_4        == 1'b0;
        tx.in_sop_5        == 1'b0;
        tx.in_stream_5     == 1'b0;
        tx.in_eop_5        == 1'b0;
        
        tx.in_sop_6        == 1'b0;
        tx.in_stream_6     == 1'b0;
        tx.in_eop_6        == 1'b0;
        
        tx.in_sop_7        == 1'b0;
        tx.in_stream_7     == 1'b0;
        tx.in_eop_7        == 1'b0;


      });
      
      `uvm_info(get_type_name(), $sformatf("in_stream_4_reg=0x%0h", tx.sch_reg_wr_data), UVM_LOW)
      
      #(config_setup_delay * 2);
      
      // Configure input stream 5
      `uvm_do_with(tx, {
        tx.rate_limiter_16to4_rstn == 1;
        tx.sch_reg_wr_en   == 1'b1;
        tx.sch_reg_wr_addr == 5'd9; // IN_STREAM_5_REG
        tx.sch_reg_wr_data[15:0]  == 16'd2;  // 2 tokens wait
        tx.sch_reg_wr_data[63:16] == 48'd1;  // 1 packet
        
        // Keep all streams inactive during configuration
        tx.pck_str_empty_0 == 1'b1;
        tx.pck_str_empty_1 == 1'b1;
        tx.pck_str_empty_2 == 1'b1;
        tx.pck_str_empty_3 == 1'b1;
        tx.pck_str_empty_4 == 1'b1;
        tx.pck_str_empty_5 == 1'b1;
        tx.pck_str_empty_6 == 1'b1;
        tx.pck_str_empty_7 == 1'b1;
        tx.pck_str_empty_8 == 1'b1;
        tx.pck_str_empty_9 == 1'b1;
        tx.pck_str_empty_10 == 1'b1;
        tx.pck_str_empty_11 == 1'b1;
        tx.pck_str_empty_12 == 1'b1;
        tx.pck_str_empty_13 == 1'b1;
        tx.pck_str_empty_14 == 1'b1;
        tx.pck_str_empty_15 == 1'b1;
          
          
        tx.in_sop_4        == 1'b0;
        tx.in_stream_4     == 1'b0;
        tx.in_eop_4        == 1'b0;
        tx.in_sop_5        == 1'b0;
        tx.in_stream_5     == 1'b0;
        tx.in_eop_5        == 1'b0;
        
        tx.in_sop_6        == 1'b0;
        tx.in_stream_6     == 1'b0;
        tx.in_eop_6        == 1'b0;
        
        tx.in_sop_7        == 1'b0;
        tx.in_stream_7     == 1'b0;
        tx.in_eop_7        == 1'b0;


      });
      
      `uvm_info(get_type_name(), $sformatf("in_stream_5_reg=0x%0h", tx.sch_reg_wr_data), UVM_LOW)
      
      #(config_setup_delay * 2);
      
      // Configure input stream 6
      `uvm_do_with(tx, {
        tx.rate_limiter_16to4_rstn == 1;
        tx.sch_reg_wr_en   == 1'b1;
        tx.sch_reg_wr_addr == 5'd10; // IN_STREAM_6_REG
        tx.sch_reg_wr_data[15:0]  == 16'd1;  // CHANGED: from 3 to 1 token wait
        tx.sch_reg_wr_data[63:16] == 48'd1;  // 1 packet
        
        // Keep all streams inactive during configuration
        tx.pck_str_empty_0 == 1'b1;
        tx.pck_str_empty_1 == 1'b1;
        tx.pck_str_empty_2 == 1'b1;
        tx.pck_str_empty_3 == 1'b1;
        tx.pck_str_empty_4 == 1'b1;
        tx.pck_str_empty_5 == 1'b1;
        tx.pck_str_empty_6 == 1'b1;
        tx.pck_str_empty_7 == 1'b1;
        tx.pck_str_empty_8 == 1'b1;
        tx.pck_str_empty_9 == 1'b1;
        tx.pck_str_empty_10 == 1'b1;
        tx.pck_str_empty_11 == 1'b1;
        tx.pck_str_empty_12 == 1'b1;
        tx.pck_str_empty_13 == 1'b1;
        tx.pck_str_empty_14 == 1'b1;
        tx.pck_str_empty_15 == 1'b1;
        tx.in_sop_4        == 1'b0;
        tx.in_stream_4     == 1'b0;
        tx.in_eop_4        == 1'b0;
        tx.in_sop_5        == 1'b0;
        tx.in_stream_5     == 1'b0;
        tx.in_eop_5        == 1'b0;
        
        tx.in_sop_6        == 1'b0;
        tx.in_stream_6     == 1'b0;
        tx.in_eop_6        == 1'b0;
        
        tx.in_sop_7        == 1'b0;
        tx.in_stream_7     == 1'b0;
        tx.in_eop_7        == 1'b0;

      });
      
      `uvm_info(get_type_name(), $sformatf("in_stream_6_reg=0x%0h", tx.sch_reg_wr_data), UVM_LOW)
      
      #(config_setup_delay * 2);
      
      // Configure input stream 7
      `uvm_do_with(tx, {
        tx.rate_limiter_16to4_rstn == 1;
        tx.sch_reg_wr_en   == 1'b1;
        tx.sch_reg_wr_addr == 5'd11; // IN_STREAM_7_REG
        tx.sch_reg_wr_data[15:0]  == 16'd2;  
        tx.sch_reg_wr_data[63:16] == 48'd1;  // 1 packet
        
        // Keep all streams inactive during configuration
        tx.pck_str_empty_0 == 1'b1;
        tx.pck_str_empty_1 == 1'b1;
        tx.pck_str_empty_2 == 1'b1;
        tx.pck_str_empty_3 == 1'b1;
        tx.pck_str_empty_4 == 1'b1;
        tx.pck_str_empty_5 == 1'b1;
        tx.pck_str_empty_6 == 1'b1;
        tx.pck_str_empty_7 == 1'b1;
        tx.pck_str_empty_8 == 1'b1;
        tx.pck_str_empty_9 == 1'b1;
        tx.pck_str_empty_10 == 1'b1;
        tx.pck_str_empty_11 == 1'b1;
        tx.pck_str_empty_12 == 1'b1;
        tx.pck_str_empty_13 == 1'b1;
        tx.pck_str_empty_14 == 1'b1;
        tx.pck_str_empty_15 == 1'b1;
         tx.in_sop_4        == 1'b0;
        tx.in_stream_4     == 1'b0;
        tx.in_eop_4        == 1'b0;
        tx.in_sop_5        == 1'b0;
        tx.in_stream_5     == 1'b0;
        tx.in_eop_5        == 1'b0;
        
        tx.in_sop_6        == 1'b0;
        tx.in_stream_6     == 1'b0;
        tx.in_eop_6        == 1'b0;
        
        tx.in_sop_7        == 1'b0;
        tx.in_stream_7     == 1'b0;
        tx.in_eop_7        == 1'b0;

      });
      
      `uvm_info(get_type_name(), $sformatf("in_stream_7_reg=0x%0h", tx.sch_reg_wr_data), UVM_LOW)
      
      // Allow ALL configurations to take effect before sending packets
      #(config_setup_delay * 4);
      
      //------------------------------------------------------------------
      // Phase 3: Clear register write signals with a dummy transaction
      //------------------------------------------------------------------
      `uvm_do_with(tx, {
        tx.rate_limiter_16to4_rstn == 1;
        tx.sch_reg_wr_en   == 1'b0;  // Disable register writes
        tx.sch_reg_wr_addr == 5'd0;
        tx.sch_reg_wr_data == 64'h0;
        
        // Keep all streams inactive during this transition
        tx.pck_str_empty_0 == 1'b1;
        tx.pck_str_empty_1 == 1'b1;
        tx.pck_str_empty_2 == 1'b1;
        tx.pck_str_empty_3 == 1'b1;
        tx.pck_str_empty_4 == 1'b1;
        tx.pck_str_empty_5 == 1'b1;
        tx.pck_str_empty_6 == 1'b1;
        tx.pck_str_empty_7 == 1'b1;
        tx.pck_str_empty_8 == 1'b1;
        tx.pck_str_empty_9 == 1'b1;
        tx.pck_str_empty_10 == 1'b1;
        tx.pck_str_empty_11 == 1'b1;
        tx.pck_str_empty_12 == 1'b1;
        tx.pck_str_empty_13 == 1'b1;
        tx.pck_str_empty_14 == 1'b1;
        tx.pck_str_empty_15 == 1'b1;
        tx.in_sop_4        == 1'b0;
        tx.in_stream_4     == 1'b0;
        tx.in_eop_4        == 1'b0;
        tx.in_sop_5        == 1'b0;
        tx.in_stream_5     == 1'b0;
        tx.in_eop_5        == 1'b0;
        
        tx.in_sop_6        == 1'b0;
        tx.in_stream_6     == 1'b0;
        tx.in_eop_6        == 1'b0;
        
        tx.in_sop_7        == 1'b0;
        tx.in_stream_7     == 1'b0;
        tx.in_eop_7        == 1'b0;

      });
      
      // Allow system to stabilize before sending data
      #(config_setup_delay * 2);
      
      //------------------------------------------------------------------
      // CHANGED: Phase 4: Send packets using a different approach
      //------------------------------------------------------------------
      
      // Stream 4 packet
      `uvm_info(get_type_name(), "Sending packet on stream 4", UVM_LOW)
      `uvm_do_with(tx, {
        tx.rate_limiter_16to4_rstn == 1;
        tx.sch_reg_wr_en   == 1'b0;
        tx.sch_reg_wr_addr == 'd0;
        tx.sch_reg_wr_data == 'h0;

        // Only stream 4 active with specific data pattern
        tx.pck_str_empty_4 == 1'b0;
        tx.in_sop_4        == 1'b1;
        //tx.in_stream_4     == 64'h47c4cb3c_9c3e231f; // Specific value from waveform
        tx.in_eop_4        == 1'b1;
        
        // All other streams inactive
        tx.pck_str_empty_0 == 1'b1;
        tx.pck_str_empty_1 == 1'b1;
        tx.pck_str_empty_2 == 1'b1;
        tx.pck_str_empty_3 == 1'b1;
        tx.pck_str_empty_5 == 1'b1;
        tx.pck_str_empty_6 == 1'b1;
        tx.pck_str_empty_7 == 1'b1;
        tx.pck_str_empty_8 == 1'b1;
        tx.pck_str_empty_9 == 1'b1;
        tx.pck_str_empty_10 == 1'b1;
        tx.pck_str_empty_11 == 1'b1;
        tx.pck_str_empty_12 == 1'b1;
        tx.pck_str_empty_13 == 1'b1;
        tx.pck_str_empty_14 == 1'b1;
        tx.pck_str_empty_15 == 1'b1;
        tx.in_sop_5        == 1'b0;
        tx.in_stream_5     == 1'b0;
        tx.in_eop_5        == 1'b0;
        
        tx.in_sop_6        == 1'b0;
        tx.in_stream_6     == 1'b0;
        tx.in_eop_6        == 1'b0;
        
        tx.in_sop_7        == 1'b0;
        tx.in_stream_7     == 1'b0;
        tx.in_eop_7        == 1'b0;

      });
      
      // Allow packet to be processed with longer delay
      #packet_process_delay;
      
      // Send an idle cycle to ensure packet is fully processed
      `uvm_do_with(tx, {
        tx.rate_limiter_16to4_rstn == 1;
        tx.sch_reg_wr_en   == 1'b0;
        tx.sch_reg_wr_addr == 'd0;
        tx.sch_reg_wr_data == 'h0;
        
        // All streams inactive
        tx.pck_str_empty_0 == 1'b1;
        tx.pck_str_empty_1 == 1'b1;
        tx.pck_str_empty_2 == 1'b1;
        tx.pck_str_empty_3 == 1'b1;
        tx.pck_str_empty_4 == 1'b1;
        tx.pck_str_empty_5 == 1'b1;
        tx.pck_str_empty_6 == 1'b1;
        tx.pck_str_empty_7 == 1'b1;
        tx.pck_str_empty_8 == 1'b1;
        tx.pck_str_empty_9 == 1'b1;
        tx.pck_str_empty_10 == 1'b1;
        tx.pck_str_empty_11 == 1'b1;
        tx.pck_str_empty_12 == 1'b1;
        tx.pck_str_empty_13 == 1'b1;
        tx.pck_str_empty_14 == 1'b1;
        tx.pck_str_empty_15 == 1'b1;
        tx.in_sop_4        == 1'b0;
        tx.in_stream_4     == 1'b0;
        tx.in_eop_4        == 1'b0;
        tx.in_sop_5        == 1'b0;
        tx.in_stream_5     == 1'b0;
        tx.in_eop_5        == 1'b0;        
        tx.in_sop_6        == 1'b0;
        tx.in_stream_6     == 1'b0;
        tx.in_eop_6        == 1'b0;        
        tx.in_sop_7        == 1'b0;
        tx.in_stream_7     == 1'b0;
        tx.in_eop_7        == 1'b0;


       
      });
      
      #20;
      
      // Stream 5 packet
      `uvm_info(get_type_name(), "Sending packet on stream 5", UVM_LOW)
      `uvm_do_with(tx, {
        tx.rate_limiter_16to4_rstn == 1;
        tx.sch_reg_wr_en   == 1'b0;
        tx.sch_reg_wr_addr == 'd0;
        tx.sch_reg_wr_data == 'h0;
        
        // Only stream 5 active with specific data pattern
        tx.pck_str_empty_5 == 1'b0;
        tx.in_sop_5        == 1'b1;
       // tx.in_stream_5     == 64'h0000000_00010002; // Value based on waveform
        tx.in_eop_5        == 1'b1;
        
        // All other streams inactive
        tx.pck_str_empty_0 == 1'b1;
        tx.pck_str_empty_1 == 1'b1;
        tx.pck_str_empty_2 == 1'b1;
        tx.pck_str_empty_3 == 1'b1;
        tx.pck_str_empty_4 == 1'b1;
        tx.pck_str_empty_6 == 1'b1;
        tx.pck_str_empty_7 == 1'b1;
        tx.pck_str_empty_8 == 1'b1;
        tx.pck_str_empty_9 == 1'b1;
        tx.pck_str_empty_10 == 1'b1;
        tx.pck_str_empty_11 == 1'b1;
        tx.pck_str_empty_12 == 1'b1;
        tx.pck_str_empty_13 == 1'b1;
        tx.pck_str_empty_14 == 1'b1;
        tx.pck_str_empty_15 == 1'b1;
        tx.in_sop_4        == 1'b0;
        tx.in_stream_4     == 1'b0;
        tx.in_eop_4        == 1'b0;
              
        tx.in_sop_6        == 1'b0;
        tx.in_stream_6     == 1'b0;
        tx.in_eop_6        == 1'b0;        
        tx.in_sop_7        == 1'b0;
        tx.in_stream_7     == 1'b0;
        tx.in_eop_7        == 1'b0;


      });
      
      // Allow packet to be processed with longer delay
      #packet_process_delay;
      
      // Send an idle cycle to ensure packet is fully processed
      `uvm_do_with(tx, {
        tx.rate_limiter_16to4_rstn == 1;
        tx.sch_reg_wr_en   == 1'b0;
        tx.sch_reg_wr_addr == 'd0;
        tx.sch_reg_wr_data == 'h0;
        
        // All streams inactive
        tx.pck_str_empty_0 == 1'b1;
        tx.pck_str_empty_1 == 1'b1;
        tx.pck_str_empty_2 == 1'b1;
        tx.pck_str_empty_3 == 1'b1;
        tx.pck_str_empty_4 == 1'b1;
        tx.pck_str_empty_5 == 1'b1;
        tx.pck_str_empty_6 == 1'b1;
        tx.pck_str_empty_7 == 1'b1;
        tx.pck_str_empty_8 == 1'b1;
        tx.pck_str_empty_9 == 1'b1;
        tx.pck_str_empty_10 == 1'b1;
        tx.pck_str_empty_11 == 1'b1;
        tx.pck_str_empty_12 == 1'b1;
        tx.pck_str_empty_13 == 1'b1;
        tx.pck_str_empty_14 == 1'b1;
        tx.pck_str_empty_15 == 1'b1;
         tx.in_sop_4        == 1'b0;
        tx.in_stream_4     == 1'b0;
        tx.in_eop_4        == 1'b0;
        tx.in_sop_5        == 1'b0;
        tx.in_stream_5     == 1'b0;
        tx.in_eop_5        == 1'b0;        
        tx.in_sop_6        == 1'b0;
        tx.in_stream_6     == 1'b0;
        tx.in_eop_6        == 1'b0;        
        tx.in_sop_7        == 1'b0;
        tx.in_stream_7     == 1'b0;
        tx.in_eop_7        == 1'b0;


      });
      
      #20;
      
      // Stream 6 packet
      `uvm_info(get_type_name(), "Sending packet on stream 6", UVM_LOW)
      `uvm_do_with(tx, {
        tx.rate_limiter_16to4_rstn == 1;
        tx.sch_reg_wr_en   == 1'b0;
        tx.sch_reg_wr_addr == 'd0;
        tx.sch_reg_wr_data == 'h0;
        
        // Only stream 6 active with specific data pattern
        tx.pck_str_empty_6 == 1'b0;
        tx.in_sop_6        == 1'b1;
       // tx.in_stream_6     == 64'h0000000_00010003; // Value based on waveform
        tx.in_eop_6        == 1'b1;
        
        // All other streams inactive
        tx.pck_str_empty_0 == 1'b1;
        tx.pck_str_empty_1 == 1'b1;
        tx.pck_str_empty_2 == 1'b1;
        tx.pck_str_empty_3 == 1'b1;
        tx.pck_str_empty_4 == 1'b1;
        tx.pck_str_empty_5 == 1'b1;
        tx.pck_str_empty_7 == 1'b1;
        tx.pck_str_empty_8 == 1'b1;
        tx.pck_str_empty_9 == 1'b1;
        tx.pck_str_empty_10 == 1'b1;
        tx.pck_str_empty_11 == 1'b1;
        tx.pck_str_empty_12 == 1'b1;
        tx.pck_str_empty_13 == 1'b1;
        tx.pck_str_empty_14 == 1'b1;
        tx.pck_str_empty_15 == 1'b1;
         tx.in_sop_4        == 1'b0;
        tx.in_stream_4     == 1'b0;
        tx.in_eop_4        == 1'b0;
        tx.in_sop_5        == 1'b0;
        tx.in_stream_5     == 1'b0;
        tx.in_eop_5        == 1'b0;        
        tx.in_sop_7        == 1'b0;
        tx.in_stream_7     == 1'b0;
        tx.in_eop_7        == 1'b0;


      });
      
      // Allow packet to be processed with longer delay
      #packet_process_delay;
      
      // Send an idle cycle to ensure packet is fully processed
      `uvm_do_with(tx, {
        tx.rate_limiter_16to4_rstn == 1;
        tx.sch_reg_wr_en   == 1'b0;
        tx.sch_reg_wr_addr == 'd0;
        tx.sch_reg_wr_data == 'h0;
        
        // All streams inactive
        tx.pck_str_empty_0 == 1'b1;
        tx.pck_str_empty_1 == 1'b1;
        tx.pck_str_empty_2 == 1'b1;
        tx.pck_str_empty_3 == 1'b1;
        tx.pck_str_empty_4 == 1'b1;
        tx.pck_str_empty_5 == 1'b1;
        tx.pck_str_empty_6 == 1'b1;
        tx.pck_str_empty_7 == 1'b1;
        tx.pck_str_empty_8 == 1'b1;
        tx.pck_str_empty_9 == 1'b1;
        tx.pck_str_empty_10 == 1'b1;
        tx.pck_str_empty_11 == 1'b1;
        tx.pck_str_empty_12 == 1'b1;
        tx.pck_str_empty_13 == 1'b1;
        tx.pck_str_empty_14 == 1'b1;
        tx.pck_str_empty_15 == 1'b1;
          tx.in_sop_4        == 1'b0;
        tx.in_stream_4     == 1'b0;
        tx.in_eop_4        == 1'b0;
        tx.in_sop_5        == 1'b0;
        tx.in_stream_5     == 1'b0;
        tx.in_eop_5        == 1'b0;        
        tx.in_sop_6        == 1'b0;
        tx.in_stream_6     == 1'b0;
        tx.in_eop_6        == 1'b0;        
        tx.in_sop_7        == 1'b0;
        tx.in_stream_7     == 1'b0;
        tx.in_eop_7        == 1'b0;


      });
      
      //#20;

     // Assert reset (active low)
   `uvm_do_with(tx, {
      tx.rate_limiter_16to4_rstn == 1'b0;
      tx.sch_reg_wr_en == 1'b0;
        tx.in_sop_4        == 1'b0;
        tx.in_stream_4     == 1'b0;
        tx.in_eop_4        == 1'b0;
        tx.in_sop_5        == 1'b0;
        tx.in_stream_5     == 1'b0;
        tx.in_eop_5        == 1'b0;        
        tx.in_sop_6        == 1'b0;
        tx.in_stream_6     == 1'b0;
        tx.in_eop_6        == 1'b0;        
        tx.in_sop_7        == 1'b0;
        tx.in_stream_7     == 1'b0;
        tx.in_eop_7        == 1'b0;


    });
    
    // Allow some cycles for reset
    //repeat(1)
    #1;

      
      // Stream 7 packet
      `uvm_info(get_type_name(), "Sending packet on stream 7", UVM_LOW)
      `uvm_do_with(tx, {
        tx.rate_limiter_16to4_rstn == 1;
        tx.sch_reg_wr_en   == 1'b0;
        tx.sch_reg_wr_addr == 'd0;
        tx.sch_reg_wr_data == 'h0;
        
        // Only stream 7 active with specific data pattern
        tx.pck_str_empty_7 == 1'b0;
        tx.in_sop_7        == 1'b1;
      // tx.in_stream_7     == 64'h5455790_42af297c; // Specific value from waveform
        //tx.in_stream_7 inside {[64'h0000000000000000 : 64'hFFFFFFFFFFFFFFFF],
                           //  [64'h8000000000000000 : 64'h7FFFFFFFFFFFFFFF]}; 
        tx.in_eop_7        == 1'b1;
        
        // All other streams inactive
        tx.pck_str_empty_0 == 1'b1;
        tx.pck_str_empty_1 == 1'b1;
        tx.pck_str_empty_2 == 1'b1;
        tx.pck_str_empty_3 == 1'b1;
        tx.pck_str_empty_4 == 1'b1;
        tx.pck_str_empty_5 == 1'b1;
        tx.pck_str_empty_6 == 1'b1;
        tx.pck_str_empty_8 == 1'b1;
        tx.pck_str_empty_9 == 1'b1;
        tx.pck_str_empty_10 == 1'b1;
        tx.pck_str_empty_11 == 1'b1;
        tx.pck_str_empty_12 == 1'b1;
        tx.pck_str_empty_13 == 1'b1;
        tx.pck_str_empty_14 == 1'b1;
        tx.pck_str_empty_15 == 1'b1;
          tx.in_sop_4        == 1'b0;
        tx.in_stream_4     == 1'b0;
        tx.in_eop_4        == 1'b0;
        tx.in_sop_5        == 1'b0;
        tx.in_stream_5     == 1'b0;
        tx.in_eop_5        == 1'b0;        
        tx.in_sop_6        == 1'b0;
        tx.in_stream_6     == 1'b0;
        tx.in_eop_6        == 1'b0;        
            });
      
      // Allow packet to be processed with longer delay
      #packet_process_delay;
          //------------------------------------------------------------------
      // Phase 5: Final idle state
      //------------------------------------------------------------------
      `uvm_do_with(tx, {
        tx.rate_limiter_16to4_rstn == 1;
        tx.sch_reg_wr_en   == 1'b0;
        tx.sch_reg_wr_addr == 'd0;
        tx.sch_reg_wr_data == 'h0;
        
        // All streams empty or idle
        tx.pck_str_empty_0 == 1'b1;
        tx.in_sop_0        == 1'b0;
        tx.in_stream_0     == 64'h0;
        tx.in_eop_0        == 1'b0;
        
        tx.pck_str_empty_1 == 1'b1;
        tx.in_sop_1        == 1'b0;
        tx.in_stream_1     == 64'h0;
        tx.in_eop_1        == 1'b0;
        
        tx.pck_str_empty_2 == 1'b1;
        tx.in_sop_2        == 1'b0;
        tx.in_stream_2     == 64'h0;
        tx.in_eop_2        == 1'b0;
        
        tx.pck_str_empty_3 == 1'b1;
        tx.in_sop_3        == 1'b0;
        tx.in_stream_3     == 64'h0;
        tx.in_eop_3        == 1'b0;
        
        tx.pck_str_empty_4 == 1'b1;
        tx.in_sop_4        == 1'b0;
        tx.in_stream_4     == 64'h0;
        tx.in_eop_4        == 1'b0;
        
        tx.pck_str_empty_5 == 1'b1;
        tx.in_sop_5        == 1'b0;
        tx.in_stream_5     == 64'h0;
        tx.in_eop_5        == 1'b0;
        
        tx.pck_str_empty_6 == 1'b1;
        tx.in_sop_6        == 1'b0;
        tx.in_stream_6     == 64'h0;
        tx.in_eop_6        == 1'b0;

        tx.pck_str_empty_7 == 1'b1;
        tx.in_sop_7        == 1'b0;
        tx.in_stream_7     == 64'h0;
        tx.in_eop_7        == 1'b0;
        
        tx.pck_str_empty_8 == 1'b1;
        tx.in_sop_8        == 1'b0;
        tx.in_stream_8     == 64'h0;
        tx.in_eop_8        == 1'b0;
        
        tx.pck_str_empty_9 == 1'b1;
        tx.in_sop_9        == 1'b0;
        tx.in_stream_9     == 64'h0;
        tx.in_eop_9        == 1'b0;
        
        tx.pck_str_empty_10 == 1'b1;
        tx.in_sop_10        == 1'b0;
        tx.in_stream_10     == 64'h0;
        tx.in_eop_10        == 1'b0;
        
        tx.pck_str_empty_11 == 1'b1;
        tx.in_sop_11        == 1'b0;
        tx.in_stream_11     == 64'h0;
        tx.in_eop_11        == 1'b0;
        
        tx.pck_str_empty_12 == 1'b1;
        tx.in_sop_12        == 1'b0;
        tx.in_stream_12     == 64'h0;
        tx.in_eop_12        == 1'b0;
        
        tx.pck_str_empty_13 == 1'b1;
        tx.in_sop_13        == 1'b0;
        tx.in_stream_13     == 64'h0;
        tx.in_eop_13        == 1'b0;
        
        tx.pck_str_empty_14 == 1'b1;
        tx.in_sop_14        == 1'b0;
        tx.in_stream_14     == 64'h0;
        tx.in_eop_14        == 1'b0;
        
        tx.pck_str_empty_15 == 1'b1;
        tx.in_sop_15        == 1'b0;
        tx.in_stream_15     == 64'h0;
        tx.in_eop_15        == 1'b0;
      });
      
      `uvm_info(get_type_name(), "Sequence completed successfully", UVM_LOW)
    end
  endtask

  endclass

