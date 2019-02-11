
class empty_packet_store_sequence extends uvm_sequence#(ulss_tx);

  // Factory registration
  `uvm_object_utils(empty_packet_store_sequence)

  // Creating sequence item handle
  ulss_tx tx;

  int scenario;

  // Constructor
  function new(string name="empty_packet_store_sequence");
    super.new(name);
  endfunction

  task body();
   // repeat(10)

    `uvm_info(get_type_name(), "empty_packet_store_sequence: inside body", UVM_LOW);
    
    // Create the transaction
    tx = ulss_tx::type_id::create("tx");
    
    // First ensure reset is asserted to start from clean state
    `uvm_do_with(tx, { 
      tx.rate_limiter_16to4_rstn == 1'b0;
      tx.sch_reg_wr_en   == 1'b0;
      tx.sch_reg_wr_addr == 5'd0;
      tx.sch_reg_wr_data == 64'h0;
      tx.in_sop_9 == 1'b0;
      tx.in_stream_9 == 1'b0;
      tx.in_eop_9 == 1'b0;
      tx.pck_str_empty_9 == 1'b1;
      
    });
    
    // Wait for reset to take effect
    repeat(5) #10;
    
    // De-assert reset and configure OUT_STREAM_2_REG
    `uvm_do_with(tx, { 
      tx.rate_limiter_16to4_rstn == 1'b1;
      tx.sch_reg_wr_en   == 1'b1;
      tx.sch_reg_wr_addr == 5'd2; // OUT_STREAM_2_REG
      tx.sch_reg_wr_data == 64'h0000_0000_0000_0200; // Map in_stream_9 to out_stream_2
      tx.in_sop_9 == 1'b0;
      tx.in_stream_9 == 1'b0;
      tx.in_eop_9 == 1'b0;
      tx.pck_str_empty_9 == 1'b1;
      

    });
    
    `uvm_info(get_type_name(), $sformatf("OUT_STREAM_2_REG=0x%0h", tx.sch_reg_wr_data), UVM_LOW);
    
    // Wait for register write to complete
    repeat(10) #10;
    
    // Configure IN_STREAM_9_REG
    `uvm_do_with(tx, {
      tx.rate_limiter_16to4_rstn == 1'b1;
      tx.sch_reg_wr_en   == 1'b1;
      tx.sch_reg_wr_addr == 5'd13; // IN_STREAM_9_REG (4 + 9 = 13)
      tx.sch_reg_wr_data[15:0]  == 16'd3;  // 3 tokens wait
      tx.sch_reg_wr_data[63:16] == 48'd1;  // 1 packet
      tx.in_sop_9 == 1'b0;
      tx.in_stream_9 == 1'b0;
      tx.in_eop_9 == 1'b0;
      tx.pck_str_empty_9 == 1'b1;
      

    });
    
    `uvm_info(get_type_name(), $sformatf("IN_STREAM_9_REG=0x%0h", tx.sch_reg_wr_data), UVM_LOW);
    
      // Wait for stable state
    repeat(15) #10;
    
    // SOP cycle - Start of Packet on stream 9
    `uvm_do_with(tx, {
      tx.rate_limiter_16to4_rstn == 1'b1;
      tx.sch_reg_wr_en == 1'b0;
      
      // Set empty flags for all streams - only stream 9 is not empty
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
      tx.pck_str_empty_13 == 1'b1;
      tx.pck_str_empty_14 == 1'b1;
      tx.pck_str_empty_15 == 1'b1;
      
      // Start of packet
      tx.in_sop_9 == 1'b1;
     // tx.in_stream_9 == 64'h1111_1111_1111_1111;
      // tx.in_stream_9 inside {[64'h0000000000000000 : 64'hFFFFFFFFFFFFFFFF],
                            // [64'h8000000000000000 : 64'h7FFFFFFFFFFFFFFF]}; 
      tx.in_eop_9 == 1'b1; 
    });
    
    `uvm_info(get_type_name(), $sformatf("Sent SOP on stream 9 with data=0x%0h", tx.in_stream_9), UVM_LOW);
    
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
      tx.in_sop_9 == 1'b0;
      tx.in_stream_9 == 64'h0;
      tx.in_eop_9 == 1'b0;
    });
    
    // Allow time for grant signals to stabilize
    repeat(15) #10;
    
    // Final drain/clear state to ensure correct completion
    `uvm_do_with(tx, {
      tx.rate_limiter_16to4_rstn == 1'b1;
      tx.sch_reg_wr_en == 1'b0;
      tx.pck_str_empty_9 == 1'b1;
      tx.in_sop_9 == 1'b0;
      tx.in_stream_9 == 64'h0;
      tx.in_eop_9 == 1'b0;
    });
    
    // Final wait to ensure completion
    repeat(10) #10;
    
    `uvm_info(get_type_name(), "empty_packet_store_sequence completed successfully", UVM_LOW);
  endtask
endclass 
