////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*class zero_packet_count_sequence extends uvm_sequence#(ulss_tx);

  // Factory registration
  `uvm_object_utils(zero_packet_count_sequence)

  // Creating sequence item handle
  ulss_tx tx;

  int scenario;

  // Constructor
  function new(string name="zero_packet_count_sequence");
    super.new(name);
  endfunction

  task body();
    `uvm_info(get_type_name(), "zero_packet_count_sequence: inside body", UVM_LOW);
    
    // Create the transaction
    tx = ulss_tx::type_id::create("tx");
    
    
    // De-assert reset and configure OUT_STREAM_2_REG
    `uvm_do_with(tx, { 
      tx.rate_limiter_16to4_rstn == 1'b1;
      tx.sch_reg_wr_en   == 1'b1;
      tx.sch_reg_wr_addr == 5'd3; // OUT_STREAM_3_REG
      tx.sch_reg_wr_data == 64'h0000_0000_0000_2000; // Map in_stream_13 to out_stream_3
    });
    
    `uvm_info(get_type_name(), $sformatf("OUT_STREAM_3_REG=0x%0h", tx.sch_reg_wr_data), UVM_LOW);
    
    // Wait for register write to complete
    repeat(10) #10;
    
    // Configure IN_STREAM_13_REG
    `uvm_do_with(tx, {
      tx.rate_limiter_16to4_rstn == 1'b1;
      tx.sch_reg_wr_en   == 1'b1;
      tx.sch_reg_wr_addr == 5'd17; // IN_STREAM_13_REG (4 + 9 = 13)
      tx.sch_reg_wr_data[15:0]  == 16'd3;  // 3 tokens wait
      tx.sch_reg_wr_data[63:16] == 48'd0;  // 1 packet
    });
    
    `uvm_info(get_type_name(), $sformatf("IN_STREAM_13_REG=0x%0h", tx.sch_reg_wr_data), UVM_LOW);
    
      // Wait for stable state
    repeat(15) #10;
    
    // SOP cycle - Start of Packet on stream 13
    `uvm_do_with(tx, {
      tx.rate_limiter_16to4_rstn == 1'b1;
      tx.sch_reg_wr_en == 1'b0;
      
      // Set empty flags for all streams - only stream 13 is not empty
      tx.pck_str_empty_0 == 1'b1;
      tx.pck_str_empty_1 == 1'b1;
      tx.pck_str_empty_2 == 1'b1;
      tx.pck_str_empty_3 == 1'b1;
      tx.pck_str_empty_4 == 1'b1;
      tx.pck_str_empty_5 == 1'b1;
      tx.pck_str_empty_6 == 1'b1;
      tx.pck_str_empty_7 == 1'b1;
      tx.pck_str_empty_8 == 1'b1;
      tx.pck_str_empty_9 == 1'b1; // empty
      tx.pck_str_empty_10 == 1'b1;
      tx.pck_str_empty_11 == 1'b1;
      tx.pck_str_empty_12 == 1'b1;
      tx.pck_str_empty_13 == 1'b0;
      tx.pck_str_empty_14 == 1'b1;
      tx.pck_str_empty_15 == 1'b1;
      
      // Start of packet
      tx.in_sop_13 == 1'b1;
      //tx.in_stream_13 == 64'h1111_1111_1111_1111;
       tx.in_stream_13 inside {[64'h0000000000000000 : 64'hFFFFFFFFFFFFFFFF],
                             [64'h8000000000000000 : 64'h7FFFFFFFFFFFFFFF]}; 
      tx.in_eop_13 == 1'b1; 
    });
    
    `uvm_info(get_type_name(), $sformatf("Sent SOP on stream 13 with data=0x%0h", tx.in_stream_9), UVM_LOW);
     repeat(15) #10;
    

    // Clear the packet signals
    `uvm_do_with(tx, {
      tx.rate_limiter_16to4_rstn == 1'b1;
      tx.sch_reg_wr_en == 1'b0;
      
      // Set all streams to empty
      tx.pck_str_empty_0 == 1'b1;
      tx.pck_str_empty_1 == 1'b1;
      tx.pck_str_empty_2 == 1'b1;
      tx.pck_str_empty_3 == 1'b1;
      tx.pck_str_empty_4 == 1'b1;
      tx.pck_str_empty_5 == 1'b1;
      tx.pck_str_empty_6 == 1'b1;
      tx.pck_str_empty_7 == 1'b1;
      tx.pck_str_empty_8 == 1'b1;
      tx.pck_str_empty_9 == 1'b1; // Empty again
      tx.pck_str_empty_10 == 1'b1;
      tx.pck_str_empty_11 == 1'b1;
      tx.pck_str_empty_12 == 1'b1;
      tx.pck_str_empty_13 == 1'b1;
      tx.pck_str_empty_14 == 1'b1;
      tx.pck_str_empty_15 == 1'b1;
      
      // Clear all signals for stream 9
      tx.in_sop_13 == 1'b0;
      tx.in_stream_13 == 64'h0;
      tx.in_eop_13 == 1'b0;
    });
    
    // Allow time for grant signals to stabilize
    repeat(15) #10;
    
    // Final drain/clear state to ensure correct completion
    `uvm_do_with(tx, {
      tx.rate_limiter_16to4_rstn == 1'b1;
      tx.sch_reg_wr_en == 1'b0;
      tx.pck_str_empty_13 == 1'b1;
      tx.in_sop_13 == 1'b0;
      tx.in_stream_13 == 64'h0;
      tx.in_eop_13 == 1'b0;
    });
    
    // Final wait to ensure completion
    repeat(10) #10;
    
    `uvm_info(get_type_name(), "zero_packet_count_sequence completed successfully", UVM_LOW);
  endtask
endclass  */



/////////////////////////////////////////////////////////////////////////////////////////////////////

class zero_packet_count_sequence extends uvm_sequence#(ulss_tx);

  // Factory registration
  `uvm_object_utils(zero_packet_count_sequence)

  // Creating sequence item handle
  ulss_tx tx;

  // Configuration parameters
  rand int num_packets = 0;      // Number of packets to send
  rand int token_wait = 3;        // Default token wait value
  rand int tokens_per_packet = 1; // Default tokens per packet
  rand int delay_between_packets = 2; // Delay between packets
  
  // Constraints for randomization
  constraint valid_values {
    num_packets inside {[3:10]};
    token_wait inside {[1:10]};
    tokens_per_packet inside {[1:5]};
    delay_between_packets inside {[1:5]};
  }
  
  // Constructor
  function new(string name="zero_packet_count_sequence");
    super.new(name);
  endfunction

  task body();
  //  repeat(10)

    bit [15:0] empty_status;
    bit [15:0] all_empty;
    int i;
    
    `uvm_info(get_type_name(), "zero_packet_count_sequence: Starting test with a single stream mapping", UVM_LOW)
    
    // Create the transaction
    tx = ulss_tx::type_id::create("tx");
    
    // Assert reset
    `uvm_do_with(tx, {
      tx.rate_limiter_16to4_rstn == 1'b0;
      tx.sch_reg_wr_en == 1'b0;
      tx.pck_str_empty_0 == 1'b1;
      tx.in_sop_0 == 1'b0; tx.in_stream_0 == 64'h0; tx.in_eop_0 == 1'b0;
      
    });
    
    // Allow cycles for reset
    repeat(5) #10;
    
    // Map only input stream 0 to output stream 0 (bit 0 set)
    `uvm_do_with(tx, { 
      tx.rate_limiter_16to4_rstn == 1'b1;
      tx.sch_reg_wr_en   == 1'b1;
      tx.sch_reg_wr_addr == 5'd0; // OUT_STREAM_0_REG
      tx.sch_reg_wr_data == 64'h0001; // Map input stream 0 to output stream 0
      tx.pck_str_empty_0 == 1'b1;
      
      tx.in_sop_0 == 1'b0; tx.in_stream_0 == 64'h0; tx.in_eop_0 == 1'b0;
    });
    
    `uvm_info(get_type_name(), $sformatf("OUT_STREAM_0_REG configured with value 0x%0h", tx.sch_reg_wr_data), UVM_LOW);
    
    // Wait for register write to complete
    repeat(2) #10;
    
    // Configure IN_STREAM_0_REG with token parameters
    `uvm_do_with(tx, {
      tx.rate_limiter_16to4_rstn == 1'b1;
      tx.sch_reg_wr_en   == 1'b1;
      tx.sch_reg_wr_addr == 5'd4; // IN_STREAM_0_REG
      tx.sch_reg_wr_data[15:0]  == token_wait;  // tokens wait
      tx.sch_reg_wr_data[63:16] == tokens_per_packet;  // tokens per packet
      tx.pck_str_empty_0 == 1'b1;

      tx.in_sop_0 == 1'b0; tx.in_stream_0 == 64'h0; tx.in_eop_0 == 1'b0;
    });
    
    `uvm_info(get_type_name(), $sformatf("IN_STREAM_0_REG configured with values: tokens=%0d, packets=%0d", 
                                         token_wait, tokens_per_packet), UVM_LOW);
    
    repeat(2) #10;
    
    empty_status = '1;        // Initialize all streams as empty
    empty_status[0] = 1'b0;   // Only stream 0 is not empty
    
    // Send SOP for first packet with randomized data
    send_data_word_on_stream0(empty_status, {$urandom,$urandom}, 1'b1, 1'b0);
    `uvm_info(get_type_name(), "Sent first word with SOP asserted", UVM_LOW);
    
    // Wait some cycles
    repeat(delay_between_packets) #10;
    
    // Send middle data words without SOP/EOP
    for (i = 0; i < num_packets-1; i++) begin
      // Send a data word for packet on stream 0 with randomized data
      bit [63:0] data = {$urandom,$urandom};
      send_data_word_on_stream0(empty_status, data, 1'b0, 1'b0);
      
      `uvm_info(get_type_name(), $sformatf("Sent data word %0d", i+1), UVM_LOW);
      
      // Wait some time between words
      repeat(delay_between_packets) #10;
    end
    
    // Send last word with EOP and randomized data
    send_data_word_on_stream0(empty_status, {$urandom,$urandom} ,1'b0, 1'b1);
    `uvm_info(get_type_name(), "Sent last word with EOP asserted", UVM_LOW);
    
    // Wait some cycles
    repeat(delay_between_packets) #10;
    
    // Set all streams back to empty when done
    all_empty = '1;  // All streams are empty
    set_all_streams_empty(all_empty);
    
    `uvm_info(get_type_name(), "zero_packet_count_sequence completed", UVM_LOW);
  endtask
  
  // Task to send a data word on stream 0 with control over SOP and EOP
  task send_data_word_on_stream0(bit [15:0] empty_status, bit [63:0] data, bit sop, bit eop);
    tx = ulss_tx::type_id::create("tx");
    
    // Base configuration
    tx.rate_limiter_16to4_rstn = 1'b1;
    tx.sch_reg_wr_en = 1'b0;
    tx.sch_reg_wr_addr = 'd0;
    tx.sch_reg_wr_data = 'h0;
    
    // Set up empty status for all streams
    tx.pck_str_empty_0 = empty_status[0];
    tx.pck_str_empty_1 = empty_status[1];
    tx.pck_str_empty_2 = empty_status[2];
    tx.pck_str_empty_3 = empty_status[3];
    tx.pck_str_empty_4 = empty_status[4];
    tx.pck_str_empty_5 = empty_status[5];
    tx.pck_str_empty_6 = empty_status[6];
    tx.pck_str_empty_7 = empty_status[7];
    tx.pck_str_empty_8 = empty_status[8];
    tx.pck_str_empty_9 = empty_status[9];
    tx.pck_str_empty_10 = empty_status[10];
    tx.pck_str_empty_11 = empty_status[11];
    tx.pck_str_empty_12 = empty_status[12];
    tx.pck_str_empty_13 = empty_status[13];
    tx.pck_str_empty_14 = empty_status[14];
    tx.pck_str_empty_15 = empty_status[15];
    
    // Initialize all streams to default/idle
    tx.in_sop_0 = 1'b0; tx.in_stream_0 = 64'h0; tx.in_eop_0 = 1'b0;
    tx.in_sop_1 = 1'b0; tx.in_stream_1 = 64'h0; tx.in_eop_1 = 1'b0;
    tx.in_sop_2 = 1'b0; tx.in_stream_2 = 64'h0; tx.in_eop_2 = 1'b0;
    tx.in_sop_3 = 1'b0; tx.in_stream_3 = 64'h0; tx.in_eop_3 = 1'b0;
    tx.in_sop_4 = 1'b0; tx.in_stream_4 = 64'h0; tx.in_eop_4 = 1'b0;
    tx.in_sop_5 = 1'b0; tx.in_stream_5 = 64'h0; tx.in_eop_5 = 1'b0;
    tx.in_sop_6 = 1'b0; tx.in_stream_6 = 64'h0; tx.in_eop_6 = 1'b0;
    tx.in_sop_7 = 1'b0; tx.in_stream_7 = 64'h0; tx.in_eop_7 = 1'b0;
    tx.in_sop_8 = 1'b0; tx.in_stream_8 = 64'h0; tx.in_eop_8 = 1'b0;
    tx.in_sop_9 = 1'b0; tx.in_stream_9 = 64'h0; tx.in_eop_9 = 1'b0;
    tx.in_sop_10 = 1'b0; tx.in_stream_10 = 64'h0; tx.in_eop_10 = 1'b0;
    tx.in_sop_11 = 1'b0; tx.in_stream_11 = 64'h0; tx.in_eop_11 = 1'b0;
    tx.in_sop_12 = 1'b0; tx.in_stream_12 = 64'h0; tx.in_eop_12 = 1'b0;
    tx.in_sop_13 = 1'b0; tx.in_stream_13 = 64'h0; tx.in_eop_13 = 1'b0;
    tx.in_sop_14 = 1'b0; tx.in_stream_14 = 64'h0; tx.in_eop_14 = 1'b0;
    tx.in_sop_15 = 1'b0; tx.in_stream_15 = 64'h0; tx.in_eop_15 = 1'b0;
    
    // Set packet data only for stream 0 with specific SOP/EOP values
    tx.in_sop_0 = sop;        
    tx.in_stream_0 = data;  
    tx.in_eop_0 = eop;       
    
    // Start the transaction
    start_item(tx);
    finish_item(tx);
  endtask
  
  // Task to set all streams to empty
  task set_all_streams_empty(bit [15:0] empty_status);
    tx = ulss_tx::type_id::create("tx");
    
    tx.rate_limiter_16to4_rstn = 1'b1;
    tx.sch_reg_wr_en = 1'b0;
    tx.sch_reg_wr_addr = 'd0;
    tx.sch_reg_wr_data = 'h0;
    
    // Set all empty status bits
    tx.pck_str_empty_0 = empty_status[0];
    tx.pck_str_empty_1 = empty_status[1];
    tx.pck_str_empty_2 = empty_status[2];
    tx.pck_str_empty_3 = empty_status[3];
    tx.pck_str_empty_4 = empty_status[4];
    tx.pck_str_empty_5 = empty_status[5];
    tx.pck_str_empty_6 = empty_status[6];
    tx.pck_str_empty_7 = empty_status[7];
    tx.pck_str_empty_8 = empty_status[8];
    tx.pck_str_empty_9 = empty_status[9];
    tx.pck_str_empty_10 = empty_status[10];
    tx.pck_str_empty_11 = empty_status[11];
    tx.pck_str_empty_12 = empty_status[12];
    tx.pck_str_empty_13 = empty_status[13];
    tx.pck_str_empty_14 = empty_status[14];
    tx.pck_str_empty_15 = empty_status[15];
    
    // Initialize all streams to idle
    tx.in_sop_0 = 1'b0; tx.in_stream_0 = 64'h0; tx.in_eop_0 = 1'b0;
    tx.in_sop_1 = 1'b0; tx.in_stream_1 = 64'h0; tx.in_eop_1 = 1'b0;
    tx.in_sop_2 = 1'b0; tx.in_stream_2 = 64'h0; tx.in_eop_2 = 1'b0;
    tx.in_sop_3 = 1'b0; tx.in_stream_3 = 64'h0; tx.in_eop_3 = 1'b0;
    tx.in_sop_4 = 1'b0; tx.in_stream_4 = 64'h0; tx.in_eop_4 = 1'b0;
    tx.in_sop_5 = 1'b0; tx.in_stream_5 = 64'h0; tx.in_eop_5 = 1'b0;
    tx.in_sop_6 = 1'b0; tx.in_stream_6 = 64'h0; tx.in_eop_6 = 1'b0;
    tx.in_sop_7 = 1'b0; tx.in_stream_7 = 64'h0; tx.in_eop_7 = 1'b0;
    tx.in_sop_8 = 1'b0; tx.in_stream_8 = 64'h0; tx.in_eop_8 = 1'b0;
    tx.in_sop_9 = 1'b0; tx.in_stream_9 = 64'h0; tx.in_eop_9 = 1'b0;
    tx.in_sop_10 = 1'b0; tx.in_stream_10 = 64'h0; tx.in_eop_10 = 1'b0;
    tx.in_sop_11 = 1'b0; tx.in_stream_11 = 64'h0; tx.in_eop_11 = 1'b0;
    tx.in_sop_12 = 1'b0; tx.in_stream_12 = 64'h0; tx.in_eop_12 = 1'b0;
    tx.in_sop_13 = 1'b0; tx.in_stream_13 = 64'h0; tx.in_eop_13 = 1'b0;
    tx.in_sop_14 = 1'b0; tx.in_stream_14 = 64'h0; tx.in_eop_14 = 1'b0;
    tx.in_sop_15 = 1'b0; tx.in_stream_15 = 64'h0; tx.in_eop_15 = 1'b0;
    
    // Start the transaction
    start_item(tx);
    finish_item(tx);
  endtask
endclass

