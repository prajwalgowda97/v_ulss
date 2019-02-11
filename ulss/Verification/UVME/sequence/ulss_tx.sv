class ulss_tx extends uvm_sequence_item;

                      rand bit [63:0] packet_data [15:0][];  
                      rand bit                         rate_limiter_16to4_clk      ;
                      rand bit                         rate_limiter_16to4_rstn     ;
                      rand bit                         rate_limiter_16to4_sw_rst   ;

                        //   SIGNALS FOR COFIGURING SCHEDULER REGISTERS
                      rand bit                         sch_reg_wr_en               ;
                      rand bit   [5-1:0]               sch_reg_wr_addr             ;
                      rand bit   [64-1:0]              sch_reg_wr_data             ;

                      ////////////////////////     INPUTS     ///////////////////////////
                        //   INPUTS FROM STREAM_0
                      rand bit                         in_sop_0                    ;
                      rand bit   [64-1:0]              in_stream_0                 ;
                      rand bit                         in_eop_0                    ; 

                        //   INPUTS FROM STREAM_1
                      rand bit                         in_sop_1                    ;
                      rand bit   [64-1:0]              in_stream_1                 ;
                      rand bit                         in_eop_1                    ; 

                         //   INPUTS FROM STREAM_2
                      rand bit                         in_sop_2                    ;
                      rand bit   [64-1:0]              in_stream_2                 ;
                      rand bit                         in_eop_2                    ;

                        //   INPUTS FROM STREAM_3
                      rand bit                         in_sop_3                    ;
                      rand bit   [64-1:0]              in_stream_3                 ;
                      rand bit                         in_eop_3                    ;

                         //   INPUTS FROM STREAM_4
                      rand bit                         in_sop_4                    ;
                      rand bit   [64-1:0]              in_stream_4                 ;
                      rand bit                         in_eop_4                    ;

                         //   INPUTS FROM STREAM_5
                      rand bit                         in_sop_5                    ;
                      rand bit   [64-1:0]              in_stream_5                 ;
                      rand bit                         in_eop_5                    ;

                         //   INPUTS FROM STREAM_6
                      rand bit                         in_sop_6                    ;
                      rand bit   [64-1:0]              in_stream_6                 ;
                      rand bit                         in_eop_6                    ;

                         //   INPUTS FROM STREAM_7
                      rand bit                         in_sop_7                    ;
                      rand bit   [64-1:0]              in_stream_7                 ;
                      rand bit                         in_eop_7                    ;

                       //   INPUTS FROM STREAM_8
                      rand bit                         in_sop_8                    ;
                      rand bit   [64-1:0]              in_stream_8                 ;
                      rand bit                         in_eop_8                    ;
  
                       //   INPUTS FROM STREAM_9
                      rand bit                         in_sop_9                    ;
                      rand bit   [64-1:0]              in_stream_9                 ;
                      rand bit                         in_eop_9                    ;

                        //   INPUTS FROM STREAM_10
                      rand bit                         in_sop_10                   ;
                      rand bit   [64-1:0]              in_stream_10                ;
                      rand bit                         in_eop_10                   ;

                        //   INPUTS FROM STREAM_11
                      rand bit                         in_sop_11                   ;
                      rand bit   [64-1:0]              in_stream_11                ;
                      rand bit                         in_eop_11                   ;

                        //   INPUTS FROM STREAM_12
                      rand bit                         in_sop_12                   ;
                      rand bit   [64-1:0]              in_stream_12                ;
                      rand bit                         in_eop_12                   ;

                       //   INPUTS FROM STREAM_13
                      rand bit                         in_sop_13                   ;
                      rand bit   [64-1:0]              in_stream_13                ;
                      rand bit                         in_eop_13                   ;

                      //   INPUTS FROM STREAM_14
                      rand bit                         in_sop_14                   ;
                      rand bit   [64-1:0]              in_stream_14                ;
                      rand bit                         in_eop_14                   ;

                      //   INPUTS FROM STREAM_15
                      rand bit                         in_sop_15                   ;
                      rand bit   [64-1:0]              in_stream_15                ;
                      rand bit                         in_eop_15                   ; 

                        //   16 PACKET STORE EMPTY SIGNAL  
                      rand bit                         pck_str_empty_0             ;
                      rand bit                         pck_str_empty_1             ;
                      rand bit                         pck_str_empty_2             ;
                      rand bit                         pck_str_empty_3             ;
                      rand bit                         pck_str_empty_4             ;
                      rand bit                         pck_str_empty_5             ;
                      rand bit                         pck_str_empty_6             ;
                      rand bit                         pck_str_empty_7             ;
                      rand bit                         pck_str_empty_8             ;
                      rand bit                         pck_str_empty_9             ;
                      rand bit                         pck_str_empty_10            ;
                      rand bit                         pck_str_empty_11            ;
                      rand bit                         pck_str_empty_12            ;
                      rand bit                         pck_str_empty_13            ;
                      rand bit                         pck_str_empty_14            ;
                      rand bit                         pck_str_empty_15            ;


                      //   16 PACKET STORE READ ENABLE GRANT SIGNAL    
                      bit                         pck_rd_en_grnt_0            ;
                      bit                         pck_rd_en_grnt_1            ;
                      bit                         pck_rd_en_grnt_2            ;
                      bit                         pck_rd_en_grnt_3            ;
                      bit                         pck_rd_en_grnt_4            ;
                      bit                         pck_rd_en_grnt_5            ;
                      bit                         pck_rd_en_grnt_6            ;
                      bit                         pck_rd_en_grnt_7            ;
                      bit                         pck_rd_en_grnt_8            ;
                      bit                         pck_rd_en_grnt_9            ;
                      bit                         pck_rd_en_grnt_10           ;
                      bit                         pck_rd_en_grnt_11           ;
                      bit                         pck_rd_en_grnt_12           ;
                      bit                         pck_rd_en_grnt_13           ;
                      bit                         pck_rd_en_grnt_14           ;
                      bit                         pck_rd_en_grnt_15           ;

                      //   OUTPUTS TO STREAM_0
                      bit                         out_stream_0_valid          ;
                      bit                         out_sop_0                   ;
                      bit   [64-1:0]              out_stream_0                ;
                      bit                         out_eop_0                   ;

                      //   OUTPUTS TO STREAM_1
                      bit                         out_stream_1_valid          ;
                      bit                         out_sop_1                   ;
                      bit   [64-1:0]              out_stream_1                ;
                      bit                         out_eop_1                   ;              

                   
                      //   OUTPUTS TO STREAM_2
                      bit                         out_stream_2_valid          ;
                      bit                         out_sop_2                   ;
                      bit   [64-1:0]              out_stream_2                ;
                      bit                         out_eop_2                   ;

                      //   OUTPUTS TO STREAM_3
                      bit                         out_stream_3_valid          ;
                      bit                         out_sop_3                   ;
                      bit   [64-1:0]              out_stream_3                ;
                      bit                         out_eop_3                   ; 
    
