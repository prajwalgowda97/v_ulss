
class stream_map_sequence extends uvm_sequence#(ulss_tx);

  // Factory registration
  `uvm_object_utils(stream_map_sequence)

  // Creating sequence item handle
  ulss_tx tx;

  int scenario;

  // Constructor
  function new(string name="stream_map_sequence");
    super.new(name);
  endfunction

  task body();
   // repeat(10)

    `uvm_info(get_type_name(), "stream_map_sequence: inside body", UVM_LOW);
    
    // Create the transaction
    tx = ulss_tx::type_id::create("tx");
    
 
 if(scenario==2)begin
    // De-assert reset and configure OUT_STREAM_0_REG
    // This maps which input stream goes to output stream 0
    `uvm_do_with(tx, { 
      tx.rate_limiter_16to4_rstn == 1'b1;
      tx.sch_reg_wr_en   == 1'b1;
      tx.sch_reg_wr_addr == 5'd0; // OUT_STREAM_0_REG
      tx.sch_reg_wr_data == 64'h0000_0000_0000_0001; // Map in_stream_0 to out_stream_0
        tx.in_sop_0 == 1'b0;  // Start of packet
      tx.in_stream_0 ==1'b0;  // Packet data
      tx.in_eop_0 == 1'b0;  // End of packet
      


    });
    
    `uvm_info(get_type_name(), $sformatf("OUT_STREAM_0_REG=0x%0h", tx.sch_reg_wr_data), UVM_LOW);
    
    // Wait for register write to complete
  //repeat(2) #10;
    
    // Configure IN_STREAM_0_REG
    `uvm_do_with(tx, {
      tx.rate_limiter_16to4_rstn == 1'b1;
      tx.sch_reg_wr_en   == 1'b1;
      tx.sch_reg_wr_addr == 5'd4; // IN_STREAM_0_REG
      tx.sch_reg_wr_data[15:0]  == 16'd3;  // 3 tokens wait
      tx.sch_reg_wr_data[63:16] == 48'd1;  // 1 packet
      tx.in_sop_0 == 1'b0;  // Start of packet
      tx.in_stream_0 ==1'b0;  // Packet data
      tx.in_eop_0 == 1'b0;  // End of packet
      

    });
    
    `uvm_info(get_type_name(), $sformatf("IN_STREAM_0_REG=0x%0h", tx.sch_reg_wr_data), UVM_LOW);
    
    // Wait for register write to complete
    repeat(10) #10;
    
    // Now send a packet on stream 0 only
    `uvm_do_with(tx, {
      // Disable register write mode
      tx.sch_reg_wr_en   == 1'b0;
      tx.sch_reg_wr_addr == 'd0; 
      tx.sch_reg_wr_data == 'h0;
      
      // Keep reset de-asserted
      tx.rate_limiter_16to4_rstn == 1'b1;
      
      // Set stream 0 as NOT empty (has data)
      tx.pck_str_empty_0 == 1'b0;
      
      // Define packet for stream 0
      tx.in_sop_0 == 1'b1;  // Start of packet
      tx.in_stream_0 inside {[64'h0000000000000000 : 64'hFFFFFFFFFFFFFFFF],
                             [64'h8000000000000000 : 64'h7FFFFFFFFFFFFFFF]};  // Packet data
      tx.in_eop_0 == 1'b1;  // End of packet
      
      // Set all other streams to empty
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
      
      // All other streams' signals should be default/idle
      tx.in_sop_1 == 1'b0; tx.in_stream_1 == 64'h0; tx.in_eop_1 == 1'b0;
      tx.in_sop_2 == 1'b0; tx.in_stream_2 == 64'h0; tx.in_eop_2 == 1'b0;
      tx.in_sop_3 == 1'b0; tx.in_stream_3 == 64'h0; tx.in_eop_3 == 1'b0;
      tx.in_sop_4 == 1'b0; tx.in_stream_4 == 64'h0; tx.in_eop_4 == 1'b0;
      tx.in_sop_5 == 1'b0; tx.in_stream_5 == 64'h0; tx.in_eop_5 == 1'b0;
      tx.in_sop_6 == 1'b0; tx.in_stream_6 == 64'h0; tx.in_eop_6 == 1'b0;
      tx.in_sop_7 == 1'b0; tx.in_stream_7 == 64'h0; tx.in_eop_7 == 1'b0;
      tx.in_sop_8 == 1'b0; tx.in_stream_8 == 64'h0; tx.in_eop_8 == 1'b0;
      tx.in_sop_9 == 1'b0; tx.in_stream_9 == 64'h0; tx.in_eop_9 == 1'b0;
      tx.in_sop_10 == 1'b0; tx.in_stream_10 == 64'h0; tx.in_eop_10 == 1'b0;
      tx.in_sop_11 == 1'b0; tx.in_stream_11 == 64'h0; tx.in_eop_11 == 1'b0;
      tx.in_sop_12 == 1'b0; tx.in_stream_12 == 64'h0; tx.in_eop_12 == 1'b0;
      tx.in_sop_13 == 1'b0; tx.in_stream_13 == 64'h0; tx.in_eop_13 == 1'b0;
      tx.in_sop_14 == 1'b0; tx.in_stream_14 == 64'h0; tx.in_eop_14 == 1'b0;
      tx.in_sop_15 == 1'b0; tx.in_stream_15 == 64'h0; tx.in_eop_15 == 1'b0;
    });
    
    `uvm_info(get_type_name(), $sformatf("Sent packet on stream 0 with data=0x%0h", tx.in_stream_0), UVM_LOW);
    
    // Wait some time to allow packet processing
    repeat(10) #10;
    
    // Set stream 0 back to empty
    `uvm_do_with(tx, {
      tx.rate_limiter_16to4_rstn == 1'b1;
      tx.sch_reg_wr_en == 1'b0;
      tx.pck_str_empty_0 == 1'b1;
      tx.in_sop_0 == 1'b0;
      tx.in_stream_0 == 64'h0;
      tx.in_eop_0 == 1'b0;
    });
    
    `uvm_info(get_type_name(), "stream_map_sequence completed", UVM_LOW);
    end
  endtask
endclass 

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


