class soft_reset_sequence extends uvm_sequence#(ulss_tx);

  // Factory registration
  `uvm_object_utils(soft_reset_sequence)

  // Creating sequence item handle
  ulss_tx tx;

  int scenario;
 
  // Constructor
  function new(string name="soft_reset_sequence");
    super.new(name);
  endfunction
  
  // Build phase
  function void build_phase(uvm_phase phase);
    tx = ulss_tx::type_id::create("tx");
    // Not needed for sequences
  endfunction

  task body();
    `uvm_info (get_type_name(),"soft Reset seq: inside body", UVM_LOW);    

    if(scenario == 1) begin 
      // Step 1: Assert active low reset
        `uvm_do_with(tx, {
                            tx.rate_limiter_16to4_sw_rst==1;  
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
      $display("soft Reset signal is successfully generated in sequence=%b",tx.rate_limiter_16to4_sw_rst );
      `uvm_info(get_type_name(), "soft reset scenario 1 is completed", UVM_LOW);

    end
 endtask
endclass

