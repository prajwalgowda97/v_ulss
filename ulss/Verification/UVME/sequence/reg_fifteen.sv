class reg_fifteen extends uvm_sequence#(ulss_tx);

  // Factory registration
  `uvm_object_utils(reg_fifteen)

  // Creating sequence item handle
   ulss_tx tx;

   int scenario;

  // Constructor
  function new(string name="reg_fifteen");
    super.new(name);
  endfunction
  
  // Build phase
  function void build_phase(uvm_phase phase);
    tx = ulss_tx::type_id::create("tx");
    // Not needed for sequences
  endfunction

  task body();
    `uvm_info (get_type_name(),"reg_fifteen seq: inside body", UVM_LOW);    
            if(scenario == 2) begin
                repeat(10)
            // First, deassert reset
            `uvm_do_with(tx, {

                                tx.rate_limiter_16to4_rstn == 1;

                                tx.sch_reg_wr_en   == 1'b1;
                                tx.sch_reg_wr_addr == 5'd15; // IN_STREAM_0_REG
                                tx.sch_reg_wr_data == {48'd1, 16'd0}; /// 1 packet, token wait 0 

                                tx.pck_str_empty_1 == 1'b1;
                                tx.in_sop_1     == 1'b0; // Start of packet
                                tx.in_stream_1  == 64'h0; // Packet data
                                tx.in_eop_1     == 1'b0; // Not end of packet yet
                                           
                                tx.pck_str_empty_2 == 1'b1;
                                tx.in_sop_2    == 1'b0; // Start of packet
                                tx.in_stream_2 == 64'h0; // Packet data
                                tx.in_eop_2    == 1'b0; // Not end of packet yet
                                           
                                tx.pck_str_empty_3== 1'b1;
                                tx.in_sop_3    == 1'b0; // Start of packet
                                tx.in_stream_3 == 64'h0; // Packet data
                                tx.in_eop_3    == 1'b0; // Not end of packet yet
                                           
                                tx.pck_str_empty_4== 1'b1;
                                tx.in_sop_4    == 1'b0; // Start of packet
                                tx.in_stream_4 == 64'h0; // Packet data
                                tx.in_eop_4    == 1'b0; // Not end of packet yet
                                            
                                tx.pck_str_empty_5== 1'b1;
                                tx.in_sop_5    == 1'b0; // Start of packet
                                tx.in_stream_5 == 64'h0; // Packet data
                                tx.in_eop_5    == 1'b0; // Not end of packet yet
                                        
                                tx.pck_str_empty_6== 1'b1;
                                tx.in_sop_6    == 1'b0; // Start of packet
                                tx.in_stream_6 == 64'h0; // Packet data
                                tx.in_eop_6    == 1'b0; // Not end of packet yet
                                           
                                tx.pck_str_empty_7== 1'b1;
                                tx.in_sop_7    == 1'b0; // Start of packet
                                tx.in_stream_7 == 64'h0; // Packet data
                                tx.in_eop_7    == 1'b0; // Not end of packet yet
                                     
                                tx.pck_str_empty_8== 1'b1;
                                tx.in_sop_8    == 1'b0; // Start of packet
                                tx.in_stream_8 == 64'h0; // Packet data
                                tx.in_eop_8    == 1'b0; // Not end of packet yet
                                      
                                tx.pck_str_empty_9== 1'b1;
                                tx.in_sop_9    == 1'b0; // Start of packet
                                tx.in_stream_9 == 64'h0; // Packet data
                                tx.in_eop_9    == 1'b0; // Not end of packet yet
                                       
                                tx.pck_str_empty_10== 1'b1;
                                tx.in_sop_10    == 1'b0; // Start of packet
                                tx.in_stream_10 == 64'h0; // Packet data
                                tx.in_eop_10    == 1'b0; // Not end of packet yet
                                                
                                tx.pck_str_empty_11== 1'b1;
                                tx.in_sop_11    == 1'b0; // Start of packet
                                tx.in_stream_11 == 64'h0; // Packet data
                                tx.in_eop_11    == 1'b0; // Not end of packet yet
                                               
                                tx.pck_str_empty_12== 1'b1;
                                tx.in_sop_12    == 1'b0; // Start of packet
                                tx.in_stream_12 == 64'h0; // Packet data
                                tx.in_eop_12    == 1'b0; // Not end of packet yet
                                              
                                tx.pck_str_empty_13== 1'b1;
                                tx.in_sop_13    == 1'b0; // Start of packet
                                tx.in_stream_13 == 64'h0; // Packet data
                                tx.in_eop_13    == 1'b0; // Not end of packet yet
                                                  
                                tx.pck_str_empty_14== 1'b1;
                                tx.in_sop_14    == 1'b0; // Start of packet
                                tx.in_stream_14 == 64'h0; // Packet data
                                tx.in_eop_14    == 1'b0; // Not end of packet yet
                                                
                                tx.pck_str_empty_15== 1'b1;
                                tx.in_sop_15    == 1'b0; // Start of packet
                                tx.in_stream_15 == 64'h0; // Packet data
                                tx.in_eop_15    == 1'b0; // Not end of packet yet
                                             
                                tx.pck_str_empty_0 == 1'b1; // -empty packet for stream 0
                                tx.in_sop_0        == 1'b0; // Start of packet
                                tx.in_stream_0     == 64'h0;  // Packet data
                                tx.in_eop_0        == 1'b0; // Not end of packet yet
     
                       });  
      $display("Reset signal is successfully generated in sequence=%b", tx.rate_limiter_16to4_rstn);
    end    
  endtask
endclass
