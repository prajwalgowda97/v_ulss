module rate_limiter_16to4
                #( parameter DATA_WIDTH     = 64        ,
                             REG_ADDR_WIDTH = 5         
                 )
                 (
                   //   GLOBAL SIGNALS
                   input    logic                         rate_limiter_16to4_clk      ,
                   input    logic                         rate_limiter_16to4_rstn     ,
                   input    logic                         rate_limiter_16to4_sw_rst   ,

                   //   SIGNALS FOR COFIGURING SCHEDULER REGISTERS
                   input    logic                         sch_reg_wr_en               ,
                   input    logic   [REG_ADDR_WIDTH-1:0]  sch_reg_wr_addr             ,
                   input    logic   [DATA_WIDTH-1:0]      sch_reg_wr_data             ,

                   ////////////////////////     INPUTS     ///////////////////////////
                   //   INPUTS FROM STREAM_0
                   input    logic                         in_sop_0                    ,
                   input    logic   [DATA_WIDTH-1:0]      in_stream_0                 ,
                   input    logic                         in_eop_0                    , 

                   //   INPUTS FROM STREAM_1
                   input    logic                         in_sop_1                    ,
                   input    logic   [DATA_WIDTH-1:0]      in_stream_1                 ,
                   input    logic                         in_eop_1                    , 

                   //   INPUTS FROM STREAM_2
                   input    logic                         in_sop_2                    ,
                   input    logic   [DATA_WIDTH-1:0]      in_stream_2                 ,
                   input    logic                         in_eop_2                    ,

                   //   INPUTS FROM STREAM_3
                   input    logic                         in_sop_3                    ,
                   input    logic   [DATA_WIDTH-1:0]      in_stream_3                 ,
                   input    logic                         in_eop_3                    ,

                   //   INPUTS FROM STREAM_4
                   input    logic                         in_sop_4                    ,
                   input    logic   [DATA_WIDTH-1:0]      in_stream_4                 ,
                   input    logic                         in_eop_4                    ,

                   //   INPUTS FROM STREAM_5
                   input    logic                         in_sop_5                    ,
                   input    logic   [DATA_WIDTH-1:0]      in_stream_5                 ,
                   input    logic                         in_eop_5                    ,

                   //   INPUTS FROM STREAM_6
                   input    logic                         in_sop_6                    ,
                   input    logic   [DATA_WIDTH-1:0]      in_stream_6                 ,
                   input    logic                         in_eop_6                    ,

                   //   INPUTS FROM STREAM_7
                   input    logic                         in_sop_7                    ,
                   input    logic   [DATA_WIDTH-1:0]      in_stream_7                 ,
                   input    logic                         in_eop_7                    ,

                   //   INPUTS FROM STREAM_8
                   input    logic                         in_sop_8                    ,
                   input    logic   [DATA_WIDTH-1:0]      in_stream_8                 ,
                   input    logic                         in_eop_8                    ,

                   //   INPUTS FROM STREAM_9
                   input    logic                         in_sop_9                    ,
                   input    logic   [DATA_WIDTH-1:0]      in_stream_9                 ,
                   input    logic                         in_eop_9                    ,

                   //   INPUTS FROM STREAM_10
                   input    logic                         in_sop_10                   ,
                   input    logic   [DATA_WIDTH-1:0]      in_stream_10                ,
                   input    logic                         in_eop_10                   ,

                   //   INPUTS FROM STREAM_11
                   input    logic                         in_sop_11                   ,
                   input    logic   [DATA_WIDTH-1:0]      in_stream_11                ,
                   input    logic                         in_eop_11                   ,

                   //   INPUTS FROM STREAM_12
                   input    logic                         in_sop_12                   ,
                   input    logic   [DATA_WIDTH-1:0]      in_stream_12                ,
                   input    logic                         in_eop_12                   ,

                   //   INPUTS FROM STREAM_13
                   input    logic                         in_sop_13                   ,
                   input    logic   [DATA_WIDTH-1:0]      in_stream_13                ,
                   input    logic                         in_eop_13                   ,

                   //   INPUTS FROM STREAM_14
                   input    logic                         in_sop_14                   ,
                   input    logic   [DATA_WIDTH-1:0]      in_stream_14                ,
                   input    logic                         in_eop_14                   ,

                   //   INPUTS FROM STREAM_15
                   input    logic                         in_sop_15                   ,
                   input    logic   [DATA_WIDTH-1:0]      in_stream_15                ,
                   input    logic                         in_eop_15                   , 

                   ////////////////////       OUTPUTS         ////////////////////////
                   //   16 PACKET STORE EMPTY SIGNAL  
                   input    logic                         pck_str_empty_0             ,
                   input    logic                         pck_str_empty_1             ,
                   input    logic                         pck_str_empty_2             ,
                   input    logic                         pck_str_empty_3             ,
                   input    logic                         pck_str_empty_4             ,
                   input    logic                         pck_str_empty_5             ,
                   input    logic                         pck_str_empty_6             ,
                   input    logic                         pck_str_empty_7             ,
                   input    logic                         pck_str_empty_8             ,
                   input    logic                         pck_str_empty_9             ,
                   input    logic                         pck_str_empty_10            ,
                   input    logic                         pck_str_empty_11            ,
                   input    logic                         pck_str_empty_12            ,
                   input    logic                         pck_str_empty_13            ,
                   input    logic                         pck_str_empty_14            ,
                   input    logic                         pck_str_empty_15            ,

                   //   16 PACKET STORE READ ENABLE GRANT SIGNAL    
                   output   logic                         pck_rd_en_grnt_0            ,
                   output   logic                         pck_rd_en_grnt_1            ,
                   output   logic                         pck_rd_en_grnt_2            ,
                   output   logic                         pck_rd_en_grnt_3            ,
                   output   logic                         pck_rd_en_grnt_4            ,
                   output   logic                         pck_rd_en_grnt_5            ,
                   output   logic                         pck_rd_en_grnt_6            ,
                   output   logic                         pck_rd_en_grnt_7            ,
                   output   logic                         pck_rd_en_grnt_8            ,
                   output   logic                         pck_rd_en_grnt_9            ,
                   output   logic                         pck_rd_en_grnt_10           ,
                   output   logic                         pck_rd_en_grnt_11           ,
                   output   logic                         pck_rd_en_grnt_12           ,
                   output   logic                         pck_rd_en_grnt_13           ,
                   output   logic                         pck_rd_en_grnt_14           ,
                   output   logic                         pck_rd_en_grnt_15           ,

                   //   OUTPUTS TO STREAM_0
                   output   logic                         out_stream_0_valid          ,
                   output   logic                         out_sop_0                   ,
                   output   logic   [DATA_WIDTH-1:0]      out_stream_0                ,
                   output   logic                         out_eop_0                   ,

                   //   OUTPUTS TO STREAM_1
                   output   logic                         out_stream_1_valid          ,
                   output   logic                         out_sop_1                   ,
                   output   logic   [DATA_WIDTH-1:0]      out_stream_1                ,
                   output   logic                         out_eop_1                   ,              

                   
                   //   OUTPUTS TO STREAM_2
                   output   logic                         out_stream_2_valid          ,
                   output   logic                         out_sop_2                   ,
                   output   logic   [DATA_WIDTH-1:0]      out_stream_2                ,
                   output   logic                         out_eop_2                   ,

                   //   OUTPUTS TO STREAM_3
                   output   logic                         out_stream_3_valid          ,
                   output   logic                         out_sop_3                   ,
                   output   logic   [DATA_WIDTH-1:0]      out_stream_3                ,
                   output   logic                         out_eop_3                   
    
                   /*
                   //   OUTPUTS TO STREAM_4
                   output   logic                         out_sop_4                   ,
                   output   logic   [DATA_WIDTH-1:0]      out_stream_4                ,
                   output   logic                         out_eop_4                   ,

                   //   OUTPUTS TO STREAM_5
                   output   logic                         out_sop_5                   ,
                   output   logic   [DATA_WIDTH-1:0]      out_stream_5                ,
                   output   logic                         out_eop_5                   ,

                   //   OUTPUTS TO STREAM_6
                   output   logic                         out_sop_6                   ,
                   output   logic   [DATA_WIDTH-1:0]      out_stream_6                ,
                   output   logic                         out_eop_6                   ,

                   //   OUTPUTS TO STREAM_7
                   output   logic                         out_sop_7                   ,
                   output   logic   [DATA_WIDTH-1:0]      out_stream_7                ,
                   output   logic                         out_eop_7                   ,
                   */ 
                 );

                 //                     INTERNAL DECLERATIONS
                 logic  [DATA_WIDTH-1:0]                  OUT_STREAM_0_REG_W            ; 
                 logic  [DATA_WIDTH-1:0]                  OUT_STREAM_1_REG_W            ; 
                 logic  [DATA_WIDTH-1:0]                  OUT_STREAM_2_REG_W            ; 
                 logic  [DATA_WIDTH-1:0]                  OUT_STREAM_3_REG_W            ; 
                 logic  [DATA_WIDTH-1:0]                  IN_STREAM_0_REG_W             ;    
                 logic  [DATA_WIDTH-1:0]                  IN_STREAM_1_REG_W             ;
                 logic  [DATA_WIDTH-1:0]                  IN_STREAM_2_REG_W             ;
                 logic  [DATA_WIDTH-1:0]                  IN_STREAM_3_REG_W             ;
                 logic  [DATA_WIDTH-1:0]                  IN_STREAM_4_REG_W             ;
                 logic  [DATA_WIDTH-1:0]                  IN_STREAM_5_REG_W             ;
                 logic  [DATA_WIDTH-1:0]                  IN_STREAM_6_REG_W             ;
                 logic  [DATA_WIDTH-1:0]                  IN_STREAM_7_REG_W             ;
                 logic  [DATA_WIDTH-1:0]                  IN_STREAM_8_REG_W             ;
                 logic  [DATA_WIDTH-1:0]                  IN_STREAM_9_REG_W             ;
                 logic  [DATA_WIDTH-1:0]                  IN_STREAM_10_REG_W            ;
                 logic  [DATA_WIDTH-1:0]                  IN_STREAM_11_REG_W            ;
                 logic  [DATA_WIDTH-1:0]                  IN_STREAM_12_REG_W            ;
                 logic  [DATA_WIDTH-1:0]                  IN_STREAM_13_REG_W            ;
                 logic  [DATA_WIDTH-1:0]                  IN_STREAM_14_REG_W            ;
                 logic  [DATA_WIDTH-1:0]                  IN_STREAM_15_REG_W            ;

                 logic  [4:0]                             next_state_stream_0_w         ;   
                 logic  [4:0]                             next_state_stream_1_w         ;
                 logic  [4:0]                             next_state_stream_2_w         ;
                 logic  [4:0]                             next_state_stream_3_w         ;

                 logic   [15:0]                           stream_mapping_stream_0       ; 
                 logic   [15:0]                           stream_mapping_stream_1       ;
                 logic   [15:0]                           stream_mapping_stream_2       ;
                 logic   [15:0]                           stream_mapping_stream_3       ;

                 logic                                    token_count_en_stream_0_inst0 ;
                 logic                                    token_count_en_stream_1_inst0 ; 
                 logic                                    token_count_en_stream_2_inst0 ; 
                 logic                                    token_count_en_stream_3_inst0 ; 
                 logic                                    token_count_en_stream_4_inst0 ; 
                 logic                                    token_count_en_stream_5_inst0 ; 
                 logic                                    token_count_en_stream_6_inst0 ; 
                 logic                                    token_count_en_stream_7_inst0 ; 
                 logic                                    token_count_en_stream_8_inst0 ; 
                 logic                                    token_count_en_stream_9_inst0 ; 
                 logic                                    token_count_en_stream_10_inst0;
                 logic                                    token_count_en_stream_11_inst0;
                 logic                                    token_count_en_stream_12_inst0;
                 logic                                    token_count_en_stream_13_inst0;
                 logic                                    token_count_en_stream_14_inst0;
                 logic                                    token_count_en_stream_15_inst0;

                 logic                                    token_count_en_stream_0_inst1 ;  
                 logic                                    token_count_en_stream_1_inst1 ;
                 logic                                    token_count_en_stream_2_inst1 ;
                 logic                                    token_count_en_stream_3_inst1 ;
                 logic                                    token_count_en_stream_4_inst1 ;
                 logic                                    token_count_en_stream_5_inst1 ;
                 logic                                    token_count_en_stream_6_inst1 ;
                 logic                                    token_count_en_stream_7_inst1 ;
                 logic                                    token_count_en_stream_8_inst1 ;
                 logic                                    token_count_en_stream_9_inst1 ;
                 logic                                    token_count_en_stream_10_inst1;
                 logic                                    token_count_en_stream_11_inst1;
                 logic                                    token_count_en_stream_12_inst1;
                 logic                                    token_count_en_stream_13_inst1;
                 logic                                    token_count_en_stream_14_inst1;
                 logic                                    token_count_en_stream_15_inst1;

                 logic                                    token_count_en_stream_0_inst2 ;
                 logic                                    token_count_en_stream_1_inst2 ; 
                 logic                                    token_count_en_stream_2_inst2 ; 
                 logic                                    token_count_en_stream_3_inst2 ; 
                 logic                                    token_count_en_stream_4_inst2 ; 
                 logic                                    token_count_en_stream_5_inst2 ; 
                 logic                                    token_count_en_stream_6_inst2 ; 
                 logic                                    token_count_en_stream_7_inst2 ; 
                 logic                                    token_count_en_stream_8_inst2 ; 
                 logic                                    token_count_en_stream_9_inst2 ; 
                 logic                                    token_count_en_stream_10_inst2;
                 logic                                    token_count_en_stream_11_inst2;
                 logic                                    token_count_en_stream_12_inst2;
                 logic                                    token_count_en_stream_13_inst2;
                 logic                                    token_count_en_stream_14_inst2;
                 logic                                    token_count_en_stream_15_inst2;

                 logic                                    token_count_en_stream_0_inst3 ;  
                 logic                                    token_count_en_stream_1_inst3 ;
                 logic                                    token_count_en_stream_2_inst3 ;
                 logic                                    token_count_en_stream_3_inst3 ;
                 logic                                    token_count_en_stream_4_inst3 ;
                 logic                                    token_count_en_stream_5_inst3 ;
                 logic                                    token_count_en_stream_6_inst3 ;
                 logic                                    token_count_en_stream_7_inst3 ;
                 logic                                    token_count_en_stream_8_inst3 ;
                 logic                                    token_count_en_stream_9_inst3 ;
                 logic                                    token_count_en_stream_10_inst3;
                 logic                                    token_count_en_stream_11_inst3;
                 logic                                    token_count_en_stream_12_inst3;
                 logic                                    token_count_en_stream_13_inst3;
                 logic                                    token_count_en_stream_14_inst3;
                 logic                                    token_count_en_stream_15_inst3;

                 //             SCHDULER REGISTER CONFIG MODULE INSTANTIATION 
                 schduler_reg_config
                 #(
                   .DATA_WIDTH      ( DATA_WIDTH     )          ,
                   .REG_ADDR_WIDTH  ( REG_ADDR_WIDTH )  
                  ) 
                 schduler_reg_config_inst
                    (
                     .schduler_reg_clk      ( rate_limiter_16to4_clk          )           , 
                     .schduler_reg_rstn     ( rate_limiter_16to4_rstn         )           , 
                     .schduler_reg_sw_rst   ( rate_limiter_16to4_sw_rst       )           , 

                     .sch_reg_wr_en         ( sch_reg_wr_en                   )           ,       
                     .sch_reg_wr_addr       ( sch_reg_wr_addr                 )           , 
                     .sch_reg_wr_data       ( sch_reg_wr_data                 )           , 
                                                   
                     .OUT_STREAM_0_REG      ( OUT_STREAM_0_REG_W              )           , 
                     .OUT_STREAM_1_REG      ( OUT_STREAM_1_REG_W              )           ,
                     .OUT_STREAM_2_REG      ( OUT_STREAM_2_REG_W              )           , 
                     .OUT_STREAM_3_REG      ( OUT_STREAM_3_REG_W              )           , 

                     .IN_STREAM_0_REG       ( IN_STREAM_0_REG_W               )           ,            
                     .IN_STREAM_1_REG       ( IN_STREAM_1_REG_W               )           ,       
                     .IN_STREAM_2_REG       ( IN_STREAM_2_REG_W               )           ,       
                     .IN_STREAM_3_REG       ( IN_STREAM_3_REG_W               )           ,       
                     .IN_STREAM_4_REG       ( IN_STREAM_4_REG_W               )           ,       
                     .IN_STREAM_5_REG       ( IN_STREAM_5_REG_W               )           ,       
                     .IN_STREAM_6_REG       ( IN_STREAM_6_REG_W               )           ,       
                     .IN_STREAM_7_REG       ( IN_STREAM_7_REG_W               )           ,       
                     .IN_STREAM_8_REG       ( IN_STREAM_8_REG_W               )           ,       
                     .IN_STREAM_9_REG       ( IN_STREAM_9_REG_W               )           ,       
                     .IN_STREAM_10_REG      ( IN_STREAM_10_REG_W              )           ,       
                     .IN_STREAM_11_REG      ( IN_STREAM_11_REG_W              )           ,       
                     .IN_STREAM_12_REG      ( IN_STREAM_12_REG_W              )           ,       
                     .IN_STREAM_13_REG      ( IN_STREAM_13_REG_W              )           ,       
                     .IN_STREAM_14_REG      ( IN_STREAM_14_REG_W              )           ,       
                     .IN_STREAM_15_REG      ( IN_STREAM_15_REG_W              )                  
                    ); 
               //////////////////////////////////////////////////////////////////////////////

               //               SCHEDULAR CONTROL FSM MODULE STREAM 0 INSTANTIATION
               sch_ctrl_fsm
               #(
                 .DATA_WIDTH      ( DATA_WIDTH     )       
                )
               sch_ctrl_fsm_stream_0_inst
                    (
                     .sch_ctrl_fsm_clk           ( rate_limiter_16to4_clk       )       ,   
                     .sch_ctrl_fsm_rstn          ( rate_limiter_16to4_rstn      )       ,      
                     .sch_ctrl_fsm_sw_rst        ( rate_limiter_16to4_sw_rst    )       ,   

                     .in_sop_0                   ( in_sop_0                     )       ,   
                     .in_stream_0                ( in_stream_0                  )       ,   
                     .in_eop_0                   ( in_eop_0                     )       ,   
                     .in_sop_1                   ( in_sop_1                     )       ,   
                     .in_stream_1                ( in_stream_1                  )       ,   
                     .in_eop_1                   ( in_eop_1                     )       ,   
                     .in_sop_2                   ( in_sop_2                     )       ,   
                     .in_stream_2                ( in_stream_2                  )       ,   
                     .in_eop_2                   ( in_eop_2                     )       ,   
                     .in_sop_3                   ( in_sop_3                     )       ,   
                     .in_stream_3                ( in_stream_3                  )       ,   
                     .in_eop_3                   ( in_eop_3                     )       ,   
                     .in_sop_4                   ( in_sop_4                     )       ,   
                     .in_stream_4                ( in_stream_4                  )       ,   
                     .in_eop_4                   ( in_eop_4                     )       ,   
                     .in_sop_5                   ( in_sop_5                     )       ,   
                     .in_stream_5                ( in_stream_5                  )       ,   
                     .in_eop_5                   ( in_eop_5                     )       ,   
                     .in_sop_6                   ( in_sop_6                     )       ,   
                     .in_stream_6                ( in_stream_6                  )       ,   
                     .in_eop_6                   ( in_eop_6                     )       ,   
                     .in_sop_7                   ( in_sop_7                     )       ,   
                     .in_stream_7                ( in_stream_7                  )       ,   
                     .in_eop_7                   ( in_eop_7                     )       ,   
                     .in_sop_8                   ( in_sop_8                     )       ,   
                     .in_stream_8                ( in_stream_8                  )       ,   
                     .in_eop_8                   ( in_eop_8                     )       ,   
                     .in_sop_9                   ( in_sop_9                     )       ,   
                     .in_stream_9                ( in_stream_9                  )       ,   
                     .in_eop_9                   ( in_eop_9                     )       ,   
                     .in_sop_10                  ( in_sop_10                    )       ,   
                     .in_stream_10               ( in_stream_10                 )       ,   
                     .in_eop_10                  ( in_eop_10                    )       ,   
                     .in_sop_11                  ( in_sop_11                    )       ,   
                     .in_stream_11               ( in_stream_11                 )       ,   
                     .in_eop_11                  ( in_eop_11                    )       ,   
                     .in_sop_12                  ( in_sop_12                    )       ,   
                     .in_stream_12               ( in_stream_12                 )       ,   
                     .in_eop_12                  ( in_eop_12                    )       ,   
                     .in_sop_13                  ( in_sop_13                    )       ,   
                     .in_stream_13               ( in_stream_13                 )       ,   
                     .in_eop_13                  ( in_eop_13                    )       ,   
                     .in_sop_14                  ( in_sop_14                    )       ,   
                     .in_stream_14               ( in_stream_14                 )       ,   
                     .in_eop_14                  ( in_eop_14                    )       ,   
                     .in_sop_15                  ( in_sop_15                    )       ,   
                     .in_stream_15               ( in_stream_15                 )       ,   
                     .in_eop_15                  ( in_eop_15                    )       ,   
                                    
                     .stream_0_pck_str_empty     ( pck_str_empty_0              )       ,   
                     .stream_1_pck_str_empty     ( pck_str_empty_1              )       ,   
                     .stream_2_pck_str_empty     ( pck_str_empty_2              )       ,   
                     .stream_3_pck_str_empty     ( pck_str_empty_3              )       ,   
                     .stream_4_pck_str_empty     ( pck_str_empty_4              )       ,   
                     .stream_5_pck_str_empty     ( pck_str_empty_5              )       ,   
                     .stream_6_pck_str_empty     ( pck_str_empty_6              )       ,   
                     .stream_7_pck_str_empty     ( pck_str_empty_7              )       ,   
                     .stream_8_pck_str_empty     ( pck_str_empty_8              )       ,   
                     .stream_9_pck_str_empty     ( pck_str_empty_9              )       ,   
                     .stream_10_pck_str_empty    ( pck_str_empty_10             )       ,   
                     .stream_11_pck_str_empty    ( pck_str_empty_11             )       ,   
                     .stream_12_pck_str_empty    ( pck_str_empty_12             )       ,   
                     .stream_13_pck_str_empty    ( pck_str_empty_13             )       ,   
                     .stream_14_pck_str_empty    ( pck_str_empty_14             )       ,   
                     .stream_15_pck_str_empty    ( pck_str_empty_15             )       ,   
                                  
                     .STREAM_REG                 ( OUT_STREAM_0_REG_W           )       ,   
                     .IN_STREAM_0_REG            ( IN_STREAM_0_REG_W            )       ,          
                     .IN_STREAM_1_REG            ( IN_STREAM_1_REG_W            )       ,
                     .IN_STREAM_2_REG            ( IN_STREAM_2_REG_W            )       ,
                     .IN_STREAM_3_REG            ( IN_STREAM_3_REG_W            )       ,
                     .IN_STREAM_4_REG            ( IN_STREAM_4_REG_W            )       ,
                     .IN_STREAM_5_REG            ( IN_STREAM_5_REG_W            )       ,
                     .IN_STREAM_6_REG            ( IN_STREAM_6_REG_W            )       ,
                     .IN_STREAM_7_REG            ( IN_STREAM_7_REG_W            )       ,
                     .IN_STREAM_8_REG            ( IN_STREAM_8_REG_W            )       ,
                     .IN_STREAM_9_REG            ( IN_STREAM_9_REG_W            )       ,
                     .IN_STREAM_10_REG           ( IN_STREAM_10_REG_W           )       ,
                     .IN_STREAM_11_REG           ( IN_STREAM_11_REG_W           )       ,
                     .IN_STREAM_12_REG           ( IN_STREAM_12_REG_W           )       ,
                     .IN_STREAM_13_REG           ( IN_STREAM_13_REG_W           )       ,
                     .IN_STREAM_14_REG           ( IN_STREAM_14_REG_W           )       ,
                     .IN_STREAM_15_REG           ( IN_STREAM_15_REG_W           )       ,

                     .tokens_count_en_stream_0   ( token_count_en_stream_0_inst0       )       ,
                     .tokens_count_en_stream_1   ( token_count_en_stream_1_inst0       )       ,
                     .tokens_count_en_stream_2   ( token_count_en_stream_2_inst0       )       ,
                     .tokens_count_en_stream_3   ( token_count_en_stream_3_inst0       )       ,
                     .tokens_count_en_stream_4   ( token_count_en_stream_4_inst0       )       ,
                     .tokens_count_en_stream_5   ( token_count_en_stream_5_inst0       )       ,
                     .tokens_count_en_stream_6   ( token_count_en_stream_6_inst0       )       ,
                     .tokens_count_en_stream_7   ( token_count_en_stream_7_inst0       )       ,
                     .tokens_count_en_stream_8   ( token_count_en_stream_8_inst0       )       ,
                     .tokens_count_en_stream_9   ( token_count_en_stream_9_inst0       )       ,
                     .tokens_count_en_stream_10  ( token_count_en_stream_10_inst0      )       ,
                     .tokens_count_en_stream_11  ( token_count_en_stream_11_inst0      )       ,
                     .tokens_count_en_stream_12  ( token_count_en_stream_12_inst0      )       ,
                     .tokens_count_en_stream_13  ( token_count_en_stream_13_inst0      )       ,
                     .tokens_count_en_stream_14  ( token_count_en_stream_14_inst0      )       ,
                     .tokens_count_en_stream_15  ( token_count_en_stream_15_inst0      )       ,

                     .next_state_stream          ( next_state_stream_0_w        )       ,
                     .stream_mapping             ( stream_mapping_stream_0      )       ,

                     .out_stream_busy            ( out_stream_0_valid           )       ,   
                     .out_sop                    ( out_sop_0                    )       ,   
                     .out_stream                 ( out_stream_0                 )       ,   
                     .out_eop                    ( out_eop_0                    )          
                    ); 
                /////////////////////////////////////////////////////////////////////////////////////


               //               SCHEDULAR CONTROL FSM MODULE STREAM 1 INSTANTIATION
               sch_ctrl_fsm
               #(
                 .DATA_WIDTH      ( DATA_WIDTH     )       
                )
               sch_ctrl_fsm_stream_1_inst
                (
                 .sch_ctrl_fsm_clk              ( rate_limiter_16to4_clk       )       ,   
                 .sch_ctrl_fsm_rstn             ( rate_limiter_16to4_rstn      )       ,      
                 .sch_ctrl_fsm_sw_rst           ( rate_limiter_16to4_sw_rst    )       ,   

                 .in_sop_0                      ( in_sop_0                     )       ,   
                 .in_stream_0                   ( in_stream_0                  )       ,   
                 .in_eop_0                      ( in_eop_0                     )       ,   
                 .in_sop_1                      ( in_sop_1                     )       ,   
                 .in_stream_1                   ( in_stream_1                  )       ,   
                 .in_eop_1                      ( in_eop_1                     )       ,   
                 .in_sop_2                      ( in_sop_2                     )       ,   
                 .in_stream_2                   ( in_stream_2                  )       ,   
                 .in_eop_2                      ( in_eop_2                     )       ,   
                 .in_sop_3                      ( in_sop_3                     )       ,   
                 .in_stream_3                   ( in_stream_3                  )       ,   
                 .in_eop_3                      ( in_eop_3                     )       ,   
                 .in_sop_4                      ( in_sop_4                     )       ,   
                 .in_stream_4                   ( in_stream_4                  )       ,   
                 .in_eop_4                      ( in_eop_4                     )       ,   
                 .in_sop_5                      ( in_sop_5                     )       ,   
                 .in_stream_5                   ( in_stream_5                  )       ,   
                 .in_eop_5                      ( in_eop_5                     )       ,   
                 .in_sop_6                      ( in_sop_6                     )       ,   
                 .in_stream_6                   ( in_stream_6                  )       ,   
                 .in_eop_6                      ( in_eop_6                     )       ,   
                 .in_sop_7                      ( in_sop_7                     )       ,   
                 .in_stream_7                   ( in_stream_7                  )       ,   
                 .in_eop_7                      ( in_eop_7                     )       ,   
                 .in_sop_8                      ( in_sop_8                     )       ,   
                 .in_stream_8                   ( in_stream_8                  )       ,   
                 .in_eop_8                      ( in_eop_8                     )       ,   
                 .in_sop_9                      ( in_sop_9                     )       ,   
                 .in_stream_9                   ( in_stream_9                  )       ,   
                 .in_eop_9                      ( in_eop_9                     )       ,   
                 .in_sop_10                     ( in_sop_10                    )       ,   
                 .in_stream_10                  ( in_stream_10                 )       ,   
                 .in_eop_10                     ( in_eop_10                    )       ,   
                 .in_sop_11                     ( in_sop_11                    )       ,   
                 .in_stream_11                  ( in_stream_11                 )       ,   
                 .in_eop_11                     ( in_eop_11                    )       ,   
                 .in_sop_12                     ( in_sop_12                    )       ,   
                 .in_stream_12                  ( in_stream_12                 )       ,   
                 .in_eop_12                     ( in_eop_12                    )       ,   
                 .in_sop_13                     ( in_sop_13                    )       ,   
                 .in_stream_13                  ( in_stream_13                 )       ,   
                 .in_eop_13                     ( in_eop_13                    )       ,   
                 .in_sop_14                     ( in_sop_14                    )       ,   
                 .in_stream_14                  ( in_stream_14                 )       ,   
                 .in_eop_14                     ( in_eop_14                    )       ,   
                 .in_sop_15                     ( in_sop_15                    )       ,   
                 .in_stream_15                  ( in_stream_15                 )       ,   
                 .in_eop_15                     ( in_eop_15                    )       ,   
                                
                 .stream_0_pck_str_empty        ( pck_str_empty_0              )       ,   
                 .stream_1_pck_str_empty        ( pck_str_empty_1              )       ,   
                 .stream_2_pck_str_empty        ( pck_str_empty_2              )       ,   
                 .stream_3_pck_str_empty        ( pck_str_empty_3              )       ,   
                 .stream_4_pck_str_empty        ( pck_str_empty_4              )       ,   
                 .stream_5_pck_str_empty        ( pck_str_empty_5              )       ,   
                 .stream_6_pck_str_empty        ( pck_str_empty_6              )       ,   
                 .stream_7_pck_str_empty        ( pck_str_empty_7              )       ,   
                 .stream_8_pck_str_empty        ( pck_str_empty_8              )       ,   
                 .stream_9_pck_str_empty        ( pck_str_empty_9              )       ,   
                 .stream_10_pck_str_empty       ( pck_str_empty_10             )       ,   
                 .stream_11_pck_str_empty       ( pck_str_empty_11             )       ,   
                 .stream_12_pck_str_empty       ( pck_str_empty_12             )       ,   
                 .stream_13_pck_str_empty       ( pck_str_empty_13             )       ,   
                 .stream_14_pck_str_empty       ( pck_str_empty_14             )       ,   
                 .stream_15_pck_str_empty       ( pck_str_empty_15             )       ,   
                              
                 .STREAM_REG                    ( OUT_STREAM_1_REG_W           )       ,   
                 .IN_STREAM_0_REG               ( IN_STREAM_0_REG_W            )       ,          
                 .IN_STREAM_1_REG               ( IN_STREAM_1_REG_W            )       ,
                 .IN_STREAM_2_REG               ( IN_STREAM_2_REG_W            )       ,
                 .IN_STREAM_3_REG               ( IN_STREAM_3_REG_W            )       ,
                 .IN_STREAM_4_REG               ( IN_STREAM_4_REG_W            )       ,
                 .IN_STREAM_5_REG               ( IN_STREAM_5_REG_W            )       ,
                 .IN_STREAM_6_REG               ( IN_STREAM_6_REG_W            )       ,
                 .IN_STREAM_7_REG               ( IN_STREAM_7_REG_W            )       ,
                 .IN_STREAM_8_REG               ( IN_STREAM_8_REG_W            )       ,
                 .IN_STREAM_9_REG               ( IN_STREAM_9_REG_W            )       ,
                 .IN_STREAM_10_REG              ( IN_STREAM_10_REG_W           )       ,
                 .IN_STREAM_11_REG              ( IN_STREAM_11_REG_W           )       ,
                 .IN_STREAM_12_REG              ( IN_STREAM_12_REG_W           )       ,
                 .IN_STREAM_13_REG              ( IN_STREAM_13_REG_W           )       ,
                 .IN_STREAM_14_REG              ( IN_STREAM_14_REG_W           )       ,
                 .IN_STREAM_15_REG              ( IN_STREAM_15_REG_W           )       ,

                 .tokens_count_en_stream_0      ( token_count_en_stream_0_inst1       )       ,
                 .tokens_count_en_stream_1      ( token_count_en_stream_1_inst1       )       ,
                 .tokens_count_en_stream_2      ( token_count_en_stream_2_inst1       )       ,
                 .tokens_count_en_stream_3      ( token_count_en_stream_3_inst1       )       ,
                 .tokens_count_en_stream_4      ( token_count_en_stream_4_inst1       )       ,
                 .tokens_count_en_stream_5      ( token_count_en_stream_5_inst1       )       ,
                 .tokens_count_en_stream_6      ( token_count_en_stream_6_inst1       )       ,
                 .tokens_count_en_stream_7      ( token_count_en_stream_7_inst1       )       ,
                 .tokens_count_en_stream_8      ( token_count_en_stream_8_inst1       )       ,
                 .tokens_count_en_stream_9      ( token_count_en_stream_9_inst1       )       ,
                 .tokens_count_en_stream_10     ( token_count_en_stream_10_inst1      )       ,
                 .tokens_count_en_stream_11     ( token_count_en_stream_11_inst1      )       ,
                 .tokens_count_en_stream_12     ( token_count_en_stream_12_inst1      )       ,
                 .tokens_count_en_stream_13     ( token_count_en_stream_13_inst1      )       ,
                 .tokens_count_en_stream_14     ( token_count_en_stream_14_inst1      )       ,
                 .tokens_count_en_stream_15     ( token_count_en_stream_15_inst1      )       ,

                 .next_state_stream             ( next_state_stream_1_w        )       ,
                 .stream_mapping                ( stream_mapping_stream_1      )       ,

                 .out_stream_busy               ( out_stream_1_valid           )       ,   
                 .out_sop                       ( out_sop_1                    )       ,   
                 .out_stream                    ( out_stream_1                 )       ,   
                 .out_eop                       ( out_eop_1                    )          
                ); 
                /////////////////////////////////////////////////////////////////////////////////////


               //               SCHEDULAR CONTROL FSM MODULE STREAM 2 INSTANTIATION
               sch_ctrl_fsm
               #(
                 .DATA_WIDTH      ( DATA_WIDTH     )       
                )
               sch_ctrl_fsm_stream_2_inst
                (
                 .sch_ctrl_fsm_clk              ( rate_limiter_16to4_clk       )       ,   
                 .sch_ctrl_fsm_rstn             ( rate_limiter_16to4_rstn      )       ,      
                 .sch_ctrl_fsm_sw_rst           ( rate_limiter_16to4_sw_rst    )       ,   

                 .in_sop_0                      ( in_sop_0                     )       ,   
                 .in_stream_0                   ( in_stream_0                  )       ,   
                 .in_eop_0                      ( in_eop_0                     )       ,   
                 .in_sop_1                      ( in_sop_1                     )       ,   
                 .in_stream_1                   ( in_stream_1                  )       ,   
                 .in_eop_1                      ( in_eop_1                     )       ,   
                 .in_sop_2                      ( in_sop_2                     )       ,   
                 .in_stream_2                   ( in_stream_2                  )       ,   
                 .in_eop_2                      ( in_eop_2                     )       ,   
                 .in_sop_3                      ( in_sop_3                     )       ,   
                 .in_stream_3                   ( in_stream_3                  )       ,   
                 .in_eop_3                      ( in_eop_3                     )       ,   
                 .in_sop_4                      ( in_sop_4                     )       ,   
                 .in_stream_4                   ( in_stream_4                  )       ,   
                 .in_eop_4                      ( in_eop_4                     )       ,   
                 .in_sop_5                      ( in_sop_5                     )       ,   
                 .in_stream_5                   ( in_stream_5                  )       ,   
                 .in_eop_5                      ( in_eop_5                     )       ,   
                 .in_sop_6                      ( in_sop_6                     )       ,   
                 .in_stream_6                   ( in_stream_6                  )       ,   
                 .in_eop_6                      ( in_eop_6                     )       ,   
                 .in_sop_7                      ( in_sop_7                     )       ,   
                 .in_stream_7                   ( in_stream_7                  )       ,   
                 .in_eop_7                      ( in_eop_7                     )       ,   
                 .in_sop_8                      ( in_sop_8                     )       ,   
                 .in_stream_8                   ( in_stream_8                  )       ,   
                 .in_eop_8                      ( in_eop_8                     )       ,   
                 .in_sop_9                      ( in_sop_9                     )       ,   
                 .in_stream_9                   ( in_stream_9                  )       ,   
                 .in_eop_9                      ( in_eop_9                     )       ,   
                 .in_sop_10                     ( in_sop_10                    )       ,   
                 .in_stream_10                  ( in_stream_10                 )       ,   
                 .in_eop_10                     ( in_eop_10                    )       ,   
                 .in_sop_11                     ( in_sop_11                    )       ,   
                 .in_stream_11                  ( in_stream_11                 )       ,   
                 .in_eop_11                     ( in_eop_11                    )       ,   
                 .in_sop_12                     ( in_sop_12                    )       ,   
                 .in_stream_12                  ( in_stream_12                 )       ,   
                 .in_eop_12                     ( in_eop_12                    )       ,   
                 .in_sop_13                     ( in_sop_13                    )       ,   
                 .in_stream_13                  ( in_stream_13                 )       ,   
                 .in_eop_13                     ( in_eop_13                    )       ,   
                 .in_sop_14                     ( in_sop_14                    )       ,   
                 .in_stream_14                  ( in_stream_14                 )       ,   
                 .in_eop_14                     ( in_eop_14                    )       ,   
                 .in_sop_15                     ( in_sop_15                    )       ,   
                 .in_stream_15                  ( in_stream_15                 )       ,   
                 .in_eop_15                     ( in_eop_15                    )       ,   
                                
                 .stream_0_pck_str_empty        ( pck_str_empty_0              )       ,   
                 .stream_1_pck_str_empty        ( pck_str_empty_1              )       ,   
                 .stream_2_pck_str_empty        ( pck_str_empty_2              )       ,   
                 .stream_3_pck_str_empty        ( pck_str_empty_3              )       ,   
                 .stream_4_pck_str_empty        ( pck_str_empty_4              )       ,   
                 .stream_5_pck_str_empty        ( pck_str_empty_5              )       ,   
                 .stream_6_pck_str_empty        ( pck_str_empty_6              )       ,   
                 .stream_7_pck_str_empty        ( pck_str_empty_7              )       ,   
                 .stream_8_pck_str_empty        ( pck_str_empty_8              )       ,   
                 .stream_9_pck_str_empty        ( pck_str_empty_9              )       ,   
                 .stream_10_pck_str_empty       ( pck_str_empty_10             )       ,   
                 .stream_11_pck_str_empty       ( pck_str_empty_11             )       ,   
                 .stream_12_pck_str_empty       ( pck_str_empty_12             )       ,   
                 .stream_13_pck_str_empty       ( pck_str_empty_13             )       ,   
                 .stream_14_pck_str_empty       ( pck_str_empty_14             )       ,   
                 .stream_15_pck_str_empty       ( pck_str_empty_15             )       ,   
                              
                 .STREAM_REG                    ( OUT_STREAM_2_REG_W           )       ,   
                 .IN_STREAM_0_REG               ( IN_STREAM_0_REG_W            )       ,          
                 .IN_STREAM_1_REG               ( IN_STREAM_1_REG_W            )       ,
                 .IN_STREAM_2_REG               ( IN_STREAM_2_REG_W            )       ,
                 .IN_STREAM_3_REG               ( IN_STREAM_3_REG_W            )       ,
                 .IN_STREAM_4_REG               ( IN_STREAM_4_REG_W            )       ,
                 .IN_STREAM_5_REG               ( IN_STREAM_5_REG_W            )       ,
                 .IN_STREAM_6_REG               ( IN_STREAM_6_REG_W            )       ,
                 .IN_STREAM_7_REG               ( IN_STREAM_7_REG_W            )       ,
                 .IN_STREAM_8_REG               ( IN_STREAM_8_REG_W            )       ,
                 .IN_STREAM_9_REG               ( IN_STREAM_9_REG_W            )       ,
                 .IN_STREAM_10_REG              ( IN_STREAM_10_REG_W           )       ,
                 .IN_STREAM_11_REG              ( IN_STREAM_11_REG_W           )       ,
                 .IN_STREAM_12_REG              ( IN_STREAM_12_REG_W           )       ,
                 .IN_STREAM_13_REG              ( IN_STREAM_13_REG_W           )       ,
                 .IN_STREAM_14_REG              ( IN_STREAM_14_REG_W           )       ,
                 .IN_STREAM_15_REG              ( IN_STREAM_15_REG_W           )       ,

                 .tokens_count_en_stream_0      ( token_count_en_stream_0_inst2       )       ,
                 .tokens_count_en_stream_1      ( token_count_en_stream_1_inst2       )       ,
                 .tokens_count_en_stream_2      ( token_count_en_stream_2_inst2       )       ,
                 .tokens_count_en_stream_3      ( token_count_en_stream_3_inst2       )       ,
                 .tokens_count_en_stream_4      ( token_count_en_stream_4_inst2       )       ,
                 .tokens_count_en_stream_5      ( token_count_en_stream_5_inst2       )       ,
                 .tokens_count_en_stream_6      ( token_count_en_stream_6_inst2       )       ,
                 .tokens_count_en_stream_7      ( token_count_en_stream_7_inst2       )       ,
                 .tokens_count_en_stream_8      ( token_count_en_stream_8_inst2       )       ,
                 .tokens_count_en_stream_9      ( token_count_en_stream_9_inst2       )       ,
                 .tokens_count_en_stream_10     ( token_count_en_stream_10_inst2      )       ,
                 .tokens_count_en_stream_11     ( token_count_en_stream_11_inst2      )       ,
                 .tokens_count_en_stream_12     ( token_count_en_stream_12_inst2      )       ,
                 .tokens_count_en_stream_13     ( token_count_en_stream_13_inst2      )       ,
                 .tokens_count_en_stream_14     ( token_count_en_stream_14_inst2      )       ,
                 .tokens_count_en_stream_15     ( token_count_en_stream_15_inst2      )       ,

                 .next_state_stream             ( next_state_stream_2_w        )       ,
                 .stream_mapping                ( stream_mapping_stream_2      )       ,

                 .out_stream_busy               ( out_stream_2_valid           )       ,   
                 .out_sop                       ( out_sop_2                    )       ,   
                 .out_stream                    ( out_stream_2                 )       ,   
                 .out_eop                       ( out_eop_2                    )          
                ); 
                /////////////////////////////////////////////////////////////////////////////////////


               //               SCHEDULAR CONTROL FSM MODULE STREAM 3 INSTANTIATION
               sch_ctrl_fsm
               #(
                 .DATA_WIDTH      ( DATA_WIDTH     )       
                )
               sch_ctrl_fsm_stream_3_inst
                (
                 .sch_ctrl_fsm_clk              ( rate_limiter_16to4_clk       )       ,   
                 .sch_ctrl_fsm_rstn             ( rate_limiter_16to4_rstn      )       ,      
                 .sch_ctrl_fsm_sw_rst           ( rate_limiter_16to4_sw_rst    )       ,   

                 .in_sop_0                      ( in_sop_0                     )       ,   
                 .in_stream_0                   ( in_stream_0                  )       ,   
                 .in_eop_0                      ( in_eop_0                     )       ,   
                 .in_sop_1                      ( in_sop_1                     )       ,   
                 .in_stream_1                   ( in_stream_1                  )       ,   
                 .in_eop_1                      ( in_eop_1                     )       ,   
                 .in_sop_2                      ( in_sop_2                     )       ,   
                 .in_stream_2                   ( in_stream_2                  )       ,   
                 .in_eop_2                      ( in_eop_2                     )       ,   
                 .in_sop_3                      ( in_sop_3                     )       ,   
                 .in_stream_3                   ( in_stream_3                  )       ,   
                 .in_eop_3                      ( in_eop_3                     )       ,   
                 .in_sop_4                      ( in_sop_4                     )       ,   
                 .in_stream_4                   ( in_stream_4                  )       ,   
                 .in_eop_4                      ( in_eop_4                     )       ,   
                 .in_sop_5                      ( in_sop_5                     )       ,   
                 .in_stream_5                   ( in_stream_5                  )       ,   
                 .in_eop_5                      ( in_eop_5                     )       ,   
                 .in_sop_6                      ( in_sop_6                     )       ,   
                 .in_stream_6                   ( in_stream_6                  )       ,   
                 .in_eop_6                      ( in_eop_6                     )       ,   
                 .in_sop_7                      ( in_sop_7                     )       ,   
                 .in_stream_7                   ( in_stream_7                  )       ,   
                 .in_eop_7                      ( in_eop_7                     )       ,   
                 .in_sop_8                      ( in_sop_8                     )       ,   
                 .in_stream_8                   ( in_stream_8                  )       ,   
                 .in_eop_8                      ( in_eop_8                     )       ,   
                 .in_sop_9                      ( in_sop_9                     )       ,   
                 .in_stream_9                   ( in_stream_9                  )       ,   
                 .in_eop_9                      ( in_eop_9                     )       ,   
                 .in_sop_10                     ( in_sop_10                    )       ,   
                 .in_stream_10                  ( in_stream_10                 )       ,   
                 .in_eop_10                     ( in_eop_10                    )       ,   
                 .in_sop_11                     ( in_sop_11                    )       ,   
                 .in_stream_11                  ( in_stream_11                 )       ,   
                 .in_eop_11                     ( in_eop_11                    )       ,   
                 .in_sop_12                     ( in_sop_12                    )       ,   
                 .in_stream_12                  ( in_stream_12                 )       ,   
                 .in_eop_12                     ( in_eop_12                    )       ,   
                 .in_sop_13                     ( in_sop_13                    )       ,   
                 .in_stream_13                  ( in_stream_13                 )       ,   
                 .in_eop_13                     ( in_eop_13                    )       ,   
                 .in_sop_14                     ( in_sop_14                    )       ,   
                 .in_stream_14                  ( in_stream_14                 )       ,   
                 .in_eop_14                     ( in_eop_14                    )       ,   
                 .in_sop_15                     ( in_sop_15                    )       ,   
                 .in_stream_15                  ( in_stream_15                 )       ,   
                 .in_eop_15                     ( in_eop_15                    )       ,   
                                
                 .stream_0_pck_str_empty        ( pck_str_empty_0              )       ,   
                 .stream_1_pck_str_empty        ( pck_str_empty_1              )       ,   
                 .stream_2_pck_str_empty        ( pck_str_empty_2              )       ,   
                 .stream_3_pck_str_empty        ( pck_str_empty_3              )       ,   
                 .stream_4_pck_str_empty        ( pck_str_empty_4              )       ,   
                 .stream_5_pck_str_empty        ( pck_str_empty_5              )       ,   
                 .stream_6_pck_str_empty        ( pck_str_empty_6              )       ,   
                 .stream_7_pck_str_empty        ( pck_str_empty_7              )       ,   
                 .stream_8_pck_str_empty        ( pck_str_empty_8              )       ,   
                 .stream_9_pck_str_empty        ( pck_str_empty_9              )       ,   
                 .stream_10_pck_str_empty       ( pck_str_empty_10             )       ,   
                 .stream_11_pck_str_empty       ( pck_str_empty_11             )       ,   
                 .stream_12_pck_str_empty       ( pck_str_empty_12             )       ,   
                 .stream_13_pck_str_empty       ( pck_str_empty_13             )       ,   
                 .stream_14_pck_str_empty       ( pck_str_empty_14             )       ,   
                 .stream_15_pck_str_empty       ( pck_str_empty_15             )       ,   
                              
                 .STREAM_REG                    ( OUT_STREAM_3_REG_W           )       ,   
                 .IN_STREAM_0_REG               ( IN_STREAM_0_REG_W            )       ,          
                 .IN_STREAM_1_REG               ( IN_STREAM_1_REG_W            )       ,
                 .IN_STREAM_2_REG               ( IN_STREAM_2_REG_W            )       ,
                 .IN_STREAM_3_REG               ( IN_STREAM_3_REG_W            )       ,
                 .IN_STREAM_4_REG               ( IN_STREAM_4_REG_W            )       ,
                 .IN_STREAM_5_REG               ( IN_STREAM_5_REG_W            )       ,
                 .IN_STREAM_6_REG               ( IN_STREAM_6_REG_W            )       ,
                 .IN_STREAM_7_REG               ( IN_STREAM_7_REG_W            )       ,
                 .IN_STREAM_8_REG               ( IN_STREAM_8_REG_W            )       ,
                 .IN_STREAM_9_REG               ( IN_STREAM_9_REG_W            )       ,
                 .IN_STREAM_10_REG              ( IN_STREAM_10_REG_W           )       ,
                 .IN_STREAM_11_REG              ( IN_STREAM_11_REG_W           )       ,
                 .IN_STREAM_12_REG              ( IN_STREAM_12_REG_W           )       ,
                 .IN_STREAM_13_REG              ( IN_STREAM_13_REG_W           )       ,
                 .IN_STREAM_14_REG              ( IN_STREAM_14_REG_W           )       ,
                 .IN_STREAM_15_REG              ( IN_STREAM_15_REG_W           )       ,

                 .tokens_count_en_stream_0      ( token_count_en_stream_0_inst3       )       ,
                 .tokens_count_en_stream_1      ( token_count_en_stream_1_inst3       )       ,
                 .tokens_count_en_stream_2      ( token_count_en_stream_2_inst3       )       ,
                 .tokens_count_en_stream_3      ( token_count_en_stream_3_inst3       )       ,
                 .tokens_count_en_stream_4      ( token_count_en_stream_4_inst3       )       ,
                 .tokens_count_en_stream_5      ( token_count_en_stream_5_inst3       )       ,
                 .tokens_count_en_stream_6      ( token_count_en_stream_6_inst3       )       ,
                 .tokens_count_en_stream_7      ( token_count_en_stream_7_inst3       )       ,
                 .tokens_count_en_stream_8      ( token_count_en_stream_8_inst3       )       ,
                 .tokens_count_en_stream_9      ( token_count_en_stream_9_inst3       )       ,
                 .tokens_count_en_stream_10     ( token_count_en_stream_10_inst3      )       ,
                 .tokens_count_en_stream_11     ( token_count_en_stream_11_inst3      )       ,
                 .tokens_count_en_stream_12     ( token_count_en_stream_12_inst3      )       ,
                 .tokens_count_en_stream_13     ( token_count_en_stream_13_inst3      )       ,
                 .tokens_count_en_stream_14     ( token_count_en_stream_14_inst3      )       ,
                 .tokens_count_en_stream_15     ( token_count_en_stream_15_inst3      )       ,

                 .next_state_stream             ( next_state_stream_3_w        )       ,
                 .stream_mapping                ( stream_mapping_stream_3      )       ,

                 .out_stream_busy               ( out_stream_3_valid           )       ,   
                 .out_sop                       ( out_sop_3                    )       ,   
                 .out_stream                    ( out_stream_3                 )       ,   
                 .out_eop                       ( out_eop_3                    )          
                ); 
               /////////////////////////////////////////////////////////////////////////////////////

               //   ASSIGNING ENABLE OF EACH STREAM OF EACH INSTANCES TO SINGLE VARIABLE
               assign token_count_en_stream_0_w  = (token_count_en_stream_0_inst0  || token_count_en_stream_0_inst1  || token_count_en_stream_0_inst2  || token_count_en_stream_0_inst3 ) ;  
               assign token_count_en_stream_1_w  = (token_count_en_stream_1_inst0  || token_count_en_stream_1_inst1  || token_count_en_stream_1_inst2  || token_count_en_stream_1_inst3 ) ;
               assign token_count_en_stream_2_w  = (token_count_en_stream_2_inst0  || token_count_en_stream_2_inst1  || token_count_en_stream_2_inst2  || token_count_en_stream_2_inst3 ) ;
               assign token_count_en_stream_3_w  = (token_count_en_stream_3_inst0  || token_count_en_stream_3_inst1  || token_count_en_stream_3_inst2  || token_count_en_stream_3_inst3 ) ;
               assign token_count_en_stream_4_w  = (token_count_en_stream_4_inst0  || token_count_en_stream_4_inst1  || token_count_en_stream_4_inst2  || token_count_en_stream_4_inst3 ) ;
               assign token_count_en_stream_5_w  = (token_count_en_stream_5_inst0  || token_count_en_stream_5_inst1  || token_count_en_stream_5_inst2  || token_count_en_stream_5_inst3 ) ;
               assign token_count_en_stream_6_w  = (token_count_en_stream_6_inst0  || token_count_en_stream_6_inst1  || token_count_en_stream_6_inst2  || token_count_en_stream_6_inst3 ) ;
               assign token_count_en_stream_7_w  = (token_count_en_stream_7_inst0  || token_count_en_stream_7_inst1  || token_count_en_stream_7_inst2  || token_count_en_stream_7_inst3 ) ;
               assign token_count_en_stream_8_w  = (token_count_en_stream_8_inst0  || token_count_en_stream_8_inst1  || token_count_en_stream_8_inst2  || token_count_en_stream_8_inst3 ) ;
               assign token_count_en_stream_9_w  = (token_count_en_stream_9_inst0  || token_count_en_stream_9_inst1  || token_count_en_stream_9_inst2  || token_count_en_stream_9_inst3 ) ;
               assign token_count_en_stream_10_w = (token_count_en_stream_10_inst0 || token_count_en_stream_10_inst1 || token_count_en_stream_10_inst2 || token_count_en_stream_10_inst3) ;
               assign token_count_en_stream_11_w = (token_count_en_stream_11_inst0 || token_count_en_stream_11_inst1 || token_count_en_stream_11_inst2 || token_count_en_stream_11_inst3) ;
               assign token_count_en_stream_12_w = (token_count_en_stream_12_inst0 || token_count_en_stream_12_inst1 || token_count_en_stream_12_inst2 || token_count_en_stream_12_inst3) ;
               assign token_count_en_stream_13_w = (token_count_en_stream_13_inst0 || token_count_en_stream_13_inst1 || token_count_en_stream_13_inst2 || token_count_en_stream_13_inst3) ;
               assign token_count_en_stream_14_w = (token_count_en_stream_14_inst0 || token_count_en_stream_14_inst1 || token_count_en_stream_14_inst2 || token_count_en_stream_14_inst3) ;
               assign token_count_en_stream_15_w = (token_count_en_stream_15_inst0 || token_count_en_stream_15_inst1 || token_count_en_stream_15_inst2 || token_count_en_stream_15_inst3) ;

               //              ARBITER MODULE INSTANTIATION
               /////////////////////////////////////////////////////////////////////////////////////
               grant_arbiter
               grant_arbiter_inst
               (
                .next_state_stream_0           ( next_state_stream_0_w       )          ,    
                .next_state_stream_1           ( next_state_stream_1_w       )          ,   
                .next_state_stream_2           ( next_state_stream_2_w       )          ,   
                .next_state_stream_3           ( next_state_stream_3_w       )          ,   
                                                                   
                .token_count_en_stream_0       ( token_count_en_stream_0_w   )          ,                                                  
                .token_count_en_stream_1       ( token_count_en_stream_1_w   )          ,                                                 
                .token_count_en_stream_2       ( token_count_en_stream_2_w   )          ,                                                  
                .token_count_en_stream_3       ( token_count_en_stream_3_w   )          ,                                                  
                .token_count_en_stream_4       ( token_count_en_stream_4_w   )          ,                                                  
                .token_count_en_stream_5       ( token_count_en_stream_5_w   )          ,                                                 
                .token_count_en_stream_6       ( token_count_en_stream_6_w   )          ,                                                  
                .token_count_en_stream_7       ( token_count_en_stream_7_w   )          ,                                                  
                .token_count_en_stream_8       ( token_count_en_stream_8_w   )          ,                                                  
                .token_count_en_stream_9       ( token_count_en_stream_9_w   )          ,                                                 
                .token_count_en_stream_10      ( token_count_en_stream_10_w  )          ,                                                  
                .token_count_en_stream_11      ( token_count_en_stream_11_w  )          ,                                                  
                .token_count_en_stream_12      ( token_count_en_stream_12_w  )          ,                                                  
                .token_count_en_stream_13      ( token_count_en_stream_13_w  )          ,                                                 
                .token_count_en_stream_14      ( token_count_en_stream_14_w  )          ,                                                  
                .token_count_en_stream_15      ( token_count_en_stream_15_w  )          ,                                                  

                .stream_mapping_stream_0       ( stream_mapping_stream_0     )          ,  
                .stream_mapping_stream_1       ( stream_mapping_stream_1     )          ,
                .stream_mapping_stream_2       ( stream_mapping_stream_2     )          ,
                .stream_mapping_stream_3       ( stream_mapping_stream_3     )          ,
                
                .pck_rd_en_grnt_0              ( pck_rd_en_grnt_0            )          ,   
                .pck_rd_en_grnt_1              ( pck_rd_en_grnt_1            )          ,   
                .pck_rd_en_grnt_2              ( pck_rd_en_grnt_2            )          ,   
                .pck_rd_en_grnt_3              ( pck_rd_en_grnt_3            )          ,   
                .pck_rd_en_grnt_4              ( pck_rd_en_grnt_4            )          ,   
                .pck_rd_en_grnt_5              ( pck_rd_en_grnt_5            )          ,   
                .pck_rd_en_grnt_6              ( pck_rd_en_grnt_6            )          ,   
                .pck_rd_en_grnt_7              ( pck_rd_en_grnt_7            )          ,   
                .pck_rd_en_grnt_8              ( pck_rd_en_grnt_8            )          ,   
                .pck_rd_en_grnt_9              ( pck_rd_en_grnt_9            )          ,   
                .pck_rd_en_grnt_10             ( pck_rd_en_grnt_10           )          ,   
                .pck_rd_en_grnt_11             ( pck_rd_en_grnt_11           )          ,   
                .pck_rd_en_grnt_12             ( pck_rd_en_grnt_12           )          ,   
                .pck_rd_en_grnt_13             ( pck_rd_en_grnt_13           )          ,   
                .pck_rd_en_grnt_14             ( pck_rd_en_grnt_14           )          ,   
                .pck_rd_en_grnt_15             ( pck_rd_en_grnt_15           )           
               ); 
               /////////////////////////////////////////////////////////////////////////////////////

endmodule
