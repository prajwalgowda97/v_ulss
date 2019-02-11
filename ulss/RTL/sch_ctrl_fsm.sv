module sch_ctrl_fsm 
        #(parameter DATA_WIDTH    = 64                 
         )
         (
          //   GLOBAL SIGNALS
          input    logic                         sch_ctrl_fsm_clk            ,
          input    logic                         sch_ctrl_fsm_rstn           ,
          input    logic                         sch_ctrl_fsm_sw_rst         ,

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

          //   INPUTS FROM 16 PACKET STORES
          input    logic                         stream_0_pck_str_empty      ,
          input    logic                         stream_1_pck_str_empty      ,
          input    logic                         stream_2_pck_str_empty      ,
          input    logic                         stream_3_pck_str_empty      ,
          input    logic                         stream_4_pck_str_empty      ,
          input    logic                         stream_5_pck_str_empty      ,
          input    logic                         stream_6_pck_str_empty      ,
          input    logic                         stream_7_pck_str_empty      ,
          input    logic                         stream_8_pck_str_empty      ,
          input    logic                         stream_9_pck_str_empty      ,
          input    logic                         stream_10_pck_str_empty     ,
          input    logic                         stream_11_pck_str_empty     ,
          input    logic                         stream_12_pck_str_empty     ,
          input    logic                         stream_13_pck_str_empty     ,
          input    logic                         stream_14_pck_str_empty     ,
          input    logic                         stream_15_pck_str_empty     ,

          //    INPUTS FROM REGISTER FILE 
          //    TOKENS FROM REGISTER FILE
          input    logic   [DATA_WIDTH-1:0]      STREAM_REG                  ,
          input    logic   [DATA_WIDTH-1:0]      IN_STREAM_0_REG             ,
          input    logic   [DATA_WIDTH-1:0]      IN_STREAM_1_REG             ,
          input    logic   [DATA_WIDTH-1:0]      IN_STREAM_2_REG             ,
          input    logic   [DATA_WIDTH-1:0]      IN_STREAM_3_REG             ,
          input    logic   [DATA_WIDTH-1:0]      IN_STREAM_4_REG             ,
          input    logic   [DATA_WIDTH-1:0]      IN_STREAM_5_REG             ,
          input    logic   [DATA_WIDTH-1:0]      IN_STREAM_6_REG             ,
          input    logic   [DATA_WIDTH-1:0]      IN_STREAM_7_REG             ,
          input    logic   [DATA_WIDTH-1:0]      IN_STREAM_8_REG             ,
          input    logic   [DATA_WIDTH-1:0]      IN_STREAM_9_REG             ,
          input    logic   [DATA_WIDTH-1:0]      IN_STREAM_10_REG            ,
          input    logic   [DATA_WIDTH-1:0]      IN_STREAM_11_REG            ,
          input    logic   [DATA_WIDTH-1:0]      IN_STREAM_12_REG            ,
          input    logic   [DATA_WIDTH-1:0]      IN_STREAM_13_REG            ,
          input    logic   [DATA_WIDTH-1:0]      IN_STREAM_14_REG            ,
          input    logic   [DATA_WIDTH-1:0]      IN_STREAM_15_REG            ,

          //    OUTPUTS FOR ARBITER FSM TO GIVE GRANT
          output   logic   [4:0]                 next_state_stream           , 
          output   logic   [15:0]                stream_mapping              ,

          output   logic                         tokens_count_en_stream_0    ,
          output   logic                         tokens_count_en_stream_1    ,
          output   logic                         tokens_count_en_stream_2    ,
          output   logic                         tokens_count_en_stream_3    ,
          output   logic                         tokens_count_en_stream_4    ,
          output   logic                         tokens_count_en_stream_5    ,
          output   logic                         tokens_count_en_stream_6    ,
          output   logic                         tokens_count_en_stream_7    ,
          output   logic                         tokens_count_en_stream_8    ,
          output   logic                         tokens_count_en_stream_9    ,
          output   logic                         tokens_count_en_stream_10   ,
          output   logic                         tokens_count_en_stream_11   ,
          output   logic                         tokens_count_en_stream_12   ,
          output   logic                         tokens_count_en_stream_13   ,
          output   logic                         tokens_count_en_stream_14   ,
          output   logic                         tokens_count_en_stream_15   ,

          //////////////////////////    OUTPUTS     //////////////////////////
          //   OUTPUTS STREAM
          output   logic                         out_stream_busy             ,
          output   logic                         out_sop                     ,
          output   logic   [DATA_WIDTH-1:0]      out_stream                  ,
          output   logic                         out_eop                   
         );

         //         INTERNAL DECLERATIONS TO READ FROM THE REGISTERS  
         logic     [47:0]           stream_0_packets                           ;
         logic     [15:0]           stream_0_tokens                            ;
         logic     [47:0]           stream_1_packets                           ;
         logic     [15:0]           stream_1_tokens                            ;
         logic     [47:0]           stream_2_packets                           ;
         logic     [15:0]           stream_2_tokens                            ;
         logic     [47:0]           stream_3_packets                           ;
         logic     [15:0]           stream_3_tokens                            ;
         logic     [47:0]           stream_4_packets                           ;
         logic     [15:0]           stream_4_tokens                            ;
         logic     [47:0]           stream_5_packets                           ;
         logic     [15:0]           stream_5_tokens                            ;
         logic     [47:0]           stream_6_packets                           ;
         logic     [15:0]           stream_6_tokens                            ;
         logic     [47:0]           stream_7_packets                           ;
         logic     [15:0]           stream_7_tokens                            ;
         logic     [47:0]           stream_8_packets                           ;
         logic     [15:0]           stream_8_tokens                            ;
         logic     [47:0]           stream_9_packets                           ;
         logic     [15:0]           stream_9_tokens                            ;
         logic     [47:0]           stream_10_packets                          ;
         logic     [15:0]           stream_10_tokens                           ;
         logic     [47:0]           stream_11_packets                          ;
         logic     [15:0]           stream_11_tokens                           ;
         logic     [47:0]           stream_12_packets                          ;
         logic     [15:0]           stream_12_tokens                           ;
         logic     [47:0]           stream_13_packets                          ;
         logic     [15:0]           stream_13_tokens                           ;
         logic     [47:0]           stream_14_packets                          ;
         logic     [15:0]           stream_14_tokens                           ;
         logic     [47:0]           stream_15_packets                          ;
         logic     [15:0]           stream_15_tokens                           ;
                                              
         //         COUNTER WHICH WILL COUNT  PACKET LENGTH
         logic     [47:0]           packets_count_0                              ;
         logic     [47:0]           packets_count_1                              ;
         logic     [47:0]           packets_count_2                              ;
         logic     [47:0]           packets_count_3                              ;
         logic     [47:0]           packets_count_4                              ;
         logic     [47:0]           packets_count_5                              ;
         logic     [47:0]           packets_count_6                              ;
         logic     [47:0]           packets_count_7                              ;
         logic     [47:0]           packets_count_8                              ;
         logic     [47:0]           packets_count_9                              ;
         logic     [47:0]           packets_count_10                             ;
         logic     [47:0]           packets_count_11                             ;
         logic     [47:0]           packets_count_12                             ;
         logic     [47:0]           packets_count_13                             ;
         logic     [47:0]           packets_count_14                             ;
         logic     [47:0]           packets_count_15                             ;

         logic     [15:0]           tokens_count_0                               ;
         logic     [15:0]           tokens_count_1                               ;
         logic     [15:0]           tokens_count_2                               ;
         logic     [15:0]           tokens_count_3                               ;
         logic     [15:0]           tokens_count_4                               ;
         logic     [15:0]           tokens_count_5                               ;
         logic     [15:0]           tokens_count_6                               ;
         logic     [15:0]           tokens_count_7                               ;
         logic     [15:0]           tokens_count_8                               ;
         logic     [15:0]           tokens_count_9                               ;
         logic     [15:0]           tokens_count_10                              ;
         logic     [15:0]           tokens_count_11                              ;
         logic     [15:0]           tokens_count_12                              ;
         logic     [15:0]           tokens_count_13                              ;
         logic     [15:0]           tokens_count_14                              ;
         logic     [15:0]           tokens_count_15                              ;

         logic                      nt_valid_stream_0                            ;
         logic                      nt_valid_stream_1                            ;
         logic                      nt_valid_stream_2                            ;
         logic                      nt_valid_stream_3                            ;
         logic                      nt_valid_stream_4                            ;
         logic                      nt_valid_stream_5                            ;
         logic                      nt_valid_stream_6                            ;
         logic                      nt_valid_stream_7                            ;
         logic                      nt_valid_stream_8                            ;
         logic                      nt_valid_stream_9                            ;
         logic                      nt_valid_stream_10                           ;
         logic                      nt_valid_stream_11                           ;
         logic                      nt_valid_stream_12                           ;
         logic                      nt_valid_stream_13                           ;
         logic                      nt_valid_stream_14                           ;
         logic                      nt_valid_stream_15                           ;
                                              
         //                 FSM DECLERATIONS  
         localparam     IDLE_STATE                = 5'd0                     ;
         localparam     SCHEDULE_INPUT_STREAM_0   = 5'd1                     ;
         localparam     SCHEDULE_INPUT_STREAM_1   = 5'd2                     ;
         localparam     SCHEDULE_INPUT_STREAM_2   = 5'd3                     ;
         localparam     SCHEDULE_INPUT_STREAM_3   = 5'd4                     ;
         localparam     SCHEDULE_INPUT_STREAM_4   = 5'd5                     ;
         localparam     SCHEDULE_INPUT_STREAM_5   = 5'd6                     ;
         localparam     SCHEDULE_INPUT_STREAM_6   = 5'd7                     ;
         localparam     SCHEDULE_INPUT_STREAM_7   = 5'd8                     ;
         localparam     SCHEDULE_INPUT_STREAM_8   = 5'd9                     ;
         localparam     SCHEDULE_INPUT_STREAM_9   = 5'd10                    ;
         localparam     SCHEDULE_INPUT_STREAM_10  = 5'd11                    ;
         localparam     SCHEDULE_INPUT_STREAM_11  = 5'd12                    ;
         localparam     SCHEDULE_INPUT_STREAM_12  = 5'd13                    ;
         localparam     SCHEDULE_INPUT_STREAM_13  = 5'd14                    ;
         localparam     SCHEDULE_INPUT_STREAM_14  = 5'd15                    ;
         localparam     SCHEDULE_INPUT_STREAM_15  = 5'd16                    ;

         //     DECLERATIONS FOR FSM 
         logic     [4:0]       present_state_stream                          ;
         //logic   [4:0]       next_state_stream                               ;

         //     ASSIGNING STREAM_MAPPING, TOKENS AND PACKETS FOR THE VARIABLES FOR THE EACH STREAMS
         assign stream_mapping = STREAM_REG[15:0]                              ;

         assign stream_0_tokens   = IN_STREAM_0_REG [15:0 ]                    ;
         assign stream_0_packets  = IN_STREAM_0_REG [63:16]                    ;
         assign stream_1_tokens   = IN_STREAM_1_REG [15:0 ]                    ;
         assign stream_1_packets  = IN_STREAM_1_REG [63:16]                    ;
         assign stream_2_tokens   = IN_STREAM_2_REG [15:0 ]                    ;
         assign stream_2_packets  = IN_STREAM_2_REG [63:16]                    ;
         assign stream_3_tokens   = IN_STREAM_3_REG [15:0 ]                    ;
         assign stream_3_packets  = IN_STREAM_3_REG [63:16]                    ;
         assign stream_4_tokens   = IN_STREAM_4_REG [15:0 ]                    ;
         assign stream_4_packets  = IN_STREAM_4_REG [63:16]                    ;
         assign stream_5_tokens   = IN_STREAM_5_REG [15:0 ]                    ;
         assign stream_5_packets  = IN_STREAM_5_REG [63:16]                    ;
         assign stream_6_tokens   = IN_STREAM_6_REG [15:0 ]                    ;
         assign stream_6_packets  = IN_STREAM_6_REG [63:16]                    ;
         assign stream_7_tokens   = IN_STREAM_7_REG [15:0 ]                    ;
         assign stream_7_packets  = IN_STREAM_7_REG [63:16]                    ;
         assign stream_8_tokens   = IN_STREAM_8_REG [15:0 ]                    ;
         assign stream_8_packets  = IN_STREAM_8_REG [63:16]                    ;
         assign stream_9_tokens   = IN_STREAM_9_REG [15:0 ]                    ;
         assign stream_9_packets  = IN_STREAM_9_REG [63:16]                    ;
         assign stream_10_tokens  = IN_STREAM_10_REG[15:0 ]                    ;
         assign stream_10_packets = IN_STREAM_10_REG[63:16]                    ;
         assign stream_11_tokens  = IN_STREAM_11_REG[15:0 ]                    ;
         assign stream_11_packets = IN_STREAM_11_REG[63:16]                    ;
         assign stream_12_tokens  = IN_STREAM_12_REG[15:0 ]                    ;
         assign stream_12_packets = IN_STREAM_12_REG[63:16]                    ;
         assign stream_13_tokens  = IN_STREAM_13_REG[15:0 ]                    ;
         assign stream_13_packets = IN_STREAM_13_REG[63:16]                    ;
         assign stream_14_tokens  = IN_STREAM_14_REG[15:0 ]                    ;
         assign stream_14_packets = IN_STREAM_14_REG[63:16]                    ;
         assign stream_15_tokens  = IN_STREAM_15_REG[15:0 ]                    ;
         assign stream_15_packets = IN_STREAM_15_REG[63:16]                    ;

         //     PRESENT STATE LOGIC FOR ALL 16 STREAMS 
         always_ff@(posedge sch_ctrl_fsm_clk or negedge sch_ctrl_fsm_rstn)
         begin
         if(!sch_ctrl_fsm_rstn)
             begin
             present_state_stream  <= IDLE_STATE               ;
             end
         else if(sch_ctrl_fsm_sw_rst)
             begin
             present_state_stream  <= IDLE_STATE               ;
             end
         else
             begin
             present_state_stream  <= next_state_stream        ;
             end
         end
         /////////////////////////////////////////////////////////////////////////////////////////////////
          
         //     NEXT STATE LOGIC FOR STREAM 0
         always_comb
         begin

         unique case(present_state_stream)
         IDLE_STATE                : 
                                    begin    
                                    if((stream_mapping[0]==1'B1) && (!stream_0_pck_str_empty))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_0 ;
                                        end
                                    else if((stream_mapping[1]==1'B1) && (!stream_1_pck_str_empty))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_1 ;
                                        end
                                    else if((stream_mapping[2]==1'B1) && (!stream_2_pck_str_empty))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_2 ;
                                        end
                                    else if((stream_mapping[3]==1'B1) && (!stream_3_pck_str_empty))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_3 ;
                                        end
                                    else if((stream_mapping[4]==1'B1) && (!stream_4_pck_str_empty))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_4 ;
                                        end
                                    else if((stream_mapping[5]==1'B1) && (!stream_5_pck_str_empty))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_5 ;
                                        end
                                    else if((stream_mapping[6]==1'B1) && (!stream_6_pck_str_empty))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_6 ;
                                        end
                                    else if((stream_mapping[7]==1'B1) && (!stream_7_pck_str_empty))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_7 ;
                                        end
                                    else if((stream_mapping[8]==1'B1) && (!stream_8_pck_str_empty))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_8 ;
                                        end
                                    else if((stream_mapping[9]==1'B1) && (!stream_9_pck_str_empty))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_9 ;
                                        end
                                    else if((stream_mapping[10]==1'B1) && (!stream_10_pck_str_empty))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_10 ;
                                        end
                                    else if((stream_mapping[11]==1'B1) && (!stream_11_pck_str_empty))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_11 ;
                                        end
                                    else if((stream_mapping[12]==1'B1) && (!stream_12_pck_str_empty))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_12 ;
                                        end
                                    else if((stream_mapping[13]==1'B1) && (!stream_13_pck_str_empty))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_13 ;
                                        end
                                    else if((stream_mapping[14]==1'B1) && (!stream_14_pck_str_empty))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_14 ;
                                        end
                                    else if((stream_mapping[15]==1'B1) && (!stream_15_pck_str_empty))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_15 ;
                                        end
                                    else 
                                        begin
                                        next_state_stream = IDLE_STATE               ;
                                        end
                                    end 
         SCHEDULE_INPUT_STREAM_0   :
                                    begin
                                   
                                    if((stream_mapping[1]==1'B1) && (!stream_1_pck_str_empty) && (packets_count_0 == stream_0_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_1 ;
                                        end
                                    else if((stream_mapping[2]==1'B1) && (!stream_2_pck_str_empty) && (packets_count_0 == stream_0_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_2 ;
                                        end
                                    else if((stream_mapping[3]==1'B1) && (!stream_3_pck_str_empty) && (packets_count_0 == stream_0_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_3 ;
                                        end
                                    else if((stream_mapping[4]==1'B1) && (!stream_4_pck_str_empty) && (packets_count_0 == stream_0_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_4 ;
                                        end
                                    else if((stream_mapping[5]==1'B1) && (!stream_5_pck_str_empty) && (packets_count_0 == stream_0_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_5 ;
                                        end
                                    else if((stream_mapping[6]==1'B1) && (!stream_6_pck_str_empty) && (packets_count_0 == stream_0_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_6 ;
                                        end
                                    else if((stream_mapping[7]==1'B1) && (!stream_7_pck_str_empty) && (packets_count_0 == stream_0_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_7 ;
                                        end
                                    else if((stream_mapping[8]==1'B1) && (!stream_8_pck_str_empty) && (packets_count_0 == stream_0_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_8 ;
                                        end
                                    else if((stream_mapping[9]==1'B1) && (!stream_9_pck_str_empty) && (packets_count_0 == stream_0_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_9 ;
                                        end
                                    else if((stream_mapping[10]==1'B1) && (!stream_10_pck_str_empty) && (packets_count_0 == stream_0_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_10 ;
                                        end
                                    else if((stream_mapping[11]==1'B1) && (!stream_11_pck_str_empty) && (packets_count_0 == stream_0_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_11 ;
                                        end
                                    else if((stream_mapping[12]==1'B1) && (!stream_12_pck_str_empty) && (packets_count_0 == stream_0_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_12 ;
                                        end
                                    else if((stream_mapping[13]==1'B1) && (!stream_13_pck_str_empty) && (packets_count_0 == stream_0_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_13 ;
                                        end
                                    else if((stream_mapping[14]==1'B1) && (!stream_14_pck_str_empty) && (packets_count_0 == stream_0_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_14 ;
                                        end
                                    else if((stream_mapping[15]==1'B1) && (!stream_15_pck_str_empty) && (packets_count_0 == stream_0_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_15 ;
                                        end
                                    else if((stream_0_pck_str_empty) && (packets_count_0 == stream_0_packets))    
                                        begin
                                        next_state_stream = IDLE_STATE               ;
                                        end
                                    else
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_0  ;
                                        end
                                    end
         SCHEDULE_INPUT_STREAM_1   : 
                                    begin      
                                    if((stream_mapping[0]==1'B1) && (!stream_0_pck_str_empty) && (packets_count_1 == stream_1_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_0 ;
                                        end
                                    else if((stream_mapping[2]==1'B1) && (!stream_2_pck_str_empty) && (packets_count_1 == stream_1_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_2 ;
                                        end
                                    else if((stream_mapping[3]==1'B1) && (!stream_3_pck_str_empty) && (packets_count_1 == stream_1_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_3 ;
                                        end
                                    else if((stream_mapping[4]==1'B1) && (!stream_4_pck_str_empty) && (packets_count_1 == stream_1_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_4 ;
                                        end
                                    else if((stream_mapping[5]==1'B1) && (!stream_5_pck_str_empty) && (packets_count_1 == stream_1_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_5 ;
                                        end
                                    else if((stream_mapping[6]==1'B1) && (!stream_6_pck_str_empty) && (packets_count_1 == stream_1_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_6 ;
                                        end
                                    else if((stream_mapping[7]==1'B1) && (!stream_7_pck_str_empty) && (packets_count_1 == stream_1_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_7 ;
                                        end
                                    else if((stream_mapping[8]==1'B1) && (!stream_8_pck_str_empty) && (packets_count_1 == stream_1_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_8 ;
                                        end
                                    else if((stream_mapping[9]==1'B1) && (!stream_9_pck_str_empty) && (packets_count_1 == stream_1_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_9 ;
                                        end
                                    else if((stream_mapping[10]==1'B1) && (!stream_10_pck_str_empty) && (packets_count_1 == stream_1_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_10 ;
                                        end
                                    else if((stream_mapping[11]==1'B1) && (!stream_11_pck_str_empty) && (packets_count_1 == stream_1_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_11 ;
                                        end
                                    else if((stream_mapping[12]==1'B1) && (!stream_12_pck_str_empty) && (packets_count_1 == stream_1_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_12 ;
                                        end
                                    else if((stream_mapping[13]==1'B1) && (!stream_13_pck_str_empty) && (packets_count_1 == stream_1_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_13 ;
                                        end
                                    else if((stream_mapping[14]==1'B1) && (!stream_14_pck_str_empty) && (packets_count_1 == stream_1_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_14 ;
                                        end
                                    else if((stream_mapping[15]==1'B1) && (!stream_15_pck_str_empty) && (packets_count_1 == stream_1_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_15 ;
                                        end
                                    else if((stream_1_pck_str_empty) && (packets_count_1 == stream_1_packets))    
                                        begin
                                        next_state_stream = IDLE_STATE               ;
                                        end
                                    else
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_1  ;
                                        end
                                    end
         SCHEDULE_INPUT_STREAM_2   : 
                                    begin  
                                    if((stream_mapping[0]==1'B1) && (!stream_0_pck_str_empty) && (packets_count_2 == stream_2_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_0 ;
                                        end
                                    else if((stream_mapping[1]==1'B1) && (!stream_1_pck_str_empty) && (packets_count_2 == stream_2_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_1 ;
                                        end
                                    else if((stream_mapping[3]==1'B1) && (!stream_3_pck_str_empty) && (packets_count_2 == stream_2_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_3 ;
                                        end
                                    else if((stream_mapping[4]==1'B1) && (!stream_4_pck_str_empty) && (packets_count_2 == stream_2_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_4 ;
                                        end
                                    else if((stream_mapping[5]==1'B1) && (!stream_5_pck_str_empty) && (packets_count_2 == stream_2_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_5 ;
                                        end
                                    else if((stream_mapping[6]==1'B1) && (!stream_6_pck_str_empty) && (packets_count_2 == stream_2_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_6 ;
                                        end
                                    else if((stream_mapping[7]==1'B1) && (!stream_7_pck_str_empty) && (packets_count_2 == stream_2_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_7 ;
                                        end
                                    else if((stream_mapping[8]==1'B1) && (!stream_8_pck_str_empty) && (packets_count_2 == stream_2_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_8 ;
                                        end
                                    else if((stream_mapping[9]==1'B1) && (!stream_9_pck_str_empty) && (packets_count_2 == stream_2_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_9 ;
                                        end
                                    else if((stream_mapping[10]==1'B1) && (!stream_10_pck_str_empty) && (packets_count_2 == stream_2_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_10 ;
                                        end
                                    else if((stream_mapping[11]==1'B1) && (!stream_11_pck_str_empty) && (packets_count_2 == stream_2_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_11 ;
                                        end
                                    else if((stream_mapping[12]==1'B1) && (!stream_12_pck_str_empty) && (packets_count_2 == stream_2_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_12 ;
                                        end
                                    else if((stream_mapping[13]==1'B1) && (!stream_13_pck_str_empty) && (packets_count_2 == stream_2_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_13 ;
                                        end
                                    else if((stream_mapping[14]==1'B1) && (!stream_14_pck_str_empty) && (packets_count_2 == stream_2_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_14 ;
                                        end
                                    else if((stream_mapping[15]==1'B1) && (!stream_15_pck_str_empty) && (packets_count_2 == stream_2_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_15 ;
                                        end
                                    else if((stream_2_pck_str_empty) && (packets_count_2 == stream_2_packets))    
                                        begin
                                        next_state_stream = IDLE_STATE               ;
                                        end 
                                    else
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_2  ;
                                        end
                                    end
         SCHEDULE_INPUT_STREAM_3   : 
                                    begin         
                                    if((stream_mapping[0]==1'B1) && (!stream_0_pck_str_empty) && (packets_count_3 == stream_3_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_0 ;
                                        end
                                    else if((stream_mapping[1]==1'B1) && (!stream_1_pck_str_empty) && (packets_count_3 == stream_3_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_1 ;
                                        end
                                    else if((stream_mapping[2]==1'B1) && (!stream_2_pck_str_empty) && (packets_count_3 == stream_3_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_2 ;
                                        end
                                    else if((stream_mapping[4]==1'B1) && (!stream_4_pck_str_empty) && (packets_count_3 == stream_3_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_4 ;
                                        end
                                    else if((stream_mapping[5]==1'B1) && (!stream_5_pck_str_empty) && (packets_count_3 == stream_3_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_5 ;
                                        end
                                    else if((stream_mapping[6]==1'B1) && (!stream_6_pck_str_empty) && (packets_count_3 == stream_3_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_6 ;
                                        end
                                    else if((stream_mapping[7]==1'B1) && (!stream_7_pck_str_empty) && (packets_count_3 == stream_3_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_7 ;
                                        end
                                    else if((stream_mapping[8]==1'B1) && (!stream_8_pck_str_empty) && (packets_count_3 == stream_3_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_8 ;
                                        end
                                    else if((stream_mapping[9]==1'B1) && (!stream_9_pck_str_empty) && (packets_count_3 == stream_3_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_9 ;
                                        end
                                    else if((stream_mapping[10]==1'B1) && (!stream_10_pck_str_empty) && (packets_count_3 == stream_3_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_10 ;
                                        end
                                    else if((stream_mapping[11]==1'B1) && (!stream_11_pck_str_empty) && (packets_count_3 == stream_3_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_11 ;
                                        end
                                    else if((stream_mapping[12]==1'B1) && (!stream_12_pck_str_empty) && (packets_count_3 == stream_3_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_12 ;
                                        end
                                    else if((stream_mapping[13]==1'B1) && (!stream_13_pck_str_empty) && (packets_count_3 == stream_3_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_13 ;
                                        end
                                    else if((stream_mapping[14]==1'B1) && (!stream_14_pck_str_empty) && (packets_count_3 == stream_3_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_14 ;
                                        end
                                    else if((stream_mapping[15]==1'B1) && (!stream_15_pck_str_empty) && (packets_count_3 == stream_3_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_15 ;
                                        end
                                    else if((stream_3_pck_str_empty) && (packets_count_3 == stream_3_packets))    
                                        begin
                                        next_state_stream = IDLE_STATE               ;
                                        end 
                                    else
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_3  ;
                                        end
                                    end
         SCHEDULE_INPUT_STREAM_4   : 
                                    begin   
                                   if((stream_mapping[0]==1'B1) && (!stream_0_pck_str_empty) && (packets_count_4 == stream_4_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_0 ;
                                        end
                                    else if((stream_mapping[1]==1'B1) && (!stream_1_pck_str_empty) && (packets_count_4 == stream_4_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_1 ;
                                        end
                                    else if((stream_mapping[2]==1'B1) && (!stream_2_pck_str_empty) && (packets_count_4 == stream_4_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_2 ;
                                        end
                                    else if((stream_mapping[3]==1'B1) && (!stream_3_pck_str_empty) && (packets_count_4 == stream_4_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_3 ;
                                        end
                                    else if((stream_mapping[5]==1'B1) && (!stream_5_pck_str_empty) && (packets_count_4 == stream_4_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_5 ;
                                        end
                                    else if((stream_mapping[6]==1'B1) && (!stream_6_pck_str_empty) && (packets_count_4 == stream_4_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_6 ;
                                        end
                                    else if((stream_mapping[7]==1'B1) && (!stream_7_pck_str_empty) && (packets_count_4 == stream_4_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_7 ;
                                        end
                                    else if((stream_mapping[8]==1'B1) && (!stream_8_pck_str_empty) && (packets_count_4 == stream_4_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_8 ;
                                        end
                                    else if((stream_mapping[9]==1'B1) && (!stream_9_pck_str_empty) && (packets_count_4 == stream_4_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_9 ;
                                        end
                                    else if((stream_mapping[10]==1'B1) && (!stream_10_pck_str_empty) && (packets_count_4 == stream_4_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_10 ;
                                        end
                                    else if((stream_mapping[11]==1'B1) && (!stream_11_pck_str_empty) && (packets_count_4 == stream_4_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_11 ;
                                        end
                                    else if((stream_mapping[12]==1'B1) && (!stream_12_pck_str_empty) && (packets_count_4 == stream_4_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_12 ;
                                        end
                                    else if((stream_mapping[13]==1'B1) && (!stream_13_pck_str_empty) && (packets_count_4 == stream_4_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_13 ;
                                        end
                                    else if((stream_mapping[14]==1'B1) && (!stream_14_pck_str_empty) && (packets_count_4 == stream_4_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_14 ;
                                        end
                                    else if((stream_mapping[15]==1'B1) && (!stream_15_pck_str_empty) && (packets_count_4 == stream_4_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_15 ;
                                        end
                                    else if((stream_4_pck_str_empty) && (packets_count_4 == stream_4_packets))    
                                        begin
                                        next_state_stream = IDLE_STATE               ;
                                        end 
                                    else
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_4  ;
                                        end
                                    end
         SCHEDULE_INPUT_STREAM_5   : 
                                    begin   
                                    if((stream_mapping[0]==1'B1) && (!stream_0_pck_str_empty) && (packets_count_5 == stream_5_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_0 ;
                                        end
                                    else if((stream_mapping[1]==1'B1) && (!stream_1_pck_str_empty) && (packets_count_5 == stream_5_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_1 ;
                                        end
                                    else if((stream_mapping[2]==1'B1) && (!stream_2_pck_str_empty) && (packets_count_5 == stream_5_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_2 ;
                                        end
                                    else if((stream_mapping[3]==1'B1) && (!stream_3_pck_str_empty) && (packets_count_5 == stream_5_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_3 ;
                                        end
                                    else if((stream_mapping[4]==1'B1) && (!stream_4_pck_str_empty) && (packets_count_5 == stream_5_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_4 ;
                                        end
                                    else if((stream_mapping[6]==1'B1) && (!stream_6_pck_str_empty) && (packets_count_5 == stream_5_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_6 ;
                                        end
                                    else if((stream_mapping[7]==1'B1) && (!stream_7_pck_str_empty) && (packets_count_5 == stream_5_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_7 ;
                                        end
                                    else if((stream_mapping[8]==1'B1) && (!stream_8_pck_str_empty) && (packets_count_5 == stream_5_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_8 ;
                                        end
                                    else if((stream_mapping[9]==1'B1) && (!stream_9_pck_str_empty) && (packets_count_5 == stream_5_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_9 ;
                                        end
                                    else if((stream_mapping[10]==1'B1) && (!stream_10_pck_str_empty) && (packets_count_5 == stream_5_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_10 ;
                                        end
                                    else if((stream_mapping[11]==1'B1) && (!stream_11_pck_str_empty) && (packets_count_5 == stream_5_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_11 ;
                                        end
                                    else if((stream_mapping[12]==1'B1) && (!stream_12_pck_str_empty) && (packets_count_5 == stream_5_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_12 ;
                                        end
                                    else if((stream_mapping[13]==1'B1) && (!stream_13_pck_str_empty) && (packets_count_5 == stream_5_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_13 ;
                                        end
                                    else if((stream_mapping[14]==1'B1) && (!stream_14_pck_str_empty) && (packets_count_5 == stream_5_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_14 ;
                                        end
                                    else if((stream_mapping[15]==1'B1) && (!stream_15_pck_str_empty) && (packets_count_5 == stream_5_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_15 ;
                                        end
                                    else if((stream_5_pck_str_empty) && (packets_count_5 == stream_5_packets))    
                                        begin
                                        next_state_stream = IDLE_STATE               ;
                                        end 
                                    else
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_5  ;
                                        end
                                    end
         SCHEDULE_INPUT_STREAM_6   : 
                                    begin     
                                    if((stream_mapping[0]==1'B1) && (!stream_0_pck_str_empty) && (packets_count_6 == stream_6_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_0 ;
                                        end
                                    else if((stream_mapping[1]==1'B1) && (!stream_1_pck_str_empty) && (packets_count_6 == stream_6_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_1 ;
                                        end
                                    else if((stream_mapping[2]==1'B1) && (!stream_2_pck_str_empty) && (packets_count_6 == stream_6_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_2 ;
                                        end
                                    else if((stream_mapping[3]==1'B1) && (!stream_3_pck_str_empty) && (packets_count_6 == stream_6_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_3 ;
                                        end
                                    else if((stream_mapping[4]==1'B1) && (!stream_4_pck_str_empty) && (packets_count_6 == stream_6_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_4 ;
                                        end
                                    else if((stream_mapping[5]==1'B1) && (!stream_5_pck_str_empty) && (packets_count_6 == stream_6_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_5 ;
                                        end
                                    else if((stream_mapping[7]==1'B1) && (!stream_7_pck_str_empty) && (packets_count_6 == stream_6_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_7 ;
                                        end
                                    else if((stream_mapping[8]==1'B1) && (!stream_8_pck_str_empty) && (packets_count_6 == stream_6_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_8 ;
                                        end
                                    else if((stream_mapping[9]==1'B1) && (!stream_9_pck_str_empty) && (packets_count_6 == stream_6_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_9 ;
                                        end
                                    else if((stream_mapping[10]==1'B1) && (!stream_10_pck_str_empty) && (packets_count_6 == stream_6_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_10 ;
                                        end
                                    else if((stream_mapping[11]==1'B1) && (!stream_11_pck_str_empty) && (packets_count_6 == stream_6_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_11 ;
                                        end
                                    else if((stream_mapping[12]==1'B1) && (!stream_12_pck_str_empty) && (packets_count_6 == stream_6_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_12 ;
                                        end
                                    else if((stream_mapping[13]==1'B1) && (!stream_13_pck_str_empty) && (packets_count_6 == stream_6_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_13 ;
                                        end
                                    else if((stream_mapping[14]==1'B1) && (!stream_14_pck_str_empty) && (packets_count_6 == stream_6_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_14 ;
                                        end
                                    else if((stream_mapping[15]==1'B1) && (!stream_15_pck_str_empty) && (packets_count_6 == stream_6_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_15 ;
                                        end
                                    else if((stream_6_pck_str_empty) && (packets_count_6 == stream_6_packets))    
                                        begin
                                        next_state_stream = IDLE_STATE               ;
                                        end                                         
                                    else
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_6  ;
                                        end
                                    end
         SCHEDULE_INPUT_STREAM_7   : 
                                    begin     
                                    if((stream_mapping[0]==1'B1) && (!stream_0_pck_str_empty) && (packets_count_7 == stream_7_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_0 ;
                                        end
                                    else if((stream_mapping[1]==1'B1) && (!stream_1_pck_str_empty) && (packets_count_7 == stream_7_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_1 ;
                                        end
                                    else if((stream_mapping[2]==1'B1) && (!stream_2_pck_str_empty) && (packets_count_7 == stream_7_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_2 ;
                                        end
                                    else if((stream_mapping[3]==1'B1) && (!stream_3_pck_str_empty) && (packets_count_7 == stream_7_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_3 ;
                                        end
                                    else if((stream_mapping[4]==1'B1) && (!stream_4_pck_str_empty) && (packets_count_7 == stream_7_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_4 ;
                                        end
                                    else if((stream_mapping[5]==1'B1) && (!stream_5_pck_str_empty) && (packets_count_7 == stream_7_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_5 ;
                                        end
                                    else if((stream_mapping[6]==1'B1) && (!stream_6_pck_str_empty) && (packets_count_7 == stream_7_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_6 ;
                                        end
                                    else if((stream_mapping[8]==1'B1) && (!stream_8_pck_str_empty) && (packets_count_7 == stream_7_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_8 ;
                                        end
                                    else if((stream_mapping[9]==1'B1) && (!stream_9_pck_str_empty) && (packets_count_7 == stream_7_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_9 ;
                                        end
                                    else if((stream_mapping[10]==1'B1) && (!stream_10_pck_str_empty) && (packets_count_7 == stream_7_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_10 ;
                                        end
                                    else if((stream_mapping[11]==1'B1) && (!stream_11_pck_str_empty) && (packets_count_7 == stream_7_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_11 ;
                                        end
                                    else if((stream_mapping[12]==1'B1) && (!stream_12_pck_str_empty) && (packets_count_7 == stream_7_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_12 ;
                                        end
                                    else if((stream_mapping[13]==1'B1) && (!stream_13_pck_str_empty) && (packets_count_7 == stream_7_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_13 ;
                                        end
                                    else if((stream_mapping[14]==1'B1) && (!stream_14_pck_str_empty) && (packets_count_7 == stream_7_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_14 ;
                                        end
                                    else if((stream_mapping[15]==1'B1) && (!stream_15_pck_str_empty) && (packets_count_7 == stream_7_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_15 ;
                                        end
                                    else if((stream_7_pck_str_empty) && (packets_count_7 == stream_7_packets))    
                                        begin
                                        next_state_stream = IDLE_STATE               ;
                                        end 
                                    else
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_7  ;
                                        end
                                    end
         SCHEDULE_INPUT_STREAM_8   : 
                                    begin    
                                    if((stream_mapping[0]==1'B1) && (!stream_0_pck_str_empty) && (packets_count_8 == stream_8_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_0 ;
                                        end
                                    else if((stream_mapping[1]==1'B1) && (!stream_1_pck_str_empty) && (packets_count_8 == stream_8_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_1 ;
                                        end
                                    else if((stream_mapping[2]==1'B1) && (!stream_2_pck_str_empty) && (packets_count_8 == stream_8_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_2 ;
                                        end
                                    else if((stream_mapping[3]==1'B1) && (!stream_3_pck_str_empty) && (packets_count_8 == stream_8_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_3 ;
                                        end
                                    else if((stream_mapping[4]==1'B1) && (!stream_4_pck_str_empty) && (packets_count_8 == stream_8_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_4 ;
                                        end
                                    else if((stream_mapping[5]==1'B1) && (!stream_5_pck_str_empty) && (packets_count_8 == stream_8_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_5 ;
                                        end
                                    else if((stream_mapping[6]==1'B1) && (!stream_6_pck_str_empty) && (packets_count_8 == stream_8_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_6 ;
                                        end
                                    else if((stream_mapping[7]==1'B1) && (!stream_7_pck_str_empty) && (packets_count_8 == stream_8_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_7 ;
                                        end
                                    else if((stream_mapping[9]==1'B1) && (!stream_9_pck_str_empty) && (packets_count_8 == stream_8_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_9 ;
                                        end
                                    else if((stream_mapping[10]==1'B1) && (!stream_10_pck_str_empty) && (packets_count_8 == stream_8_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_10 ;
                                        end
                                    else if((stream_mapping[11]==1'B1) && (!stream_11_pck_str_empty) && (packets_count_8 == stream_8_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_11 ;
                                        end
                                    else if((stream_mapping[12]==1'B1) && (!stream_12_pck_str_empty) && (packets_count_8 == stream_8_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_12 ;
                                        end
                                    else if((stream_mapping[13]==1'B1) && (!stream_13_pck_str_empty) && (packets_count_8 == stream_8_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_13 ;
                                        end
                                    else if((stream_mapping[14]==1'B1) && (!stream_14_pck_str_empty) && (packets_count_8 == stream_8_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_14 ;
                                        end
                                    else if((stream_mapping[15]==1'B1) && (!stream_15_pck_str_empty) && (packets_count_8 == stream_8_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_15 ;
                                        end
                                    else if((stream_8_pck_str_empty) && (packets_count_8 == stream_8_packets))    
                                        begin
                                        next_state_stream = IDLE_STATE               ;
                                        end 
                                    else
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_8  ;
                                        end
                                    end  
         SCHEDULE_INPUT_STREAM_9   : 
                                    begin      
                                    if((stream_mapping[0]==1'B1) && (!stream_0_pck_str_empty) && (packets_count_9 == stream_9_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_0 ;
                                        end
                                    else if((stream_mapping[1]==1'B1) && (!stream_1_pck_str_empty) && (packets_count_9 == stream_9_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_1 ;
                                        end
                                    else if((stream_mapping[2]==1'B1) && (!stream_2_pck_str_empty) && (packets_count_9 == stream_9_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_2 ;
                                        end
                                    else if((stream_mapping[3]==1'B1) && (!stream_3_pck_str_empty) && (packets_count_9 == stream_9_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_3 ;
                                        end
                                    else if((stream_mapping[4]==1'B1) && (!stream_4_pck_str_empty) && (packets_count_9 == stream_9_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_4 ;
                                        end
                                    else if((stream_mapping[5]==1'B1) && (!stream_5_pck_str_empty) && (packets_count_9 == stream_9_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_5 ;
                                        end
                                    else if((stream_mapping[6]==1'B1) && (!stream_6_pck_str_empty) && (packets_count_9 == stream_9_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_6 ;
                                        end
                                    else if((stream_mapping[7]==1'B1) && (!stream_7_pck_str_empty) && (packets_count_9 == stream_9_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_7 ;
                                        end
                                    else if((stream_mapping[8]==1'B1) && (!stream_8_pck_str_empty) && (packets_count_9 == stream_9_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_8 ;
                                        end
                                    else if((stream_mapping[10]==1'B1) && (!stream_10_pck_str_empty) && (packets_count_9 == stream_9_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_10 ;
                                        end
                                    else if((stream_mapping[11]==1'B1) && (!stream_11_pck_str_empty) && (packets_count_9 == stream_9_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_11 ;
                                        end
                                    else if((stream_mapping[12]==1'B1) && (!stream_12_pck_str_empty) && (packets_count_9 == stream_9_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_12 ;
                                        end
                                    else if((stream_mapping[13]==1'B1) && (!stream_13_pck_str_empty) && (packets_count_9 == stream_9_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_13 ;
                                        end
                                    else if((stream_mapping[14]==1'B1) && (!stream_14_pck_str_empty) && (packets_count_9 == stream_9_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_14 ;
                                        end
                                    else if((stream_mapping[15]==1'B1) && (!stream_15_pck_str_empty) && (packets_count_9 == stream_9_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_15 ;
                                        end
                                    else if((stream_9_pck_str_empty) && (packets_count_9 == stream_9_packets))    
                                        begin
                                        next_state_stream = IDLE_STATE               ;
                                        end 
                                    else
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_9  ;
                                        end
                                    end
         SCHEDULE_INPUT_STREAM_10  :
                                    begin      
                                    if((stream_mapping[0]==1'B1) && (!stream_0_pck_str_empty) && (packets_count_10 == stream_10_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_0 ;
                                        end
                                    else if((stream_mapping[1]==1'B1) && (!stream_1_pck_str_empty) && (packets_count_10 == stream_10_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_1 ;
                                        end
                                    else if((stream_mapping[2]==1'B1) && (!stream_2_pck_str_empty) && (packets_count_10 == stream_10_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_2 ;
                                        end
                                    else if((stream_mapping[3]==1'B1) && (!stream_3_pck_str_empty) && (packets_count_10 == stream_10_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_3 ;
                                        end
                                    else if((stream_mapping[4]==1'B1) && (!stream_4_pck_str_empty) && (packets_count_10 == stream_10_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_4 ;
                                        end
                                    else if((stream_mapping[5]==1'B1) && (!stream_5_pck_str_empty) && (packets_count_10 == stream_10_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_5 ;
                                        end
                                    else if((stream_mapping[6]==1'B1) && (!stream_6_pck_str_empty) && (packets_count_10 == stream_10_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_6 ;
                                        end
                                    else if((stream_mapping[7]==1'B1) && (!stream_7_pck_str_empty) && (packets_count_10 == stream_10_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_7 ;
                                        end
                                    else if((stream_mapping[8]==1'B1) && (!stream_8_pck_str_empty) && (packets_count_10 == stream_10_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_8 ;
                                        end
                                    else if((stream_mapping[9]==1'B1) && (!stream_9_pck_str_empty) && (packets_count_10 == stream_10_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_9 ;
                                        end
                                    else if((stream_mapping[11]==1'B1) && (!stream_11_pck_str_empty) && (packets_count_10 == stream_10_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_11 ;
                                        end
                                    else if((stream_mapping[12]==1'B1) && (!stream_12_pck_str_empty) && (packets_count_10 == stream_10_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_12 ;
                                        end
                                    else if((stream_mapping[13]==1'B1) && (!stream_13_pck_str_empty) && (packets_count_10 == stream_10_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_13 ;
                                        end
                                    else if((stream_mapping[14]==1'B1) && (!stream_14_pck_str_empty) && (packets_count_10 == stream_10_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_14 ;
                                        end
                                    else if((stream_mapping[15]==1'B1) && (!stream_15_pck_str_empty) && (packets_count_10 == stream_10_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_15 ;
                                        end
                                    else if((stream_10_pck_str_empty) && (packets_count_10 == stream_10_packets))    
                                        begin
                                        next_state_stream = IDLE_STATE               ;
                                        end 
                                    else
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_10 ;
                                        end
                                    end
         SCHEDULE_INPUT_STREAM_11  : 
                                    begin      
                                    if((stream_mapping[0]==1'B1) && (!stream_0_pck_str_empty) && (packets_count_11 == stream_11_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_0 ;
                                        end
                                    else if((stream_mapping[1]==1'B1) && (!stream_1_pck_str_empty) && (packets_count_11 == stream_11_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_1 ;
                                        end
                                    else if((stream_mapping[2]==1'B1) && (!stream_2_pck_str_empty) && (packets_count_11 == stream_11_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_2 ;
                                        end
                                    else if((stream_mapping[3]==1'B1) && (!stream_3_pck_str_empty) && (packets_count_11 == stream_11_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_3 ;
                                        end
                                    else if((stream_mapping[4]==1'B1) && (!stream_4_pck_str_empty) && (packets_count_11 == stream_11_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_4 ;
                                        end
                                    else if((stream_mapping[5]==1'B1) && (!stream_5_pck_str_empty) && (packets_count_11 == stream_11_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_5 ;
                                        end
                                    else if((stream_mapping[6]==1'B1) && (!stream_6_pck_str_empty) && (packets_count_11 == stream_11_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_6 ;
                                        end
                                    else if((stream_mapping[7]==1'B1) && (!stream_7_pck_str_empty) && (packets_count_11 == stream_11_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_7 ;
                                        end
                                    else if((stream_mapping[8]==1'B1) && (!stream_8_pck_str_empty) && (packets_count_11 == stream_11_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_8 ;
                                        end
                                    else if((stream_mapping[9]==1'B1) && (!stream_9_pck_str_empty) && (packets_count_11 == stream_11_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_9 ;
                                        end
                                    else if((stream_mapping[10]==1'B1) && (!stream_10_pck_str_empty) && (packets_count_11 == stream_11_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_10 ;
                                        end
                                    else if((stream_mapping[12]==1'B1) && (!stream_12_pck_str_empty) && (packets_count_11 == stream_11_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_12 ;
                                        end
                                    else if((stream_mapping[13]==1'B1) && (!stream_13_pck_str_empty) && (packets_count_11 == stream_11_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_13 ;
                                        end
                                    else if((stream_mapping[14]==1'B1) && (!stream_14_pck_str_empty) && (packets_count_11 == stream_11_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_14 ;
                                        end
                                    else if((stream_mapping[15]==1'B1) && (!stream_15_pck_str_empty) && (packets_count_11 == stream_11_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_15 ;
                                        end
                                    else if((stream_11_pck_str_empty) && (packets_count_11 == stream_11_packets))    
                                        begin
                                        next_state_stream = IDLE_STATE               ;
                                        end 
                                    else
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_11 ;
                                        end
                                    end
         SCHEDULE_INPUT_STREAM_12  : 
                                    begin      
                                    if((stream_mapping[0]==1'B1) && (!stream_0_pck_str_empty) && (packets_count_12 == stream_12_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_0 ;
                                        end
                                    else if((stream_mapping[1]==1'B1) && (!stream_1_pck_str_empty) && (packets_count_12 == stream_12_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_1 ;
                                        end
                                    else if((stream_mapping[2]==1'B1) && (!stream_2_pck_str_empty) && (packets_count_12 == stream_12_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_2 ;
                                        end
                                    else if((stream_mapping[3]==1'B1) && (!stream_3_pck_str_empty) && (packets_count_12 == stream_12_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_3 ;
                                        end
                                    else if((stream_mapping[4]==1'B1) && (!stream_4_pck_str_empty) && (packets_count_12 == stream_12_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_4 ;
                                        end
                                    else if((stream_mapping[5]==1'B1) && (!stream_5_pck_str_empty) && (packets_count_12 == stream_12_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_5 ;
                                        end
                                    else if((stream_mapping[6]==1'B1) && (!stream_6_pck_str_empty) && (packets_count_12 == stream_12_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_6 ;
                                        end
                                    else if((stream_mapping[7]==1'B1) && (!stream_7_pck_str_empty) && (packets_count_12 == stream_12_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_7 ;
                                        end
                                    else if((stream_mapping[8]==1'B1) && (!stream_8_pck_str_empty) && (packets_count_12 == stream_12_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_8 ;
                                        end
                                    else if((stream_mapping[9]==1'B1) && (!stream_9_pck_str_empty) && (packets_count_12 == stream_12_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_9 ;
                                        end
                                    else if((stream_mapping[10]==1'B1) && (!stream_10_pck_str_empty) && (packets_count_12 == stream_12_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_10 ;
                                        end
                                    else if((stream_mapping[11]==1'B1) && (!stream_11_pck_str_empty) && (packets_count_12 == stream_12_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_11 ;
                                        end
                                    else if((stream_mapping[13]==1'B1) && (!stream_13_pck_str_empty) && (packets_count_12 == stream_12_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_13 ;
                                        end
                                    else if((stream_mapping[14]==1'B1) && (!stream_14_pck_str_empty) && (packets_count_12 == stream_12_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_14 ;
                                        end
                                    else if((stream_mapping[15]==1'B1) && (!stream_15_pck_str_empty) && (packets_count_12 == stream_12_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_15 ;
                                        end
                                    else if((stream_12_pck_str_empty) && (packets_count_12 == stream_12_packets))    
                                        begin
                                        next_state_stream = IDLE_STATE               ;
                                        end 
                                    else
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_12 ;
                                        end
                                    end
         SCHEDULE_INPUT_STREAM_13  : 
                                    begin      
                                    if((stream_mapping[0]==1'B1) && (!stream_0_pck_str_empty) && (packets_count_13 == stream_13_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_0 ;
                                        end
                                    else if((stream_mapping[1]==1'B1) && (!stream_1_pck_str_empty) && (packets_count_13 == stream_13_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_1 ;
                                        end
                                    else if((stream_mapping[2]==1'B1) && (!stream_2_pck_str_empty) && (packets_count_13 == stream_13_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_2 ;
                                        end
                                    else if((stream_mapping[3]==1'B1) && (!stream_3_pck_str_empty) && (packets_count_13 == stream_13_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_3 ;
                                        end
                                    else if((stream_mapping[4]==1'B1) && (!stream_4_pck_str_empty) && (packets_count_13 == stream_13_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_4 ;
                                        end
                                    else if((stream_mapping[5]==1'B1) && (!stream_5_pck_str_empty) && (packets_count_13 == stream_13_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_5 ;
                                        end
                                    else if((stream_mapping[6]==1'B1) && (!stream_6_pck_str_empty) && (packets_count_13 == stream_13_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_6 ;
                                        end
                                    else if((stream_mapping[7]==1'B1) && (!stream_7_pck_str_empty) && (packets_count_13 == stream_13_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_7 ;
                                        end
                                    else if((stream_mapping[8]==1'B1) && (!stream_8_pck_str_empty) && (packets_count_13 == stream_13_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_8 ;
                                        end
                                    else if((stream_mapping[9]==1'B1) && (!stream_9_pck_str_empty) && (packets_count_13 == stream_13_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_9 ;
                                        end
                                    else if((stream_mapping[10]==1'B1) && (!stream_10_pck_str_empty) && (packets_count_13 == stream_13_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_10 ;
                                        end
                                    else if((stream_mapping[11]==1'B1) && (!stream_11_pck_str_empty) && (packets_count_13 == stream_13_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_11 ;
                                        end
                                    else if((stream_mapping[12]==1'B1) && (!stream_12_pck_str_empty) && (packets_count_13 == stream_13_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_12 ;
                                        end
                                    else if((stream_mapping[14]==1'B1) && (!stream_14_pck_str_empty) && (packets_count_13 == stream_13_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_14 ;
                                        end
                                    else if((stream_mapping[15]==1'B1) && (!stream_15_pck_str_empty) && (packets_count_13 == stream_13_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_15 ;
                                        end
                                    else if((stream_13_pck_str_empty) && (packets_count_13 == stream_13_packets))    
                                        begin
                                        next_state_stream = IDLE_STATE               ;
                                        end 
                                    else
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_13 ;
                                        end
                                    end
         SCHEDULE_INPUT_STREAM_14  : 
                                    begin     
                                    if((stream_mapping[0]==1'B1) && (!stream_0_pck_str_empty) && (packets_count_14 == stream_14_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_0 ;
                                        end
                                    else if((stream_mapping[1]==1'B1) && (!stream_1_pck_str_empty) && (packets_count_14 == stream_14_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_1 ;
                                        end
                                    else if((stream_mapping[2]==1'B1) && (!stream_2_pck_str_empty) && (packets_count_14 == stream_14_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_2 ;
                                        end
                                    else if((stream_mapping[3]==1'B1) && (!stream_3_pck_str_empty) && (packets_count_14 == stream_14_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_3 ;
                                        end
                                    else if((stream_mapping[4]==1'B1) && (!stream_4_pck_str_empty) && (packets_count_14 == stream_14_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_4 ;
                                        end
                                    else if((stream_mapping[5]==1'B1) && (!stream_5_pck_str_empty) && (packets_count_14 == stream_14_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_5 ;
                                        end
                                    else if((stream_mapping[6]==1'B1) && (!stream_6_pck_str_empty) && (packets_count_14 == stream_14_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_6 ;
                                        end
                                    else if((stream_mapping[7]==1'B1) && (!stream_7_pck_str_empty) && (packets_count_14 == stream_14_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_7 ;
                                        end
                                    else if((stream_mapping[8]==1'B1) && (!stream_8_pck_str_empty) && (packets_count_14 == stream_14_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_8 ;
                                        end
                                    else if((stream_mapping[9]==1'B1) && (!stream_9_pck_str_empty) && (packets_count_14 == stream_14_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_9 ;
                                        end
                                    else if((stream_mapping[10]==1'B1) && (!stream_10_pck_str_empty) && (packets_count_14 == stream_14_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_10 ;
                                        end
                                    else if((stream_mapping[11]==1'B1) && (!stream_11_pck_str_empty) && (packets_count_14 == stream_14_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_11 ;
                                        end
                                    else if((stream_mapping[12]==1'B1) && (!stream_12_pck_str_empty) && (packets_count_14 == stream_14_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_12 ;
                                        end
                                    else if((stream_mapping[13]==1'B1) && (!stream_13_pck_str_empty) && (packets_count_14 == stream_14_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_13 ;
                                        end
                                    else if((stream_mapping[15]==1'B1) && (!stream_15_pck_str_empty) && (packets_count_14 == stream_14_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_15 ;
                                        end
                                    else if((stream_14_pck_str_empty) && (packets_count_14 == stream_14_packets))    
                                        begin
                                        next_state_stream = IDLE_STATE               ;
                                        end 
                                    else
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_14 ;
                                        end
                                    end
         SCHEDULE_INPUT_STREAM_15  : 
                                    begin     
                                    if((stream_mapping[0]==1'B1) && (!stream_0_pck_str_empty) && (packets_count_15 == stream_15_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_0 ;
                                        end
                                    else if((stream_mapping[1]==1'B1) && (!stream_1_pck_str_empty) && (packets_count_15 == stream_15_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_1 ;
                                        end
                                    else if((stream_mapping[2]==1'B1) && (!stream_2_pck_str_empty) && (packets_count_15 == stream_15_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_2 ;
                                        end
                                    else if((stream_mapping[3]==1'B1) && (!stream_3_pck_str_empty) && (packets_count_15 == stream_15_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_3 ;
                                        end
                                    else if((stream_mapping[4]==1'B1) && (!stream_4_pck_str_empty) && (packets_count_15 == stream_15_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_4 ;
                                        end
                                    else if((stream_mapping[5]==1'B1) && (!stream_5_pck_str_empty) && (packets_count_15 == stream_15_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_5 ;
                                        end
                                    else if((stream_mapping[6]==1'B1) && (!stream_6_pck_str_empty) && (packets_count_15 == stream_15_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_6 ;
                                        end
                                    else if((stream_mapping[7]==1'B1) && (!stream_7_pck_str_empty) && (packets_count_15 == stream_15_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_7 ;
                                        end
                                    else if((stream_mapping[8]==1'B1) && (!stream_8_pck_str_empty) && (packets_count_15 == stream_15_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_8 ;
                                        end
                                    else if((stream_mapping[9]==1'B1) && (!stream_9_pck_str_empty) && (packets_count_15 == stream_15_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_9 ;
                                        end
                                    else if((stream_mapping[10]==1'B1) && (!stream_10_pck_str_empty) && (packets_count_15 == stream_15_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_10 ;
                                        end
                                    else if((stream_mapping[11]==1'B1) && (!stream_11_pck_str_empty) && (packets_count_15 == stream_15_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_11 ;
                                        end
                                    else if((stream_mapping[12]==1'B1) && (!stream_12_pck_str_empty) && (packets_count_15 == stream_15_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_12 ;
                                        end
                                    else if((stream_mapping[13]==1'B1) && (!stream_13_pck_str_empty) && (packets_count_15 == stream_15_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_13 ;
                                        end
                                    else if((stream_mapping[14]==1'B1) && (!stream_14_pck_str_empty) && (packets_count_15 == stream_15_packets))
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_14 ;
                                        end
                                    else if((stream_15_pck_str_empty) && (packets_count_15 == stream_15_packets))    
                                        begin
                                        next_state_stream = IDLE_STATE               ;
                                        end 
                                    else
                                        begin
                                        next_state_stream = SCHEDULE_INPUT_STREAM_15 ;
                                        end
                                    end
         endcase
         end
         //////////////////////////////////////////////////////////////////////////////////////////////////////////////////

         //                                 STREAM OUTPUT LOGIC
         always_comb
         begin
         out_stream_busy = 1'b0                  ;
         out_sop         = 1'b0                  ;
         out_stream      = {DATA_WIDTH{1'B0}}    ;
         out_eop         = 1'b0                  ;
         
         unique case(present_state_stream)

         IDLE_STATE                :
                                    begin   
                                    out_stream_busy = 1'b0                  ;
                                    out_sop         = 1'b0                  ;
                                    out_stream      = {DATA_WIDTH{1'B0}}    ;
                                    out_eop         = 1'b0                  ;
                                    end 
         SCHEDULE_INPUT_STREAM_0   :
                                    begin   
                                    out_stream_busy = 1'b1                  ;
                                    out_sop         = in_sop_0              ;
                                    out_stream      = in_stream_0           ;
                                    out_eop         = in_eop_0              ;
                                    end
         SCHEDULE_INPUT_STREAM_1   :
                                    begin
                                    out_stream_busy = 1'b1                  ;
                                    out_sop         = in_sop_1              ;
                                    out_stream      = in_stream_1           ;
                                    out_eop         = in_eop_1              ;
                                    end
         SCHEDULE_INPUT_STREAM_2   :
                                    begin  
                                    out_stream_busy = 1'b1                  ;
                                    out_sop         = in_sop_2              ;
                                    out_stream      = in_stream_2           ;
                                    out_eop         = in_eop_2              ;
                                    end
         SCHEDULE_INPUT_STREAM_3   :
                                    begin   
                                    out_stream_busy = 1'b1                  ;
                                    out_sop         = in_sop_3              ;
                                    out_stream      = in_stream_3           ;
                                    out_eop         = in_eop_3              ;
                                    end
         SCHEDULE_INPUT_STREAM_4   :
                                    begin 
                                    out_stream_busy = 1'b1                  ;
                                    out_sop         = in_sop_4              ;
                                    out_stream      = in_stream_4           ;
                                    out_eop         = in_eop_4              ;
                                    end
         SCHEDULE_INPUT_STREAM_5   :
                                    begin
                                    out_stream_busy = 1'b1                  ;
                                    out_sop         = in_sop_5              ;
                                    out_stream      = in_stream_5           ;
                                    out_eop         = in_eop_5              ;
                                    end
         SCHEDULE_INPUT_STREAM_6   :
                                    begin  
                                    out_stream_busy = 1'b1                  ;
                                    out_sop         = in_sop_6              ;
                                    out_stream      = in_stream_6           ;
                                    out_eop         = in_eop_6              ;
                                    end
         SCHEDULE_INPUT_STREAM_7   :
                                    begin   
                                    out_stream_busy = 1'b1                  ;
                                    out_sop         = in_sop_7              ;
                                    out_stream      = in_stream_7           ;
                                    out_eop         = in_eop_7              ;
                                    end
         SCHEDULE_INPUT_STREAM_8   :
                                    begin    
                                    out_stream_busy = 1'b1                  ;
                                    out_sop         = in_sop_8              ;
                                    out_stream      = in_stream_8           ;
                                    out_eop         = in_eop_8              ;
                                    end
         SCHEDULE_INPUT_STREAM_9   :
                                    begin  
                                    out_stream_busy = 1'b1                  ;
                                    out_sop         = in_sop_9              ;
                                    out_stream      = in_stream_9           ;
                                    out_eop         = in_eop_9              ;
                                    end
         SCHEDULE_INPUT_STREAM_10  :
                                    begin    
                                    out_stream_busy = 1'b1                  ;
                                    out_sop         = in_sop_10             ;
                                    out_stream      = in_stream_10          ;
                                    out_eop         = in_eop_10             ;
                                    end
         SCHEDULE_INPUT_STREAM_11  :
                                    begin 
                                    out_stream_busy = 1'b1                  ;
                                    out_sop         = in_sop_11             ;
                                    out_stream      = in_stream_11          ;
                                    out_eop         = in_eop_11             ;
                                    end
         SCHEDULE_INPUT_STREAM_12  :
                                    begin 
                                    out_stream_busy = 1'b1                  ;
                                    out_sop         = in_sop_12             ;
                                    out_stream      = in_stream_12          ;
                                    out_eop         = in_eop_12             ;
                                    end
         SCHEDULE_INPUT_STREAM_13  :
                                    begin   
                                    out_stream_busy = 1'b1                  ;
                                    out_sop         = in_sop_13             ;
                                    out_stream      = in_stream_13          ;
                                    out_eop         = in_eop_13             ;
                                    end
         SCHEDULE_INPUT_STREAM_14  :
                                    begin    
                                    out_stream_busy = 1'b1                  ;
                                    out_sop         = in_sop_14             ;
                                    out_stream      = in_stream_14          ;
                                    out_eop         = in_eop_14             ;
                                    end
         SCHEDULE_INPUT_STREAM_15  :
                                    begin 
                                    out_stream_busy = 1'b1                  ;
                                    out_sop         = in_sop_15             ;
                                    out_stream      = in_stream_15          ;
                                    out_eop         = in_eop_15             ;
                                    end
         endcase

         end
         ////////////////////////////////////////////////////////////////////////////////////////////////////


         //     COUNTER LOGIC FOR PACKET COUNT OF STREAM 0 
         always_ff@(posedge sch_ctrl_fsm_clk or negedge sch_ctrl_fsm_rstn)
         begin

         if(!sch_ctrl_fsm_rstn)
             begin
             packets_count_0 <= 48'd0                                           ;
             end
         else if(sch_ctrl_fsm_sw_rst)
             begin
             packets_count_0 <= 48'd0                                           ;
             end
         else if(present_state_stream == SCHEDULE_INPUT_STREAM_0)
             begin

                    if((stream_0_packets + 1'b1) == (packets_count_0 + 1'b1))    
                        begin
                        packets_count_0 <= 48'd0                                ;
                        end
                    else if(out_eop)
                        begin
                        packets_count_0 <= packets_count_0 + 1'b1               ;
                        end
                    else
                        begin
                        packets_count_0 <= packets_count_0                      ;
                        end
             end
         else
             begin
             packets_count_0 <= 48'd0                                           ;
             end

         end

         //     COUNTER LOGIC FOR PACKET COUNT OF STREAM 1 
         always_ff@(posedge sch_ctrl_fsm_clk or negedge sch_ctrl_fsm_rstn)
         begin

         if(!sch_ctrl_fsm_rstn)
             begin
             packets_count_1 <= 48'd0                                           ;
             end
         else if(sch_ctrl_fsm_sw_rst)
             begin
             packets_count_1 <= 48'd0                                           ;
             end
         else if(present_state_stream == SCHEDULE_INPUT_STREAM_1)
             begin

                    if((stream_1_packets + 1'b1) == (packets_count_1 + 1'b1))    
                        begin
                        packets_count_1 <= 48'd0                                ;
                        end
                    else if(out_eop)
                        begin
                        packets_count_1 <= packets_count_1 + 1'b1               ;
                        end
                    else
                        begin
                        packets_count_1 <= packets_count_1                      ;
                        end
             end
         else
             begin
             packets_count_1 <= 48'd0                                           ;
             end

         end
         ///////////////////////////////////////////////////////////////////////////////////////////////

         //     COUNTER LOGIC FOR PACKET COUNT OF STREAM 2 
         always_ff@(posedge sch_ctrl_fsm_clk or negedge sch_ctrl_fsm_rstn)
         begin

         if(!sch_ctrl_fsm_rstn)
             begin
             packets_count_2 <= 48'd0                                           ;
             end
         else if(sch_ctrl_fsm_sw_rst)
             begin
             packets_count_2 <= 48'd0                                           ;
             end
         else if(present_state_stream == SCHEDULE_INPUT_STREAM_2)
             begin

                    if((stream_2_packets + 1'b1) == (packets_count_2 + 1'b1))    
                        begin
                        packets_count_2 <= 48'd0                                ;
                        end
                    else if(out_eop)
                        begin
                        packets_count_2 <= packets_count_2 + 1'b1               ;
                        end
                    else
                        begin
                        packets_count_2 <= packets_count_2                      ;
                        end
             end
         else
             begin
             packets_count_2 <= 48'd0                                           ;
             end

         end
         //////////////////////////////////////////////////////////////////////////////////

         //     COUNTER LOGIC FOR PACKET COUNT OF STREAM 3 
         always_ff@(posedge sch_ctrl_fsm_clk or negedge sch_ctrl_fsm_rstn)
         begin

         if(!sch_ctrl_fsm_rstn)
             begin
             packets_count_3 <= 48'd0                                           ;
             end
         else if(sch_ctrl_fsm_sw_rst)
             begin
             packets_count_3 <= 48'd0                                           ;
             end
         else if(present_state_stream == SCHEDULE_INPUT_STREAM_3)
             begin

                    if((stream_3_packets + 1'b1) == (packets_count_3 + 1'b1))    
                        begin
                        packets_count_3 <= 48'd0                                ;
                        end
                    else if(out_eop)
                        begin
                        packets_count_3 <= packets_count_3 + 1'b1               ;
                        end
                    else
                        begin
                        packets_count_3 <= packets_count_3                      ;
                        end
             end
         else
             begin
             packets_count_3 <= 48'd0                                           ;
             end

         end
         //////////////////////////////////////////////////////////////////////////////////

         //     COUNTER LOGIC FOR PACKET COUNT OF STREAM 4 
         always_ff@(posedge sch_ctrl_fsm_clk or negedge sch_ctrl_fsm_rstn)
         begin

         if(!sch_ctrl_fsm_rstn)
             begin
             packets_count_4 <= 48'd0                                           ;
             end
         else if(sch_ctrl_fsm_sw_rst)
             begin
             packets_count_4 <= 48'd0                                           ;
             end
         else if(present_state_stream == SCHEDULE_INPUT_STREAM_4)
             begin

                    if((stream_4_packets + 1'b1) == (packets_count_4 + 1'b1))    
                        begin
                        packets_count_4 <= 48'd0                                ;
                        end
                    else if(out_eop)
                        begin
                        packets_count_4 <= packets_count_4 + 1'b1               ;
                        end
                    else
                        begin
                        packets_count_4 <= packets_count_4                      ;
                        end
             end
         else
             begin
             packets_count_4 <= 48'd0                                           ;
             end

         end
         //////////////////////////////////////////////////////////////////////////////////

         //     COUNTER LOGIC FOR PACKET COUNT OF STREAM 5 
         always_ff@(posedge sch_ctrl_fsm_clk or negedge sch_ctrl_fsm_rstn)
         begin

         if(!sch_ctrl_fsm_rstn)
             begin
             packets_count_5 <= 48'd0                                           ;
             end
         else if(sch_ctrl_fsm_sw_rst)
             begin
             packets_count_5 <= 48'd0                                           ;
             end
         else if(present_state_stream == SCHEDULE_INPUT_STREAM_5)
             begin

                    if((stream_5_packets + 1'b1) == (packets_count_5 + 1'b1))    
                        begin
                        packets_count_5 <= 48'd0                                ;
                        end
                    else if(out_eop)
                        begin
                        packets_count_5 <= packets_count_5 + 1'b1               ;
                        end
                    else
                        begin
                        packets_count_5 <= packets_count_5                      ;
                        end
             end
         else
             begin
             packets_count_5 <= 48'd0                                           ;
             end

         end
         //////////////////////////////////////////////////////////////////////////////////

         //     COUNTER LOGIC FOR PACKET COUNT OF STREAM 6 
         always_ff@(posedge sch_ctrl_fsm_clk or negedge sch_ctrl_fsm_rstn)
         begin

         if(!sch_ctrl_fsm_rstn)
             begin
             packets_count_6 <= 48'd0                                           ;
             end
         else if(sch_ctrl_fsm_sw_rst)
             begin
             packets_count_6 <= 48'd0                                           ;
             end
         else if(present_state_stream == SCHEDULE_INPUT_STREAM_6)
             begin

                    if((stream_6_packets + 1'b1) == (packets_count_6 + 1'b1))    
                        begin
                        packets_count_6 <= 48'd0                                ;
                        end
                    else if(out_eop)
                        begin
                        packets_count_6 <= packets_count_6 + 1'b1               ;
                        end
                    else
                        begin
                        packets_count_6 <= packets_count_6                      ;
                        end
             end
         else
             begin
             packets_count_6 <= 48'd0                                           ;
             end

         end
         //////////////////////////////////////////////////////////////////////////////////

         //     COUNTER LOGIC FOR PACKET COUNT OF STREAM 7 
         always_ff@(posedge sch_ctrl_fsm_clk or negedge sch_ctrl_fsm_rstn)
         begin

         if(!sch_ctrl_fsm_rstn)
             begin
             packets_count_7 <= 48'd0                                           ;
             end
         else if(sch_ctrl_fsm_sw_rst)
             begin
             packets_count_7 <= 48'd0                                           ;
             end
         else if(present_state_stream == SCHEDULE_INPUT_STREAM_7)
             begin

                    if((stream_7_packets + 1'b1) == (packets_count_7 + 1'b1))    
                        begin
                        packets_count_7 <= 48'd0                                ;
                        end
                    else if(out_eop)
                        begin
                        packets_count_7 <= packets_count_7 + 1'b1               ;
                        end
                    else
                        begin
                        packets_count_7 <= packets_count_7                      ;
                        end
             end
         else
             begin
             packets_count_7 <= 48'd0                                           ;
             end

         end
         //////////////////////////////////////////////////////////////////////////////////

         //     COUNTER LOGIC FOR PACKET COUNT OF STREAM 8 
         always_ff@(posedge sch_ctrl_fsm_clk or negedge sch_ctrl_fsm_rstn)
         begin

         if(!sch_ctrl_fsm_rstn)
             begin
             packets_count_8 <= 48'd0                                           ;
             end
         else if(sch_ctrl_fsm_sw_rst)
             begin
             packets_count_8 <= 48'd0                                           ;
             end
         else if(present_state_stream == SCHEDULE_INPUT_STREAM_8)
             begin

                    if((stream_8_packets + 1'b1) == (packets_count_8 + 1'b1))    
                        begin
                        packets_count_8 <= 48'd0                                ;
                        end
                    else if(out_eop)
                        begin
                        packets_count_8 <= packets_count_8 + 1'b1               ;
                        end
                    else
                        begin
                        packets_count_8 <= packets_count_8                      ;
                        end
             end
         else
             begin
             packets_count_8 <= 48'd0                                           ;
             end

         end
         //////////////////////////////////////////////////////////////////////////////////

         //     COUNTER LOGIC FOR PACKET COUNT OF STREAM 9 
         always_ff@(posedge sch_ctrl_fsm_clk or negedge sch_ctrl_fsm_rstn)
         begin

         if(!sch_ctrl_fsm_rstn)
             begin
             packets_count_9 <= 48'd0                                           ;
             end
         else if(sch_ctrl_fsm_sw_rst)
             begin
             packets_count_9 <= 48'd0                                           ;
             end
         else if(present_state_stream == SCHEDULE_INPUT_STREAM_9)
             begin

                    if((stream_9_packets + 1'b1) == (packets_count_9 + 1'b1))    
                        begin
                        packets_count_9 <= 48'd0                                ;
                        end
                    else if(out_eop)
                        begin
                        packets_count_9 <= packets_count_9 + 1'b1               ;
                        end
                    else
                        begin
                        packets_count_9 <= packets_count_9                      ;
                        end
             end
         else
             begin
             packets_count_9 <= 48'd0                                           ;
             end

         end
         //////////////////////////////////////////////////////////////////////////////////

         //     COUNTER LOGIC FOR PACKET COUNT OF STREAM 10 
         always_ff@(posedge sch_ctrl_fsm_clk or negedge sch_ctrl_fsm_rstn)
         begin

         if(!sch_ctrl_fsm_rstn)
             begin
             packets_count_10 <= 48'd0                                           ;
             end
         else if(sch_ctrl_fsm_sw_rst)
             begin
             packets_count_10 <= 48'd0                                           ;
             end
         else if(present_state_stream == SCHEDULE_INPUT_STREAM_10)
             begin

                    if((stream_10_packets + 1'b1) == (packets_count_10 + 1'b1))    
                        begin
                        packets_count_10 <= 48'd0                                ;
                        end
                    else if(out_eop)
                        begin
                        packets_count_10 <= packets_count_10 + 1'b1               ;
                        end
                    else
                        begin
                        packets_count_10 <= packets_count_10                      ;
                        end
             end
         else
             begin
             packets_count_10 <= 48'd0                                           ;
             end

         end
         //////////////////////////////////////////////////////////////////////////////////

         //     COUNTER LOGIC FOR PACKET COUNT OF STREAM 11 
         always_ff@(posedge sch_ctrl_fsm_clk or negedge sch_ctrl_fsm_rstn)
         begin

         if(!sch_ctrl_fsm_rstn)
             begin
             packets_count_11 <= 48'd0                                           ;
             end
         else if(sch_ctrl_fsm_sw_rst)
             begin
             packets_count_11 <= 48'd0                                           ;
             end
         else if(present_state_stream == SCHEDULE_INPUT_STREAM_11)
             begin

                    if((stream_11_packets + 1'b1) == (packets_count_11 + 1'b1))    
                        begin
                        packets_count_11 <= 48'd0                                ;
                        end
                    else if(out_eop)
                        begin
                        packets_count_11 <= packets_count_11 + 1'b1               ;
                        end
                    else
                        begin
                        packets_count_11 <= packets_count_11                      ;
                        end
             end
         else
             begin
             packets_count_11 <= 48'd0                                           ;
             end

         end
         //////////////////////////////////////////////////////////////////////////////////

         //     COUNTER LOGIC FOR PACKET COUNT OF STREAM 12 
         always_ff@(posedge sch_ctrl_fsm_clk or negedge sch_ctrl_fsm_rstn)
         begin

         if(!sch_ctrl_fsm_rstn)
             begin
             packets_count_12 <= 48'd0                                           ;
             end
         else if(sch_ctrl_fsm_sw_rst)
             begin
             packets_count_12 <= 48'd0                                           ;
             end
         else if(present_state_stream == SCHEDULE_INPUT_STREAM_12)
             begin

                    if((stream_12_packets + 1'b1) == (packets_count_12 + 1'b1))    
                        begin
                        packets_count_12 <= 48'd0                                ;
                        end
                    else if(out_eop)
                        begin
                        packets_count_12 <= packets_count_12 + 1'b1               ;
                        end
                    else
                        begin
                        packets_count_12 <= packets_count_12                      ;
                        end
             end
         else
             begin
             packets_count_12 <= 48'd0                                           ;
             end

         end
         //////////////////////////////////////////////////////////////////////////////////

         //     COUNTER LOGIC FOR PACKET COUNT OF STREAM 13 
         always_ff@(posedge sch_ctrl_fsm_clk or negedge sch_ctrl_fsm_rstn)
         begin

         if(!sch_ctrl_fsm_rstn)
             begin
             packets_count_13 <= 48'd0                                           ;
             end
         else if(sch_ctrl_fsm_sw_rst)
             begin
             packets_count_13 <= 48'd0                                           ;
             end
         else if(present_state_stream == SCHEDULE_INPUT_STREAM_13)
             begin

                    if((stream_13_packets + 1'b1) == (packets_count_13 + 1'b1))    
                        begin
                        packets_count_13 <= 48'd0                                ;
                        end
                    else if(out_eop)
                        begin
                        packets_count_13 <= packets_count_13 + 1'b1               ;
                        end
                    else
                        begin
                        packets_count_13 <= packets_count_13                      ;
                        end
             end
         else
             begin
             packets_count_13 <= 48'd0                                           ;
             end

         end
         //////////////////////////////////////////////////////////////////////////////////

         //     COUNTER LOGIC FOR PACKET COUNT OF STREAM 14 
         always_ff@(posedge sch_ctrl_fsm_clk or negedge sch_ctrl_fsm_rstn)
         begin

         if(!sch_ctrl_fsm_rstn)
             begin
             packets_count_14 <= 48'd0                                           ;
             end
         else if(sch_ctrl_fsm_sw_rst)
             begin
             packets_count_14 <= 48'd0                                           ;
             end
         else if(present_state_stream == SCHEDULE_INPUT_STREAM_14)
             begin

                    if((stream_14_packets + 1'b1) == (packets_count_14 + 1'b1))    
                        begin
                        packets_count_14 <= 48'd0                                ;
                        end
                    else if(out_eop)
                        begin
                        packets_count_14 <= packets_count_14 + 1'b1              ;
                        end
                    else
                        begin
                        packets_count_14 <= packets_count_14                     ;
                        end
             end
         else
             begin
             packets_count_14 <= 48'd0                                           ;
             end

         end
         //////////////////////////////////////////////////////////////////////////////////

         //     COUNTER LOGIC FOR PACKET COUNT OF STREAM 15 
         always_ff@(posedge sch_ctrl_fsm_clk or negedge sch_ctrl_fsm_rstn)
         begin

         if(!sch_ctrl_fsm_rstn)
             begin
             packets_count_15 <= 48'd0                                           ;
             end
         else if(sch_ctrl_fsm_sw_rst)
             begin
             packets_count_15 <= 48'd0                                           ;
             end
         else if(present_state_stream == SCHEDULE_INPUT_STREAM_15)
             begin

                    if((stream_15_packets + 1'b1) == (packets_count_15 + 1'b1))    
                        begin
                        packets_count_15 <= 48'd0                                ;
                        end
                    else if(out_eop)
                        begin
                        packets_count_15 <= packets_count_15 + 1'b1              ;
                        end
                    else
                        begin
                        packets_count_15 <= packets_count_15                     ;
                        end
             end
         else
             begin
             packets_count_15 <= 48'd0                                           ;
             end

         end
         //////////////////////////////////////////////////////////////////////////////////

         //     STREAM TOKEN COUNT FOR STREAM 0
         always_ff@(posedge sch_ctrl_fsm_clk or negedge sch_ctrl_fsm_rstn)
         begin

         if(!sch_ctrl_fsm_rstn)
             begin
             tokens_count_0 <= 16'd0                  ; 
             end
         else if(sch_ctrl_fsm_sw_rst)
             begin
             tokens_count_0 <= 16'd0                  ; 
             end
         else if(present_state_stream == SCHEDULE_INPUT_STREAM_0)    
             begin
                    if(stream_0_tokens == (tokens_count_0+1'b1))
                        begin
                        tokens_count_0 <= tokens_count_0           ;
                        end
                    else if(tokens_count_0 <= stream_0_tokens)
                        begin
                        tokens_count_0 <= tokens_count_0 + 1'b1    ; 
                        end
                    else
                        begin
                        tokens_count_0 <= tokens_count_0           ;
                        end
             end           
         else
             begin
             tokens_count_0 <= 16'd0                               ;
             end

         end
         ////////////////////////////////////////////////////////////////////////////////////

         //     STREAM TOKEN COUNT FOR STREAM 1
         always_ff@(posedge sch_ctrl_fsm_clk or negedge sch_ctrl_fsm_rstn)
         begin

         if(!sch_ctrl_fsm_rstn)
             begin
             tokens_count_1 <= 16'd0                  ; 
             end
         else if(sch_ctrl_fsm_sw_rst)
             begin
             tokens_count_1 <= 16'd0                  ; 
             end
         else if(present_state_stream == SCHEDULE_INPUT_STREAM_1)    
             begin
                    if(stream_1_tokens == (tokens_count_1+1'b1))
                        begin
                        tokens_count_1 <= tokens_count_1           ;
                        end
                    else if(tokens_count_1 <= stream_1_tokens)
                        begin
                        tokens_count_1 <= tokens_count_1 + 1'b1    ; 
                        end
                    else
                        begin
                        tokens_count_1 <= tokens_count_1           ;
                        end
             end           
         else
             begin
             tokens_count_1 <= 16'd0                               ;
             end

         end
         ///////////////////////////////////////////////////////////////////////////////////////

         //     STREAM TOKEN COUNT FOR STREAM 2
         always_ff@(posedge sch_ctrl_fsm_clk or negedge sch_ctrl_fsm_rstn)
         begin

         if(!sch_ctrl_fsm_rstn)
             begin
             tokens_count_2 <= 16'd0                  ; 
             end
         else if(sch_ctrl_fsm_sw_rst)
             begin
             tokens_count_2 <= 16'd0                  ; 
             end
         else if(present_state_stream == SCHEDULE_INPUT_STREAM_2)    
             begin
                    if(stream_2_tokens == (tokens_count_2+1'b1))
                        begin
                        tokens_count_2 <= tokens_count_2           ;
                        end
                    else if(tokens_count_2 <= stream_2_tokens)
                        begin
                        tokens_count_2 <= tokens_count_2 + 1'b1    ; 
                        end
                    else
                        begin
                        tokens_count_2 <= tokens_count_2           ;
                        end
             end           
         else
             begin
             tokens_count_2 <= 16'd0                               ;
             end

         end
         //////////////////////////////////////////////////////////////////////////////////

         //     STREAM TOKEN COUNT FOR STREAM 3
         always_ff@(posedge sch_ctrl_fsm_clk or negedge sch_ctrl_fsm_rstn)
         begin

         if(!sch_ctrl_fsm_rstn)
             begin
             tokens_count_3 <= 16'd0                  ; 
             end
         else if(sch_ctrl_fsm_sw_rst)
             begin
             tokens_count_3 <= 16'd0                  ; 
             end
         else if(present_state_stream == SCHEDULE_INPUT_STREAM_3)    
             begin
                    if(stream_3_tokens == (tokens_count_3+1'b1))
                        begin
                        tokens_count_3 <= tokens_count_3           ;
                        end
                    else if(tokens_count_3 <= stream_3_tokens)
                        begin
                        tokens_count_3 <= tokens_count_3 + 1'b1    ; 
                        end
                    else
                        begin
                        tokens_count_3 <= tokens_count_3           ;
                        end
             end           
         else
             begin
             tokens_count_3 <= 16'd0                               ;
             end

         end
         //////////////////////////////////////////////////////////////////////////////////

         //     STREAM TOKEN COUNT FOR STREAM 4
         always_ff@(posedge sch_ctrl_fsm_clk or negedge sch_ctrl_fsm_rstn)
         begin

         if(!sch_ctrl_fsm_rstn)
             begin
             tokens_count_4 <= 16'd0                  ; 
             end
         else if(sch_ctrl_fsm_sw_rst)
             begin
             tokens_count_4 <= 16'd0                  ; 
             end
         else if(present_state_stream == SCHEDULE_INPUT_STREAM_4)    
             begin
                    if(stream_4_tokens == (tokens_count_4+1'b1))
                        begin
                        tokens_count_4 <= tokens_count_4           ;
                        end
                    else if(tokens_count_4 <= stream_4_tokens)
                        begin
                        tokens_count_4 <= tokens_count_4 + 1'b1    ; 
                        end
                    else
                        begin
                        tokens_count_4 <= tokens_count_4           ;
                        end
             end           
         else
             begin
             tokens_count_4 <= 16'd0                               ;
             end

         end
         //////////////////////////////////////////////////////////////////////////////////

         //     STREAM TOKEN COUNT FOR STREAM 5
         always_ff@(posedge sch_ctrl_fsm_clk or negedge sch_ctrl_fsm_rstn)
         begin

         if(!sch_ctrl_fsm_rstn)
             begin
             tokens_count_5 <= 16'd0                  ; 
             end
         else if(sch_ctrl_fsm_sw_rst)
             begin
             tokens_count_5 <= 16'd0                  ; 
             end
         else if(present_state_stream == SCHEDULE_INPUT_STREAM_5)    
             begin
                    if(stream_5_tokens == (tokens_count_5+1'b1))
                        begin
                        tokens_count_5 <= tokens_count_5           ;
                        end
                    else if(tokens_count_5 <= stream_5_tokens)
                        begin
                        tokens_count_5 <= tokens_count_5 + 1'b1    ; 
                        end
                    else
                        begin
                        tokens_count_5 <= tokens_count_5           ;
                        end
             end           
         else
             begin
             tokens_count_5 <= 16'd0                               ;
             end

         end
         //////////////////////////////////////////////////////////////////////////////////

         //     STREAM TOKEN COUNT FOR STREAM 6
         always_ff@(posedge sch_ctrl_fsm_clk or negedge sch_ctrl_fsm_rstn)
         begin

         if(!sch_ctrl_fsm_rstn)
             begin
             tokens_count_6 <= 16'd0                  ; 
             end
         else if(sch_ctrl_fsm_sw_rst)
             begin
             tokens_count_6 <= 16'd0                  ; 
             end
         else if(present_state_stream == SCHEDULE_INPUT_STREAM_6)    
             begin
                    if(stream_6_tokens == (tokens_count_6+1'b1))
                        begin
                        tokens_count_6 <= tokens_count_6           ;
                        end
                    else if(tokens_count_6 <= stream_6_tokens)
                        begin
                        tokens_count_6 <= tokens_count_6 + 1'b1    ; 
                        end
                    else
                        begin
                        tokens_count_6 <= tokens_count_6           ;
                        end
             end           
         else
             begin
             tokens_count_6 <= 16'd0                               ;
             end

         end
         //////////////////////////////////////////////////////////////////////////////////

         //     STREAM TOKEN COUNT FOR STREAM 7
         always_ff@(posedge sch_ctrl_fsm_clk or negedge sch_ctrl_fsm_rstn)
         begin

         if(!sch_ctrl_fsm_rstn)
             begin
             tokens_count_7 <= 16'd0                  ; 
             end
         else if(sch_ctrl_fsm_sw_rst)
             begin
             tokens_count_7 <= 16'd0                  ; 
             end
         else if(present_state_stream == SCHEDULE_INPUT_STREAM_7)    
             begin
                    if(stream_7_tokens == (tokens_count_7+1'b1))
                        begin
                        tokens_count_7 <= tokens_count_7           ;
                        end
                    else if(tokens_count_7 <= stream_7_tokens)
                        begin
                        tokens_count_7 <= tokens_count_7 + 1'b1    ; 
                        end
                    else
                        begin
                        tokens_count_7 <= tokens_count_7           ;
                        end
             end           
         else
             begin
             tokens_count_7 <= 16'd0                               ;
             end

         end
         //////////////////////////////////////////////////////////////////////////////////

         //     STREAM TOKEN COUNT FOR STREAM 8
         always_ff@(posedge sch_ctrl_fsm_clk or negedge sch_ctrl_fsm_rstn)
         begin

         if(!sch_ctrl_fsm_rstn)
             begin
             tokens_count_8 <= 16'd0                  ; 
             end
         else if(sch_ctrl_fsm_sw_rst)
             begin
             tokens_count_8 <= 16'd0                  ; 
             end
         else if(present_state_stream == SCHEDULE_INPUT_STREAM_8)    
             begin
                    if(stream_8_tokens == (tokens_count_8+1'b1))
                        begin
                        tokens_count_8 <= tokens_count_8           ;
                        end
                    else if(tokens_count_8 <= stream_8_tokens)
                        begin
                        tokens_count_8 <= tokens_count_8 + 1'b1    ; 
                        end
                    else
                        begin
                        tokens_count_8 <= tokens_count_8           ;
                        end
             end           
         else
             begin
             tokens_count_8 <= 16'd0                               ;
             end

         end
         //////////////////////////////////////////////////////////////////////////////////

         //     STREAM TOKEN COUNT FOR STREAM 9
         always_ff@(posedge sch_ctrl_fsm_clk or negedge sch_ctrl_fsm_rstn)
         begin

         if(!sch_ctrl_fsm_rstn)
             begin
             tokens_count_9 <= 16'd0                  ; 
             end
         else if(sch_ctrl_fsm_sw_rst)
             begin
             tokens_count_9 <= 16'd0                  ; 
             end
         else if(present_state_stream == SCHEDULE_INPUT_STREAM_9)    
             begin
                    if(stream_9_tokens == (tokens_count_9+1'b1))
                        begin
                        tokens_count_9 <= tokens_count_9           ;
                        end
                    else if(tokens_count_9 <= stream_9_tokens)
                        begin
                        tokens_count_9 <= tokens_count_9 + 1'b1    ; 
                        end
                    else
                        begin
                        tokens_count_9 <= tokens_count_9           ;
                        end
             end           
         else
             begin
             tokens_count_9 <= 16'd0                               ;
             end

         end
         //////////////////////////////////////////////////////////////////////////////////

         //     STREAM TOKEN COUNT FOR STREAM 10
         always_ff@(posedge sch_ctrl_fsm_clk or negedge sch_ctrl_fsm_rstn)
         begin

         if(!sch_ctrl_fsm_rstn)
             begin
             tokens_count_10 <= 16'd0                  ; 
             end
         else if(sch_ctrl_fsm_sw_rst)
             begin
             tokens_count_10 <= 16'd0                  ; 
             end
         else if(present_state_stream == SCHEDULE_INPUT_STREAM_10)    
             begin
                    if(stream_10_tokens == (tokens_count_10+1'b1))
                        begin
                        tokens_count_10 <= tokens_count_10           ;
                        end
                    else if(tokens_count_10 <= stream_10_tokens)
                        begin
                        tokens_count_10 <= tokens_count_10 + 1'b1    ; 
                        end
                    else
                        begin
                        tokens_count_10 <= tokens_count_10           ;
                        end
             end           
         else
             begin
             tokens_count_10 <= 16'd0                                ;
             end

         end
         //////////////////////////////////////////////////////////////////////////////////

         //     STREAM TOKEN COUNT FOR STREAM 11
         always_ff@(posedge sch_ctrl_fsm_clk or negedge sch_ctrl_fsm_rstn)
         begin

         if(!sch_ctrl_fsm_rstn)
             begin
             tokens_count_11 <= 16'd0                  ; 
             end
         else if(sch_ctrl_fsm_sw_rst)
             begin
             tokens_count_11 <= 16'd0                  ; 
             end
         else if(present_state_stream == SCHEDULE_INPUT_STREAM_11)    
             begin
                    if(stream_11_tokens == (tokens_count_11+1'b1))
                        begin
                        tokens_count_11 <= tokens_count_11           ;
                        end
                    else if(tokens_count_11 <= stream_11_tokens)
                        begin
                        tokens_count_11 <= tokens_count_11 + 1'b1    ; 
                        end
                    else
                        begin
                        tokens_count_11 <= tokens_count_11           ;
                        end
             end           
         else
             begin
             tokens_count_11 <= 16'd0                                ;
             end

         end
         //////////////////////////////////////////////////////////////////////////////////

         //     STREAM TOKEN COUNT FOR STREAM 12
         always_ff@(posedge sch_ctrl_fsm_clk or negedge sch_ctrl_fsm_rstn)
         begin

         if(!sch_ctrl_fsm_rstn)
             begin
             tokens_count_12 <= 16'd0                  ; 
             end
         else if(sch_ctrl_fsm_sw_rst)
             begin
             tokens_count_12 <= 16'd0                  ; 
             end
         else if(present_state_stream == SCHEDULE_INPUT_STREAM_12)    
             begin
                    if(stream_12_tokens == (tokens_count_12+1'b1))
                        begin
                        tokens_count_12 <= tokens_count_12           ;
                        end
                    else if(tokens_count_12 <= stream_12_tokens)
                        begin
                        tokens_count_12 <= tokens_count_12 + 1'b1    ; 
                        end
                    else
                        begin
                        tokens_count_12 <= tokens_count_12           ;
                        end
             end           
         else
             begin
             tokens_count_12 <= 16'd0                                ;
             end

         end
         //////////////////////////////////////////////////////////////////////////////////

         //     STREAM TOKEN COUNT FOR STREAM 13
         always_ff@(posedge sch_ctrl_fsm_clk or negedge sch_ctrl_fsm_rstn)
         begin

         if(!sch_ctrl_fsm_rstn)
             begin
             tokens_count_13 <= 16'd0                  ; 
             end
         else if(sch_ctrl_fsm_sw_rst)
             begin
             tokens_count_13 <= 16'd0                  ; 
             end
         else if(present_state_stream == SCHEDULE_INPUT_STREAM_13)    
             begin
                    if(stream_13_tokens == (tokens_count_13+1'b1))
                        begin
                        tokens_count_13 <= tokens_count_13           ;
                        end
                    else if(tokens_count_13 <= stream_13_tokens)
                        begin
                        tokens_count_13 <= tokens_count_13 + 1'b1    ; 
                        end
                    else
                        begin
                        tokens_count_13 <= tokens_count_13           ;
                        end
             end           
         else
             begin
             tokens_count_13 <= 16'd0                                 ;
             end

         end
         //////////////////////////////////////////////////////////////////////////////////

         //     STREAM TOKEN COUNT FOR STREAM 14
         always_ff@(posedge sch_ctrl_fsm_clk or negedge sch_ctrl_fsm_rstn)
         begin

         if(!sch_ctrl_fsm_rstn)
             begin
             tokens_count_14 <= 16'd0                  ; 
             end
         else if(sch_ctrl_fsm_sw_rst)
             begin
             tokens_count_14 <= 16'd0                  ; 
             end
         else if(present_state_stream == SCHEDULE_INPUT_STREAM_14)    
             begin
                    if(stream_14_tokens == (tokens_count_14+1'b1))
                        begin
                        tokens_count_14 <= tokens_count_14           ;
                        end
                    else if(tokens_count_14 <= stream_14_tokens)
                        begin
                        tokens_count_14 <= tokens_count_14 + 1'b1    ; 
                        end
                    else
                        begin
                        tokens_count_14 <= tokens_count_14           ;
                        end
             end           
         else
             begin
             tokens_count_14 <= 16'd0                                ;
             end

         end
         //////////////////////////////////////////////////////////////////////////////////

         //     STREAM TOKEN COUNT FOR STREAM 15
         always_ff@(posedge sch_ctrl_fsm_clk or negedge sch_ctrl_fsm_rstn)
         begin

         if(!sch_ctrl_fsm_rstn)
             begin
             tokens_count_15 <= 16'd0                  ; 
             end
         else if(sch_ctrl_fsm_sw_rst)
             begin
             tokens_count_15 <= 16'd0                  ; 
             end
         else if(present_state_stream == SCHEDULE_INPUT_STREAM_15)    
             begin
                    if(stream_15_tokens == (tokens_count_15+1'b1))
                        begin
                        tokens_count_15 <= tokens_count_15           ;
                        end
                    else if(tokens_count_15 <= stream_15_tokens)
                        begin
                        tokens_count_15 <= tokens_count_15 + 1'b1    ; 
                        end
                    else
                        begin
                        tokens_count_15 <= tokens_count_15           ;
                        end
             end           
         else
             begin
             tokens_count_15 <= 16'd0                                ;
             end

         end
         //////////////////////////////////////////////////////////////////////////////////

         // TOKENS SHOULD NOT BE ZERO AND ENABLING EACH STREAM ONCE TOKENS DRAINED    
         assign nt_valid_stream_0         = ((stream_0_tokens == 16'd0) && (tokens_count_0 == 16'd0))        ? 1'b1 : 1'b0      ;
         assign tokens_count_en_stream_0  = ((stream_0_tokens == (tokens_count_0+1'b1)) && (!nt_valid_stream_0) && (!stream_0_pck_str_empty))    ? 1'b1 : 1'b0      ;

         assign nt_valid_stream_1         = ((stream_1_tokens == 16'd0) && (tokens_count_1 == 16'd0))        ? 1'b1 : 1'b0      ;
         assign tokens_count_en_stream_1  = ((stream_1_tokens == (tokens_count_1+1'b1)) && (!nt_valid_stream_1) && (!stream_1_pck_str_empty))    ? 1'b1 : 1'b0      ;

         assign nt_valid_stream_2         = ((stream_2_tokens == 16'd0) && (tokens_count_2 == 16'd0))        ? 1'b1 : 1'b0      ;
         assign tokens_count_en_stream_2  = ((stream_2_tokens == (tokens_count_2+1'b1)) && (!nt_valid_stream_2) && (!stream_2_pck_str_empty))    ? 1'b1 : 1'b0      ;

         assign nt_valid_stream_3         = ((stream_3_tokens == 16'd0) && (tokens_count_3 == 16'd0))        ? 1'b1 : 1'b0      ;
         assign tokens_count_en_stream_3  = ((stream_3_tokens == (tokens_count_3+1'b1)) && (!nt_valid_stream_3) && (!stream_3_pck_str_empty))    ? 1'b1 : 1'b0      ;

         assign nt_valid_stream_4         = ((stream_4_tokens == 16'd0) && (tokens_count_4 == 16'd0))        ? 1'b1 : 1'b0      ;
         assign tokens_count_en_stream_4  = ((stream_4_tokens == (tokens_count_4+1'b1)) && (!nt_valid_stream_4) && (!stream_4_pck_str_empty))    ? 1'b1 : 1'b0      ;

         assign nt_valid_stream_5         = ((stream_5_tokens == 16'd0) && (tokens_count_5 == 16'd0))        ? 1'b1 : 1'b0      ;
         assign tokens_count_en_stream_5  = ((stream_5_tokens == (tokens_count_5+1'b1)) && (!nt_valid_stream_5) && (!stream_5_pck_str_empty))    ? 1'b1 : 1'b0      ;

         assign nt_valid_stream_6         = ((stream_6_tokens == 16'd0) && (tokens_count_6 == 16'd0))        ? 1'b1 : 1'b0      ;
         assign tokens_count_en_stream_6  = ((stream_6_tokens == (tokens_count_6+1'b1)) && (!nt_valid_stream_6) && (!stream_6_pck_str_empty))    ? 1'b1 : 1'b0      ;

         assign nt_valid_stream_7         = ((stream_7_tokens == 16'd0) && (tokens_count_7 == 16'd0))        ? 1'b1 : 1'b0      ;
         assign tokens_count_en_stream_7  = ((stream_7_tokens == (tokens_count_7+1'b1)) && (!nt_valid_stream_7) && (!stream_7_pck_str_empty))    ? 1'b1 : 1'b0      ;

         assign nt_valid_stream_8         = ((stream_8_tokens == 16'd0) && (tokens_count_8 == 16'd0))        ? 1'b1 : 1'b0      ;
         assign tokens_count_en_stream_8  = ((stream_8_tokens == (tokens_count_8+1'b1)) && (!nt_valid_stream_8) && (!stream_8_pck_str_empty))    ? 1'b1 : 1'b0      ;

         assign nt_valid_stream_9         = ((stream_9_tokens == 16'd0) && (tokens_count_9 == 16'd0))        ? 1'b1 : 1'b0      ;
         assign tokens_count_en_stream_9  = ((stream_9_tokens == (tokens_count_9+1'b1)) && (!nt_valid_stream_9) && (!stream_9_pck_str_empty))    ? 1'b1 : 1'b0      ;

         assign nt_valid_stream_10        = ((stream_10_tokens == 16'd0) && (tokens_count_10 == 16'd0))      ? 1'b1 : 1'b0      ;
         assign tokens_count_en_stream_10 = ((stream_10_tokens == (tokens_count_10+1'b1)) && (!nt_valid_stream_10) && (!stream_10_pck_str_empty)) ? 1'b1 : 1'b0      ;

         assign nt_valid_stream_11        = ((stream_11_tokens == 16'd0) && (tokens_count_11 == 16'd0))      ? 1'b1 : 1'b0      ;
         assign tokens_count_en_stream_11 = ((stream_11_tokens == (tokens_count_11+1'b1)) && (!nt_valid_stream_11) && (!stream_11_pck_str_empty)) ? 1'b1 : 1'b0      ;

         assign nt_valid_stream_12        = ((stream_12_tokens == 16'd0) && (tokens_count_12 == 16'd0))      ? 1'b1 : 1'b0      ;
         assign tokens_count_en_stream_12 = ((stream_12_tokens == (tokens_count_12+1'b1)) && (!nt_valid_stream_12) && (!stream_12_pck_str_empty)) ? 1'b1 : 1'b0      ;

         assign nt_valid_stream_13        = ((stream_13_tokens == 16'd0) && (tokens_count_13 == 16'd0))      ? 1'b1 : 1'b0      ;
         assign tokens_count_en_stream_13 = ((stream_13_tokens == (tokens_count_13+1'b1)) && (!nt_valid_stream_13) && (!stream_13_pck_str_empty)) ? 1'b1 : 1'b0      ;

         assign nt_valid_stream_14        = ((stream_14_tokens == 16'd0) && (tokens_count_14 == 16'd0))      ? 1'b1 : 1'b0      ;
         assign tokens_count_en_stream_14 = ((stream_14_tokens == (tokens_count_14+1'b1)) && (!nt_valid_stream_14) && (!stream_14_pck_str_empty)) ? 1'b1 : 1'b0      ;

         assign nt_valid_stream_15        = ((stream_15_tokens == 16'd0) && (tokens_count_15 == 16'd0))      ? 1'b1 : 1'b0      ;
         assign tokens_count_en_stream_15 = ((stream_15_tokens == (tokens_count_15+1'b1)) && (!nt_valid_stream_15) && (!stream_15_pck_str_empty)) ? 1'b1 : 1'b0      ;
         //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

endmodule         
