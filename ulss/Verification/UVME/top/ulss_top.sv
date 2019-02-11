module ulss_top;

    import uvm_pkg::*;
    import test_pkg::*;

    `include "uvm_macros.svh"
     bit  rate_limiter_16to4_clk;

//creating interface handle
     ulss_interface vif(rate_limiter_16to4_clk);


////////////dut instanciation/////////////////////////////////
 rate_limiter_16to4 dut (  
                            .rate_limiter_16to4_clk(vif.rate_limiter_16to4_clk),      
                            .rate_limiter_16to4_rstn(vif.rate_limiter_16to4_rstn),     
                            .rate_limiter_16to4_sw_rst(vif.rate_limiter_16to4_sw_rst),

                             // SIGNALS FOR COFIGURING SCHEDULER REGISTERS
                            .sch_reg_wr_en(vif.sch_reg_wr_en),
                            .sch_reg_wr_addr(vif.sch_reg_wr_addr),
                            .sch_reg_wr_data(vif.sch_reg_wr_data),

                             //inputs
                             .in_sop_0(vif.in_sop_0),           
                             .in_stream_0(vif.in_stream_0),                
                             .in_eop_0(vif.in_eop_0),

                             .in_sop_1(vif.in_sop_1),           
                             .in_stream_1(vif.in_stream_1),                
                             .in_eop_1(vif.in_eop_1), 

                             .in_sop_2(vif.in_sop_2),           
                             .in_stream_2(vif.in_stream_2),                
                             .in_eop_2(vif.in_eop_2),

                             .in_sop_3(vif.in_sop_3),           
                             .in_stream_3(vif.in_stream_3),                
                             .in_eop_3(vif.in_eop_3),  

                             .in_sop_4(vif.in_sop_4),           
                             .in_stream_4(vif.in_stream_4),                
                             .in_eop_4(vif.in_eop_4),

                             .in_sop_5(vif.in_sop_5),           
                             .in_stream_5(vif.in_stream_5),                
                             .in_eop_5(vif.in_eop_5),                   

                             .in_sop_6(vif.in_sop_6),           
                             .in_stream_6(vif.in_stream_6),                
                             .in_eop_6(vif.in_eop_6),                   

                             .in_sop_7(vif.in_sop_7),           
                             .in_stream_7(vif.in_stream_7),                
                             .in_eop_7(vif.in_eop_7),

                             .in_sop_8(vif.in_sop_8),           
                             .in_stream_8(vif.in_stream_8),                
                             .in_eop_8(vif.in_eop_8), 

                             .in_sop_9(vif.in_sop_9),           
                             .in_stream_9(vif.in_stream_9),                
                             .in_eop_9(vif.in_eop_9),

                             .in_sop_10(vif.in_sop_10),           
                             .in_stream_10(vif.in_stream_10),                
                             .in_eop_10(vif.in_eop_10), 

                             .in_sop_11(vif.in_sop_11),           
                             .in_stream_11(vif.in_stream_11),                
                             .in_eop_11(vif.in_eop_11),

                             .in_sop_12(vif.in_sop_12),           
                             .in_stream_12(vif.in_stream_12),                
                             .in_eop_12(vif.in_eop_12),

                             .in_sop_13(vif.in_sop_13),           
                             .in_stream_13(vif.in_stream_13),                
                             .in_eop_13(vif.in_eop_13),

                             .in_sop_14(vif.in_sop_14),           
                             .in_stream_14(vif.in_stream_14),                
                             .in_eop_14(vif.in_eop_14),                   

                             .in_sop_15(vif.in_sop_15),           
                             .in_stream_15(vif.in_stream_15),                
                             .in_eop_15(vif.in_eop_15),                   

                             .pck_str_empty_0(vif.pck_str_empty_0),
                             .pck_str_empty_1(vif.pck_str_empty_1),            
                             .pck_str_empty_2(vif.pck_str_empty_2),            
                             .pck_str_empty_3(vif.pck_str_empty_3),            
                             .pck_str_empty_4(vif.pck_str_empty_4),            
                             .pck_str_empty_5(vif.pck_str_empty_5),            
                             .pck_str_empty_6(vif.pck_str_empty_6),            
                             .pck_str_empty_7(vif.pck_str_empty_7),            
                             .pck_str_empty_8(vif.pck_str_empty_8),            
                             .pck_str_empty_9(vif.pck_str_empty_9),            
                             .pck_str_empty_10(vif.pck_str_empty_10),            
                             .pck_str_empty_11(vif.pck_str_empty_11),            
                             .pck_str_empty_12(vif.pck_str_empty_12),            
                             .pck_str_empty_13(vif.pck_str_empty_13),            
                             .pck_str_empty_14(vif.pck_str_empty_14),            
                             .pck_str_empty_15(vif.pck_str_empty_15),            
                          

 //////////////////////////////////outputs/////////////////////////////////////
                             .pck_rd_en_grnt_0(vif.pck_rd_en_grnt_0),
                             .pck_rd_en_grnt_1(vif.pck_rd_en_grnt_1),
                             .pck_rd_en_grnt_2(vif.pck_rd_en_grnt_2),
                             .pck_rd_en_grnt_3(vif.pck_rd_en_grnt_3),
                             .pck_rd_en_grnt_4(vif.pck_rd_en_grnt_4),
                             .pck_rd_en_grnt_5(vif.pck_rd_en_grnt_5),
                             .pck_rd_en_grnt_6(vif.pck_rd_en_grnt_6),
                             .pck_rd_en_grnt_7(vif.pck_rd_en_grnt_7),
                             .pck_rd_en_grnt_8(vif.pck_rd_en_grnt_8),
                             .pck_rd_en_grnt_9(vif.pck_rd_en_grnt_9),
                             .pck_rd_en_grnt_10(vif.pck_rd_en_grnt_10),
                             .pck_rd_en_grnt_11(vif.pck_rd_en_grnt_11),
                             .pck_rd_en_grnt_12(vif.pck_rd_en_grnt_12),
                             .pck_rd_en_grnt_13(vif.pck_rd_en_grnt_13),
                             .pck_rd_en_grnt_14(vif.pck_rd_en_grnt_14),
                             .pck_rd_en_grnt_15(vif.pck_rd_en_grnt_15),

                             .out_stream_0_valid(vif.out_stream_0_valid),
                             .out_sop_0(vif.out_sop_0),
                             .out_stream_0(vif.out_stream_0),
                             .out_eop_0(vif.out_eop_0),

                             .out_stream_1_valid(vif.out_stream_1_valid),
                             .out_sop_1(vif.out_sop_1),
                             .out_stream_1(vif.out_stream_1),
                             .out_eop_1(vif.out_eop_1),

                             .out_stream_2_valid(vif.out_stream_2_valid),
                             .out_sop_2(vif.out_sop_2),
                             .out_stream_2(vif.out_stream_2),
                             .out_eop_2(vif.out_eop_2),

                             .out_stream_3_valid(vif.out_stream_3_valid),
                             .out_sop_3(vif.out_sop_3),
                             .out_stream_3(vif.out_stream_3),
                             .out_eop_3(vif.out_eop_3));


////////////////clock generation///////////////////////////////
  initial
  begin
       rate_limiter_16to4_clk=1'b0;
    forever begin 
       #2 rate_limiter_16to4_clk = 1'b1;

       #2 rate_limiter_16to4_clk =1'b0;

    end 
  end
  
   initial begin
    //setting config db in top
    uvm_config_db#(virtual ulss_interface)::set(null,"*","ulss_interface", vif);
  end

initial begin
    string test_name;
     int wait_timeout_cycles =36000;       // Default for regular tests
  int simulation_timeout_cycles = 36000;

    if ($value$plusargs("UVM_TESTNAME=%s", test_name)) begin
        if (test_name == "maximum_token_test") begin
        uvm_config_db#(int)::set(null, "env.agent.drv", "wait_timeout_cycles", 36000);
        uvm_config_db#(int)::set(null, "env.agent.drv", "simulation_timeout_cycles", 36000);
        end
    end
end

 initial begin
    $shm_open("wave.shm");
    $shm_probe("ACTMF");
  end

initial begin
    run_test("ulss_base_test");
    end

endmodule