/*
                     rand bit in_sop     [16];
                     rand bit in_stream  [16];
                     rand bit in_eop     [16];
                     rand bit pck_str_empty [16];    */
 //factory registration
 `uvm_object_utils_begin(ulss_tx)
                     `uvm_field_int(rate_limiter_16to4_clk,UVM_ALL_ON)
                     `uvm_field_int(rate_limiter_16to4_rstn,UVM_ALL_ON)
                     `uvm_field_int(rate_limiter_16to4_sw_rst,UVM_ALL_ON)

                     `uvm_field_int(sch_reg_wr_en,UVM_ALL_ON)
                     `uvm_field_int(sch_reg_wr_addr,UVM_ALL_ON)
                     `uvm_field_int(sch_reg_wr_data,UVM_ALL_ON)

                     `uvm_field_int(in_sop_0,UVM_ALL_ON)
                     `uvm_field_int(in_stream_0,UVM_ALL_ON)
                     `uvm_field_int(in_eop_0,UVM_ALL_ON)
                    
                     `uvm_field_int(in_sop_1,UVM_ALL_ON)
                     `uvm_field_int(in_stream_1,UVM_ALL_ON)
                     `uvm_field_int(in_eop_1,UVM_ALL_ON)

                     `uvm_field_int(in_sop_2,UVM_ALL_ON)
                     `uvm_field_int(in_stream_2,UVM_ALL_ON)
                     `uvm_field_int(in_eop_2,UVM_ALL_ON)

                     `uvm_field_int(in_sop_3,UVM_ALL_ON)
                     `uvm_field_int(in_stream_3,UVM_ALL_ON)
                     `uvm_field_int(in_eop_3,UVM_ALL_ON)

                     `uvm_field_int(in_sop_4,UVM_ALL_ON)
                     `uvm_field_int(in_stream_4,UVM_ALL_ON)
                     `uvm_field_int(in_eop_4,UVM_ALL_ON)

                     `uvm_field_int(in_sop_5,UVM_ALL_ON)
                     `uvm_field_int(in_stream_5,UVM_ALL_ON)
                     `uvm_field_int(in_eop_5,UVM_ALL_ON)

                     `uvm_field_int(in_sop_6,UVM_ALL_ON)
                     `uvm_field_int(in_stream_6,UVM_ALL_ON)
                     `uvm_field_int(in_eop_6,UVM_ALL_ON)


                     `uvm_field_int(in_sop_7,UVM_ALL_ON)
                     `uvm_field_int(in_stream_7,UVM_ALL_ON)
                     `uvm_field_int(in_eop_7,UVM_ALL_ON)

                     `uvm_field_int(in_sop_8,UVM_ALL_ON)
                     `uvm_field_int(in_stream_8,UVM_ALL_ON)
                     `uvm_field_int(in_eop_8,UVM_ALL_ON)


                     `uvm_field_int(in_sop_9,UVM_ALL_ON)
                     `uvm_field_int(in_stream_9,UVM_ALL_ON)
                     `uvm_field_int(in_eop_9,UVM_ALL_ON)

                     `uvm_field_int(in_sop_10,UVM_ALL_ON)
                     `uvm_field_int(in_stream_10,UVM_ALL_ON)
                     `uvm_field_int(in_eop_10,UVM_ALL_ON)

                      `uvm_field_int(in_sop_11,UVM_ALL_ON)
                     `uvm_field_int(in_stream_11,UVM_ALL_ON)
                     `uvm_field_int(in_eop_11,UVM_ALL_ON)

                     `uvm_field_int(in_sop_12,UVM_ALL_ON)
                     `uvm_field_int(in_stream_12,UVM_ALL_ON)
                     `uvm_field_int(in_eop_12,UVM_ALL_ON)

                     `uvm_field_int(in_sop_13,UVM_ALL_ON)
                     `uvm_field_int(in_stream_13,UVM_ALL_ON)
                     `uvm_field_int(in_eop_13,UVM_ALL_ON)

                     `uvm_field_int(in_sop_14,UVM_ALL_ON)
                     `uvm_field_int(in_stream_14,UVM_ALL_ON)
                     `uvm_field_int(in_eop_14,UVM_ALL_ON)

                     `uvm_field_int(in_sop_15,UVM_ALL_ON)
                     `uvm_field_int(in_stream_15,UVM_ALL_ON)
                     `uvm_field_int(in_eop_15,UVM_ALL_ON)


                     `uvm_field_int(pck_str_empty_0 ,UVM_ALL_ON)
                     `uvm_field_int(pck_str_empty_1 ,UVM_ALL_ON)
                     `uvm_field_int(pck_str_empty_2 ,UVM_ALL_ON)
                     `uvm_field_int(pck_str_empty_3 ,UVM_ALL_ON)
                     `uvm_field_int(pck_str_empty_4 ,UVM_ALL_ON)
                     `uvm_field_int(pck_str_empty_5 ,UVM_ALL_ON)
                     `uvm_field_int(pck_str_empty_6 ,UVM_ALL_ON)
                     `uvm_field_int(pck_str_empty_7 ,UVM_ALL_ON)
                     `uvm_field_int(pck_str_empty_8 ,UVM_ALL_ON)
                     `uvm_field_int(pck_str_empty_9 ,UVM_ALL_ON)
                     `uvm_field_int(pck_str_empty_10 ,UVM_ALL_ON)
                     `uvm_field_int(pck_str_empty_11 ,UVM_ALL_ON)
                     `uvm_field_int(pck_str_empty_12 ,UVM_ALL_ON)
                     `uvm_field_int(pck_str_empty_13 ,UVM_ALL_ON)
                     `uvm_field_int(pck_str_empty_14 ,UVM_ALL_ON)
                     `uvm_field_int(pck_str_empty_15 ,UVM_ALL_ON)
                   

                     `uvm_field_int(pck_rd_en_grnt_0,UVM_ALL_ON)
                     `uvm_field_int(pck_rd_en_grnt_1,UVM_ALL_ON)
                     `uvm_field_int(pck_rd_en_grnt_2,UVM_ALL_ON)
                     `uvm_field_int(pck_rd_en_grnt_3,UVM_ALL_ON)
                     `uvm_field_int(pck_rd_en_grnt_4,UVM_ALL_ON)
                     `uvm_field_int(pck_rd_en_grnt_5,UVM_ALL_ON)
                     `uvm_field_int(pck_rd_en_grnt_6,UVM_ALL_ON)
                     `uvm_field_int(pck_rd_en_grnt_7,UVM_ALL_ON)
                     `uvm_field_int(pck_rd_en_grnt_8,UVM_ALL_ON)
                     `uvm_field_int(pck_rd_en_grnt_9,UVM_ALL_ON)
                     `uvm_field_int(pck_rd_en_grnt_10,UVM_ALL_ON)
                     `uvm_field_int(pck_rd_en_grnt_11,UVM_ALL_ON)
                     `uvm_field_int(pck_rd_en_grnt_12,UVM_ALL_ON)
                     `uvm_field_int(pck_rd_en_grnt_13,UVM_ALL_ON)
                     `uvm_field_int(pck_rd_en_grnt_14,UVM_ALL_ON)
                     `uvm_field_int(pck_rd_en_grnt_15,UVM_ALL_ON)
                     
                     `uvm_field_int(out_stream_0_valid,UVM_ALL_ON)
                     `uvm_field_int(out_sop_0,UVM_ALL_ON)
                     `uvm_field_int(out_stream_0,UVM_ALL_ON)
                     `uvm_field_int(out_eop_0 ,UVM_ALL_ON)
                    
                     `uvm_field_int(out_stream_1_valid,UVM_ALL_ON)
                     `uvm_field_int(out_sop_1,UVM_ALL_ON)
                     `uvm_field_int(out_stream_1,UVM_ALL_ON)
                     `uvm_field_int(out_eop_1,UVM_ALL_ON)

                     `uvm_field_int(out_stream_2_valid,UVM_ALL_ON)
                     `uvm_field_int(out_sop_2,UVM_ALL_ON)
                     `uvm_field_int(out_stream_2,UVM_ALL_ON)
                     `uvm_field_int(out_eop_2,UVM_ALL_ON)

                     `uvm_field_int(out_stream_3_valid,UVM_ALL_ON)
                     `uvm_field_int(out_sop_3,UVM_ALL_ON)
                     `uvm_field_int(out_stream_3,UVM_ALL_ON)
                     `uvm_field_int(out_eop_3,UVM_ALL_ON)                         
 `uvm_object_utils_end

  //constructor
  function new(string name="ulss_tx");
   super.new(name);
  endfunction

endclass
