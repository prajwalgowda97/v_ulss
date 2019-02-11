
class reset_sequence extends uvm_sequence#(ulss_tx);

  // Factory registration
  `uvm_object_utils(reset_sequence)

  // Creating sequence item handle
   ulss_tx tx;

   int scenario;
   int sid;

  // Constructor
  function new(string name="reset_sequence");
    super.new(name);
  endfunction
  
  // Build phase
  function void build_phase(uvm_phase phase);
    tx = ulss_tx::type_id::create("tx");
    // Not needed for sequences
  endfunction

  task body();
    `uvm_info (get_type_name(),"Reset seq: inside body", UVM_LOW);    

    if(scenario == 1) begin 
      // Step 1: Assert active low reset
   `uvm_do_with(tx,{
                     tx.rate_limiter_16to4_rstn == 0;   
                     // Initialize register signals to 0
                     tx.sch_reg_wr_en == 0;
                     tx.sch_reg_wr_addr == 0;
                     tx.sch_reg_wr_data == 0;   
                     // Initialize all input stream signals to 0
                     tx.in_sop_0 == 0; tx.in_stream_0 == 0; tx.in_eop_0 == 0;
                     tx.in_sop_1 == 0; tx.in_stream_1 == 0; tx.in_eop_1 == 0;
                     tx.in_sop_2 == 0; tx.in_stream_2 == 0; tx.in_eop_2 == 0;
                     tx.in_sop_3 == 0; tx.in_stream_3 == 0; tx.in_eop_3 == 0;
                     tx.in_sop_4 == 0; tx.in_stream_4 == 0; tx.in_eop_4 == 0;
                     tx.in_sop_5 == 0; tx.in_stream_5 == 0; tx.in_eop_5 == 0;
                     tx.in_sop_6 == 0; tx.in_stream_6 == 0; tx.in_eop_6 == 0;
                     tx.in_sop_7 == 0; tx.in_stream_7 == 0; tx.in_eop_7 == 0;
                     tx.in_sop_8 == 0; tx.in_stream_8 == 0; tx.in_eop_8 == 0;
                     tx.in_sop_9 == 0; tx.in_stream_9 == 0; tx.in_eop_9 == 0;
                     tx.in_sop_10 == 0; tx.in_stream_10 == 0; tx.in_eop_10 == 0;
                     tx.in_sop_11 == 0; tx.in_stream_11 == 0; tx.in_eop_11 == 0;
                     tx.in_sop_12 == 0; tx.in_stream_12 == 0; tx.in_eop_12 == 0;
                     tx.in_sop_13 == 0; tx.in_stream_13 == 0; tx.in_eop_13 == 0;
                     tx.in_sop_14 == 0; tx.in_stream_14 == 0; tx.in_eop_14 == 0;
                     tx.in_sop_15 == 0; tx.in_stream_15 == 0; tx.in_eop_15 == 0;

                     tx.pck_str_empty_0 == 0;
                     tx.pck_str_empty_1 == 0;
                     tx.pck_str_empty_2 == 0;
                     tx.pck_str_empty_3 == 0;
                     tx.pck_str_empty_4 == 0;
                     tx.pck_str_empty_5 == 0;
                     tx.pck_str_empty_6 == 0;
                     tx.pck_str_empty_7 == 0;
                     tx.pck_str_empty_8 == 0;
                     tx.pck_str_empty_9 == 0;
                     tx.pck_str_empty_10 == 0;            
                     tx.pck_str_empty_11 == 0;
                     tx.pck_str_empty_12 == 0;
                     tx.pck_str_empty_13 == 0;           
                     tx.pck_str_empty_14 == 0;           
                     tx.pck_str_empty_15 == 0; 
               });
       $display("Reset signal is successfully generated in sequence=%b", tx.rate_limiter_16to4_rstn);
      `uvm_info(get_type_name(), "reset scenario 1 is completed", UVM_LOW);
        
    end

    if(scenario == 2) begin
      // First, deassert reset
      `uvm_do_with(tx, {
        tx.rate_limiter_16to4_rstn == 1;
      tx.sch_reg_wr_en   == 1'b1;
      tx.sch_reg_wr_addr == 5'd0; // OUT_STREAM_0_REG
      tx.sch_reg_wr_data == 64'h0000_0000_0000_0001; // Input stream 0 mapped
/* `uvm_do_with(tx, {

      tx.sch_reg_wr_en   == 1'b1;
      tx.sch_reg_wr_addr == 5'd4; // IN_STREAM_0_REG
      tx.sch_reg_wr_data == {49'd1, 15'd0}; */// 1 packet, token wait 0 */
      tx.pck_str_empty_1 == 1'b1;
      tx.in_sop_1     == 1'b0; // Start of packet
      tx.in_stream_1  == 64'h0; // Packet data
      tx.in_eop_1     == 1'b0; // Not end of packet yet
      
       //make start of packet on stream 0
      
      tx.pck_str_empty_2 == 1'b1;
      tx.in_sop_2    == 1'b0; // Start of packet
      tx.in_stream_2 == 64'h0; // Packet data
      tx.in_eop_2    == 1'b0; // Not end of packet yet
      
 //make start of packet on stream 0
      
      tx.pck_str_empty_3== 1'b1;
      tx.in_sop_3    == 1'b0; // Start of packet
      tx.in_stream_3 == 64'h0; // Packet data
      tx.in_eop_3    == 1'b0; // Not end of packet yet
      
 //make start of packet on stream 0
      
      tx.pck_str_empty_4== 1'b1;
      tx.in_sop_4    == 1'b0; // Start of packet
      tx.in_stream_4 == 64'h0; // Packet data
      tx.in_eop_4    == 1'b0; // Not end of packet yet
      
 //make start of packet on stream 0
      
      tx.pck_str_empty_5== 1'b1;
      tx.in_sop_5    == 1'b0; // Start of packet
      tx.in_stream_5 == 64'h0; // Packet data
      tx.in_eop_5    == 1'b0; // Not end of packet yet
      
 //make start of packet on stream 0
      
      tx.pck_str_empty_6== 1'b1;
      tx.in_sop_6    == 1'b0; // Start of packet
      tx.in_stream_6 == 64'h0; // Packet data
      tx.in_eop_6    == 1'b0; // Not end of packet yet
      
 //make start of packet on stream 0
      
      tx.pck_str_empty_7== 1'b1;
      tx.in_sop_7    == 1'b0; // Start of packet
      tx.in_stream_7 == 64'h0; // Packet data
      tx.in_eop_7    == 1'b0; // Not end of packet yet
      
 //make start of packet on stream 0
      
      tx.pck_str_empty_8== 1'b1;
      tx.in_sop_8    == 1'b0; // Start of packet
      tx.in_stream_8 == 64'h0; // Packet data
      tx.in_eop_8    == 1'b0; // Not end of packet yet
      
 //make start of packet on stream 0
      
      tx.pck_str_empty_9== 1'b1;
      tx.in_sop_9    == 1'b0; // Start of packet
      tx.in_stream_9 == 64'h0; // Packet data
      tx.in_eop_9    == 1'b0; // Not end of packet yet
      
 //make start of packet on stream 0
      
      tx.pck_str_empty_10== 1'b1;
      tx.in_sop_10    == 1'b0; // Start of packet
      tx.in_stream_10 == 64'h0; // Packet data
      tx.in_eop_10    == 1'b0; // Not end of packet yet
      
 //make start of packet on stream 0
      
      tx.pck_str_empty_11== 1'b1;
      tx.in_sop_11    == 1'b0; // Start of packet
      tx.in_stream_11 == 64'h0; // Packet data
      tx.in_eop_11    == 1'b0; // Not end of packet yet
      
 //make start of packet on stream 0
      
      tx.pck_str_empty_12== 1'b1;
      tx.in_sop_12    == 1'b0; // Start of packet
      tx.in_stream_12 == 64'h0; // Packet data
      tx.in_eop_12    == 1'b0; // Not end of packet yet
      
 //make start of packet on stream 0
      
      tx.pck_str_empty_13== 1'b1;
      tx.in_sop_13    == 1'b0; // Start of packet
      tx.in_stream_13 == 64'h0; // Packet data
      tx.in_eop_13    == 1'b0; // Not end of packet yet
      
 //make start of packet on stream 0
      
      tx.pck_str_empty_14== 1'b1;
      tx.in_sop_14    == 1'b0; // Start of packet
      tx.in_stream_14 == 64'h0; // Packet data
      tx.in_eop_14    == 1'b0; // Not end of packet yet
      
 //make start of packet on stream 0
      
      tx.pck_str_empty_15== 1'b1;
      tx.in_sop_15    == 1'b0; // Start of packet
      tx.in_stream_15 == 64'h0; // Packet data
      tx.in_eop_15    == 1'b0; // Not end of packet yet
      


      // Send start of packet on stream 0
      
      tx.pck_str_empty_0 == 1'b1; // Non-empty packet for stream 0
      tx.in_sop_0        == 1'b0; // Start of packet
      tx.in_stream_0     == 64'h0; //1234_5678_DEAD_BEEF; // Packet data
      tx.in_eop_0        == 1'b0; // Not end of packet yet
      


      // Complete packet transmission with end of packet
      
      /*tx.pck_str_empty_0 == 1'b0;
      tx.in_sop_0        == 1'b0; // Not start
      tx.in_stream_0     == 64'h0; // Could be different data if needed
      tx.in_eop_0        == 1'b0; // End of packet
      
      
      // Reset signals after packet transmission
      
      tx.pck_str_empty_0 == 1'b1; // Empty again
      tx.in_sop_0        == 1'b0;
      tx.in_stream_0     == 64'h0;
      tx.in_eop_0        == 1'b0; */
         });   

      `uvm_info("ULSS", $sformatf("Stream 0 packet sent"), UVM_LOW)
      `uvm_info(get_type_name(), "Starting ULSS Sequence for Stream 0 Only", UVM_MEDIUM)   
      $display("Reset signal is successfully generated in sequence=%b", tx.rate_limiter_16to4_rstn);
    end
    
    // Add delay to ensure all transactions are processed
    //#10;
  endtask
endclass
