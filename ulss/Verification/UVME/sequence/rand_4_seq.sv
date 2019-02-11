class rand_4_seq extends uvm_sequence#(ulss_tx);

  // Factory registration
  `uvm_object_utils(rand_4_seq)

  // Creating sequence item handle
   ulss_tx tx;

   int scenario;
   int sid;

  // Constructor
  function new(string name="rand_4_seq");
    super.new(name);
  endfunction
  
  // Build phase
  function void build_phase(uvm_phase phase);
    tx = ulss_tx::type_id::create("tx");
    // Not needed for sequences
  endfunction

  task body();
    `uvm_info (get_type_name(),"rand_4_seq seq: inside body", UVM_LOW);    

    if(scenario == 1) begin 
     repeat(200)
      // Step 1: Assert active low reset
                  `uvm_do_with(tx,{
                     tx.rate_limiter_16to4_rstn == 1;   
                               });

       $display("Reset signal is successfully generated in sequence=%b", tx.rate_limiter_16to4_rstn);
      `uvm_info(get_type_name(), "reset scenario 1 is completed", UVM_LOW);
        
    end
    endtask
    endclass
