interface ulss_interface (input logic rate_limiter_16to4_clk);
                       //logic                         rate_limiter_16to4_clk      ;
                       logic                         rate_limiter_16to4_rstn     ;
                       logic                         rate_limiter_16to4_sw_rst   ;

                   //   SIGNALS FOR COFIGURING SCHEDULER REGISTERS
                       logic                         sch_reg_wr_en               ;
                       logic   [5-1:0]               sch_reg_wr_addr             ;
                       logic   [64-1:0]              sch_reg_wr_data             ;

                   ////////////////////////     INPUTS     ///////////////////////////
                   //   INPUTS FROM STREAM_0
                       logic                         in_sop_0                    ;
                       logic   [64-1:0]              in_stream_0                 ;
                       logic                         in_eop_0                    ; 

                   //   INPUTS FROM STREAM_1
                       logic                         in_sop_1                    ;
                       logic   [64-1:0]              in_stream_1                 ;
                       logic                         in_eop_1                    ; 

                   //   INPUTS FROM STREAM_2
                       logic                         in_sop_2                    ;
                       logic   [64-1:0]              in_stream_2                 ;
                       logic                         in_eop_2                    ;

                   //   INPUTS FROM STREAM_3
                       logic                         in_sop_3                    ;
                       logic   [64-1:0]              in_stream_3                 ;
                       logic                         in_eop_3                    ;

                   //   INPUTS FROM STREAM_4
                       logic                         in_sop_4                    ;
                       logic   [64-1:0]              in_stream_4                 ;
                       logic                         in_eop_4                    ;

                   //   INPUTS FROM STREAM_5
                       logic                         in_sop_5                    ;
                       logic   [64-1:0]              in_stream_5                 ;
                       logic                         in_eop_5                    ;

                   //   INPUTS FROM STREAM_6
                       logic                         in_sop_6                    ;
                       logic   [64-1:0]              in_stream_6                 ;
                       logic                         in_eop_6                    ;

                   //   INPUTS FROM STREAM_7
                       logic                         in_sop_7                    ;
                       logic   [64-1:0]              in_stream_7                 ;
                       logic                         in_eop_7                    ;

                   //   INPUTS FROM STREAM_8
                       logic                         in_sop_8                    ;
                       logic   [64-1:0]              in_stream_8                 ;
                       logic                         in_eop_8                    ;

                   //   INPUTS FROM STREAM_9
                       logic                         in_sop_9                    ;
                       logic   [64-1:0]              in_stream_9                 ;
                       logic                         in_eop_9                    ;

                   //   INPUTS FROM STREAM_10
                       logic                         in_sop_10                   ;
                       logic   [64-1:0]              in_stream_10                ;
                       logic                         in_eop_10                   ;

                   //   INPUTS FROM STREAM_11
                       logic                         in_sop_11                   ;
                       logic   [64-1:0]              in_stream_11                ;
                       logic                         in_eop_11                   ;

                   //   INPUTS FROM STREAM_12
                       logic                         in_sop_12                   ;
                       logic   [64-1:0]              in_stream_12                ;
                       logic                         in_eop_12                   ;

                   //   INPUTS FROM STREAM_13
                       logic                         in_sop_13                   ;
                       logic   [64-1:0]              in_stream_13                ;
                       logic                         in_eop_13                   ;

                   //   INPUTS FROM STREAM_14
                       logic                         in_sop_14                   ;
                       logic   [64-1:0]              in_stream_14                ;
                       logic                         in_eop_14                   ;

                   //   INPUTS FROM STREAM_15
                       logic                         in_sop_15                   ;
                       logic   [64-1:0]              in_stream_15                ;
                       logic                         in_eop_15                   ; 

                   //   16 PACKET STORE EMPTY SIGNAL  
                      logic                         pck_str_empty_0             ;
                      logic                         pck_str_empty_1             ;
                      logic                         pck_str_empty_2             ;
                      logic                         pck_str_empty_3             ;
                      logic                         pck_str_empty_4             ;
                      logic                         pck_str_empty_5             ;
                      logic                         pck_str_empty_6             ;
                      logic                         pck_str_empty_7             ;
                      logic                         pck_str_empty_8             ;
                      logic                         pck_str_empty_9             ;
                      logic                         pck_str_empty_10            ;
                      logic                         pck_str_empty_11            ;
                      logic                         pck_str_empty_12            ;
                      logic                         pck_str_empty_13            ;
                      logic                         pck_str_empty_14            ;
                      logic                         pck_str_empty_15            ;
                    ////////////////////       OUTPUTS         ////////////////////////
                      
                   //   16 PACKET STORE READ ENABLE GRANT SIGNAL    
                      logic                         pck_rd_en_grnt_0            ;
                      logic                         pck_rd_en_grnt_1            ;
                      logic                         pck_rd_en_grnt_2            ;
                      logic                         pck_rd_en_grnt_3            ;
                      logic                         pck_rd_en_grnt_4            ;
                      logic                         pck_rd_en_grnt_5            ;
                      logic                         pck_rd_en_grnt_6            ;
                      logic                         pck_rd_en_grnt_7            ;
                      logic                         pck_rd_en_grnt_8            ;
                      logic                         pck_rd_en_grnt_9            ;
                      logic                         pck_rd_en_grnt_10           ;
                      logic                         pck_rd_en_grnt_11           ;
                      logic                         pck_rd_en_grnt_12           ;
                      logic                         pck_rd_en_grnt_13           ;
                      logic                         pck_rd_en_grnt_14           ;
                      logic                         pck_rd_en_grnt_15           ;

                    //   OUTPUTS TO STREAM_0
                      logic                         out_stream_0_valid          ;
                      logic                         out_sop_0                   ;
                      logic   [64-1:0]              out_stream_0                ;
                      logic                         out_eop_0                   ;

                   //   OUTPUTS TO STREAM_1
                      logic                         out_stream_1_valid          ;
                      logic                         out_sop_1                   ;
                      logic   [64-1:0]              out_stream_1                ;
                      logic                         out_eop_1                   ;              

                   
                   //   OUTPUTS TO STREAM_2
                      logic                         out_stream_2_valid          ;
                      logic                         out_sop_2                   ;
                      logic   [64-1:0]              out_stream_2                ;
                      logic                         out_eop_2                   ;

                   //   OUTPUTS TO STREAM_3
                      logic                         out_stream_3_valid          ;
                      logic                         out_sop_3                   ;
                      logic   [64-1:0]              out_stream_3                ;
                      logic                         out_eop_3                   ;

                   /*   logic [63:0] in_stream [15:0];
                      logic in_sop [15:0];
                      logic in_eop [15:0];

                      logic pck_rd_en_grnt [15:0];
                      logic pck_str_empty [15:0];      */
    

endinterface
