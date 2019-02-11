class rand_2_seq extends uvm_sequence#(ulss_tx);

  // Factory registration
  `uvm_object_utils(rand_2_seq)

  // Creating sequence item handle
   ulss_tx tx;
   rand bit [0:63]sch_reg_wr_data;

   int scenario;
   int sid;

  // Constructor
  function new(string name="rand_2_seq");
    super.new(name);
  endfunction
  
  // Build phase
  function void build_phase(uvm_phase phase);
    tx = ulss_tx::type_id::create("tx");
    // Not needed for sequences
  endfunction

  task body();
    `uvm_info (get_type_name(),"rand_2_seq seq: inside body", UVM_LOW);    

    if(scenario == 1) begin 
     repeat(200)
      // Step 1: Assert active low reset
                  `uvm_do_with(tx,{
                     tx.rate_limiter_16to4_rstn == 1; 
                     tx.sch_reg_wr_en   == 1'b1;
                     // tx.sch_reg_wr_addr == 5'd4; 
                      tx.sch_reg_wr_data[15:0] inside {[0:15]}; 
                      tx.sch_reg_wr_data[63:16] inside {[0:15]};  
                               });

       $display("Reset signal is successfully generated in sequence=%b", tx.rate_limiter_16to4_rstn);
      `uvm_info(get_type_name(), "reset scenario 1 is completed", UVM_LOW);
        
    end
    endtask
    endclass
