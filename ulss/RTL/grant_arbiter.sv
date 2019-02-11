module grant_arbiter
                (
                 //      NEXT STATE LOGIC FROM EACH OUTPUT STREAMS
                 input    logic     [4:0]               next_state_stream_0      ,
                 input    logic     [4:0]               next_state_stream_1      ,
                 input    logic     [4:0]               next_state_stream_2      ,
                 input    logic     [4:0]               next_state_stream_3      ,

                 //      TOKENS COUNT FROM EACH OUTPUT STREAMS
                 input    logic                         token_count_en_stream_0  ,    
                 input    logic                         token_count_en_stream_1  ,
                 input    logic                         token_count_en_stream_2  ,
                 input    logic                         token_count_en_stream_3  ,
                 input    logic                         token_count_en_stream_4  ,    
                 input    logic                         token_count_en_stream_5  ,
                 input    logic                         token_count_en_stream_6  ,
                 input    logic                         token_count_en_stream_7  ,
                 input    logic                         token_count_en_stream_8  ,    
                 input    logic                         token_count_en_stream_9  ,
                 input    logic                         token_count_en_stream_10 ,
                 input    logic                         token_count_en_stream_11 ,
                 input    logic                         token_count_en_stream_12 ,    
                 input    logic                         token_count_en_stream_13 ,
                 input    logic                         token_count_en_stream_14 ,
                 input    logic                         token_count_en_stream_15 ,

                 input    logic     [15:0]              stream_mapping_stream_0  ,
                 input    logic     [15:0]              stream_mapping_stream_1  ,
                 input    logic     [15:0]              stream_mapping_stream_2  ,
                 input    logic     [15:0]              stream_mapping_stream_3  ,

                 //      READ ENABLE GRANT FOR ALL THE PACKET STORE
                 output   logic                         pck_rd_en_grnt_0         ,
                 output   logic                         pck_rd_en_grnt_1         ,
                 output   logic                         pck_rd_en_grnt_2         ,
                 output   logic                         pck_rd_en_grnt_3         ,
                 output   logic                         pck_rd_en_grnt_4         ,
                 output   logic                         pck_rd_en_grnt_5         ,
                 output   logic                         pck_rd_en_grnt_6         ,
                 output   logic                         pck_rd_en_grnt_7         ,
                 output   logic                         pck_rd_en_grnt_8         ,
                 output   logic                         pck_rd_en_grnt_9         ,
                 output   logic                         pck_rd_en_grnt_10        ,
                 output   logic                         pck_rd_en_grnt_11        ,
                 output   logic                         pck_rd_en_grnt_12        ,
                 output   logic                         pck_rd_en_grnt_13        ,
                 output   logic                         pck_rd_en_grnt_14        ,
                 output   logic                         pck_rd_en_grnt_15         
                );

                //      INTERNAL DECLERATIONS FOR PACKET READ ENABLE
                logic                       pck_rd_en_grnt_0_enable              ;     
                logic                       pck_rd_en_grnt_1_enable              ;
                logic                       pck_rd_en_grnt_2_enable              ;
                logic                       pck_rd_en_grnt_3_enable              ;
                logic                       pck_rd_en_grnt_4_enable              ;
                logic                       pck_rd_en_grnt_5_enable              ;
                logic                       pck_rd_en_grnt_6_enable              ;
                logic                       pck_rd_en_grnt_7_enable              ;
                logic                       pck_rd_en_grnt_8_enable              ;
                logic                       pck_rd_en_grnt_9_enable              ;
                logic                       pck_rd_en_grnt_10_enable             ;
                logic                       pck_rd_en_grnt_11_enable             ;
                logic                       pck_rd_en_grnt_12_enable             ;
                logic                       pck_rd_en_grnt_13_enable             ;
                logic                       pck_rd_en_grnt_14_enable             ;
                logic                       pck_rd_en_grnt_15_enable             ;

                // CHECKING WEATHER A INPUT STREAM IN ENABLED OR NOT 
                assign pck_rd_en_grnt_0_enable = ( 
                                                    (next_state_stream_0 == 5'd1) && (token_count_en_stream_0)    ||
                                                    (next_state_stream_1 == 5'd1) && (token_count_en_stream_0)    ||
                                                    (next_state_stream_2 == 5'd1) && (token_count_en_stream_0)    ||
                                                    (next_state_stream_3 == 5'd1) && (token_count_en_stream_0)
                                                 );
                                                    
                assign pck_rd_en_grnt_1_enable = ( 
                                                    (next_state_stream_0 == 5'd2) && (token_count_en_stream_1)    ||
                                                    (next_state_stream_1 == 5'd2) && (token_count_en_stream_1)    ||
                                                    (next_state_stream_2 == 5'd2) && (token_count_en_stream_1)    ||
                                                    (next_state_stream_3 == 5'd2) && (token_count_en_stream_1)    
                                                 );
                
                assign pck_rd_en_grnt_2_enable = ( 
                                                    (next_state_stream_0 == 5'd3) && (token_count_en_stream_2)    ||
                                                    (next_state_stream_1 == 5'd3) && (token_count_en_stream_2)    ||
                                                    (next_state_stream_2 == 5'd3) && (token_count_en_stream_2)    ||
                                                    (next_state_stream_3 == 5'd3) && (token_count_en_stream_2)    
                                                 );

                assign pck_rd_en_grnt_3_enable = ( 
                                                    (next_state_stream_0 == 5'd4) && (token_count_en_stream_3)    ||
                                                    (next_state_stream_1 == 5'd4) && (token_count_en_stream_3)    ||
                                                    (next_state_stream_2 == 5'd4) && (token_count_en_stream_3)    ||
                                                    (next_state_stream_3 == 5'd4) && (token_count_en_stream_3)    
                                                 );

                assign pck_rd_en_grnt_4_enable = ( 
                                                    (next_state_stream_0 == 5'd5) && (token_count_en_stream_4)    ||
                                                    (next_state_stream_1 == 5'd5) && (token_count_en_stream_4)    ||
                                                    (next_state_stream_2 == 5'd5) && (token_count_en_stream_4)    ||
                                                    (next_state_stream_3 == 5'd5) && (token_count_en_stream_4)    
                                                 );

                assign pck_rd_en_grnt_5_enable = ( 
                                                    (next_state_stream_0 == 5'd6) && (token_count_en_stream_5)    ||
                                                    (next_state_stream_1 == 5'd6) && (token_count_en_stream_5)    ||
                                                    (next_state_stream_2 == 5'd6) && (token_count_en_stream_5)    ||
                                                    (next_state_stream_3 == 5'd6) && (token_count_en_stream_5)    
                                                 );

                assign pck_rd_en_grnt_6_enable = ( 
                                                    (next_state_stream_0 == 5'd7) && (token_count_en_stream_6)    ||
                                                    (next_state_stream_1 == 5'd7) && (token_count_en_stream_6)    ||
                                                    (next_state_stream_2 == 5'd7) && (token_count_en_stream_6)    ||
                                                    (next_state_stream_3 == 5'd7) && (token_count_en_stream_6)    
                                                 );

                assign pck_rd_en_grnt_7_enable = ( 
                                                    (next_state_stream_0 == 5'd8) && (token_count_en_stream_7)    ||
                                                    (next_state_stream_1 == 5'd8) && (token_count_en_stream_7)    ||
                                                    (next_state_stream_2 == 5'd8) && (token_count_en_stream_7)    ||
                                                    (next_state_stream_3 == 5'd8) && (token_count_en_stream_7)    
                                                 );

                assign pck_rd_en_grnt_8_enable = ( 
                                                    (next_state_stream_0 == 5'd9) && (token_count_en_stream_8)    ||
                                                    (next_state_stream_1 == 5'd9) && (token_count_en_stream_8)    ||
                                                    (next_state_stream_2 == 5'd9) && (token_count_en_stream_8)    ||
                                                    (next_state_stream_3 == 5'd9) && (token_count_en_stream_8)
                                                 );

                assign pck_rd_en_grnt_9_enable = ( 
                                                    (next_state_stream_0 == 5'd10) && (token_count_en_stream_9)   ||
                                                    (next_state_stream_1 == 5'd10) && (token_count_en_stream_9)   ||
                                                    (next_state_stream_2 == 5'd10) && (token_count_en_stream_9)   ||
                                                    (next_state_stream_3 == 5'd10) && (token_count_en_stream_9)   
                                                 );

                assign pck_rd_en_grnt_10_enable = ( 
                                                    (next_state_stream_0 == 5'd11) && (token_count_en_stream_10)   ||
                                                    (next_state_stream_1 == 5'd11) && (token_count_en_stream_10)   ||
                                                    (next_state_stream_2 == 5'd11) && (token_count_en_stream_10)   ||
                                                    (next_state_stream_3 == 5'd11) && (token_count_en_stream_10)   
                                                  );

                assign pck_rd_en_grnt_11_enable = ( 
                                                    (next_state_stream_0 == 5'd12) && (token_count_en_stream_11)   ||
                                                    (next_state_stream_1 == 5'd12) && (token_count_en_stream_11)   ||
                                                    (next_state_stream_2 == 5'd12) && (token_count_en_stream_11)   ||
                                                    (next_state_stream_3 == 5'd12) && (token_count_en_stream_11)   
                                                  );

                assign pck_rd_en_grnt_12_enable = ( 
                                                    (next_state_stream_0 == 5'd13) && (token_count_en_stream_12)   ||
                                                    (next_state_stream_1 == 5'd13) && (token_count_en_stream_12)   ||
                                                    (next_state_stream_2 == 5'd13) && (token_count_en_stream_12)   ||
                                                    (next_state_stream_3 == 5'd13) && (token_count_en_stream_12)   
                                                  );

                assign pck_rd_en_grnt_13_enable = ( 
                                                    (next_state_stream_0 == 5'd14) && (token_count_en_stream_13)   ||
                                                    (next_state_stream_1 == 5'd14) && (token_count_en_stream_13)   ||
                                                    (next_state_stream_2 == 5'd14) && (token_count_en_stream_13)   ||
                                                    (next_state_stream_3 == 5'd14) && (token_count_en_stream_13)   
                                                  );

                assign pck_rd_en_grnt_14_enable = ( 
                                                    (next_state_stream_0 == 5'd15) && (token_count_en_stream_14)   ||
                                                    (next_state_stream_1 == 5'd15) && (token_count_en_stream_14)   ||
                                                    (next_state_stream_2 == 5'd15) && (token_count_en_stream_14)   ||
                                                    (next_state_stream_3 == 5'd15) && (token_count_en_stream_14)   
                                                  );

                assign pck_rd_en_grnt_15_enable = ( 
                                                    (next_state_stream_0 == 5'd16) && (token_count_en_stream_15)   ||
                                                    (next_state_stream_1 == 5'd16) && (token_count_en_stream_15)   ||
                                                    (next_state_stream_2 == 5'd16) && (token_count_en_stream_15)   ||
                                                    (next_state_stream_3 == 5'd16) && (token_count_en_stream_15)
                                                  );
                ///////////////////////////////////////////////////////////////////////////////////////////////////////
              
                //      LOGIC FOR GIVING GRANT FOR THE PARTICULAR PACKET STORE
                always_comb
                begin
                pck_rd_en_grnt_0  = (pck_rd_en_grnt_0_enable ) ? 1'b1 : 1'b0        ;
                pck_rd_en_grnt_1  = (pck_rd_en_grnt_1_enable ) ? 1'b1 : 1'b0        ;
                pck_rd_en_grnt_2  = (pck_rd_en_grnt_2_enable ) ? 1'b1 : 1'b0        ;
                pck_rd_en_grnt_3  = (pck_rd_en_grnt_3_enable ) ? 1'b1 : 1'b0        ;
                pck_rd_en_grnt_4  = (pck_rd_en_grnt_4_enable ) ? 1'b1 : 1'b0        ;
                pck_rd_en_grnt_5  = (pck_rd_en_grnt_5_enable ) ? 1'b1 : 1'b0        ;
                pck_rd_en_grnt_6  = (pck_rd_en_grnt_6_enable ) ? 1'b1 : 1'b0        ;
                pck_rd_en_grnt_7  = (pck_rd_en_grnt_7_enable ) ? 1'b1 : 1'b0        ;
                pck_rd_en_grnt_8  = (pck_rd_en_grnt_8_enable ) ? 1'b1 : 1'b0        ;
                pck_rd_en_grnt_9  = (pck_rd_en_grnt_9_enable ) ? 1'b1 : 1'b0        ;
                pck_rd_en_grnt_10 = (pck_rd_en_grnt_10_enable) ? 1'b1 : 1'b0        ;
                pck_rd_en_grnt_11 = (pck_rd_en_grnt_11_enable) ? 1'b1 : 1'b0        ;
                pck_rd_en_grnt_12 = (pck_rd_en_grnt_12_enable) ? 1'b1 : 1'b0        ;
                pck_rd_en_grnt_13 = (pck_rd_en_grnt_13_enable) ? 1'b1 : 1'b0        ;
                pck_rd_en_grnt_14 = (pck_rd_en_grnt_14_enable) ? 1'b1 : 1'b0        ;
                pck_rd_en_grnt_15 = (pck_rd_en_grnt_15_enable) ? 1'b1 : 1'b0        ;
                end

endmodule                

