module schduler_reg_config 
            #( parameter DATA_WIDTH     = 64    ,
                         REG_ADDR_WIDTH = 5                    
             )
             (
               //   GLOBAL SIGNALS
               input    logic                           schduler_reg_clk        ,
               input    logic                           schduler_reg_rstn       ,
               input    logic                           schduler_reg_sw_rst     ,

               //   INPUTS
               input    logic                           sch_reg_wr_en           ,
               input    logic   [REG_ADDR_WIDTH-1:0]    sch_reg_wr_addr         ,
               input    logic   [DATA_WIDTH-1:0]        sch_reg_wr_data         ,

               //   OUTPUT REGISTERS 
               output   logic   [DATA_WIDTH-1:0]        OUT_STREAM_0_REG       ,   
               output   logic   [DATA_WIDTH-1:0]        OUT_STREAM_1_REG       ,       
               output   logic   [DATA_WIDTH-1:0]        OUT_STREAM_2_REG       ,   
               output   logic   [DATA_WIDTH-1:0]        OUT_STREAM_3_REG       ,

               output   logic   [DATA_WIDTH-1:0]        IN_STREAM_0_REG           ,    
               output   logic   [DATA_WIDTH-1:0]        IN_STREAM_1_REG           ,    
               output   logic   [DATA_WIDTH-1:0]        IN_STREAM_2_REG           ,    
               output   logic   [DATA_WIDTH-1:0]        IN_STREAM_3_REG           ,    
               output   logic   [DATA_WIDTH-1:0]        IN_STREAM_4_REG           ,    
               output   logic   [DATA_WIDTH-1:0]        IN_STREAM_5_REG           ,    
               output   logic   [DATA_WIDTH-1:0]        IN_STREAM_6_REG           ,    
               output   logic   [DATA_WIDTH-1:0]        IN_STREAM_7_REG           ,    
               output   logic   [DATA_WIDTH-1:0]        IN_STREAM_8_REG           ,    
               output   logic   [DATA_WIDTH-1:0]        IN_STREAM_9_REG           ,    
               output   logic   [DATA_WIDTH-1:0]        IN_STREAM_10_REG          ,    
               output   logic   [DATA_WIDTH-1:0]        IN_STREAM_11_REG          ,    
               output   logic   [DATA_WIDTH-1:0]        IN_STREAM_12_REG          ,    
               output   logic   [DATA_WIDTH-1:0]        IN_STREAM_13_REG          ,    
               output   logic   [DATA_WIDTH-1:0]        IN_STREAM_14_REG          ,    
               output   logic   [DATA_WIDTH-1:0]        IN_STREAM_15_REG              

              ); 
                
              //    INTERNAL DECLERATIONS  
              logic                 tokens_stream_0_reg_en_w           ;
              logic                 tokens_stream_1_reg_en_w           ;
              logic                 tokens_stream_2_reg_en_w           ;
              logic                 tokens_stream_3_reg_en_w           ;

              logic                 in_stream_0_reg_en_w               ;      
              logic                 in_stream_1_reg_en_w               ;
              logic                 in_stream_2_reg_en_w               ;
              logic                 in_stream_3_reg_en_w               ;
              logic                 in_stream_4_reg_en_w               ;
              logic                 in_stream_5_reg_en_w               ;
              logic                 in_stream_6_reg_en_w               ;
              logic                 in_stream_7_reg_en_w               ;
              logic                 in_stream_8_reg_en_w               ;
              logic                 in_stream_9_reg_en_w               ;
              logic                 in_stream_10_reg_en_w              ;
              logic                 in_stream_11_reg_en_w              ;
              logic                 in_stream_12_reg_en_w              ;
              logic                 in_stream_13_reg_en_w              ;
              logic                 in_stream_14_reg_en_w              ;
              logic                 in_stream_15_reg_en_w              ;

              //    ADDRESS FOR EACH STREAM REGISTERS  
              localparam  OUT_STREAM_0_REG_ADDR    = 5'd0           ;
              localparam  OUT_STREAM_1_REG_ADDR    = 5'd1           ;
              localparam  OUT_STREAM_2_REG_ADDR    = 5'd2           ;
              localparam  OUT_STREAM_3_REG_ADDR    = 5'd3           ;

              localparam  IN_STREAM_0_REG_ADDR        = 5'd4           ;   
              localparam  IN_STREAM_1_REG_ADDR        = 5'd5           ;               
              localparam  IN_STREAM_2_REG_ADDR        = 5'd6           ;              
              localparam  IN_STREAM_3_REG_ADDR        = 5'd7           ;
              localparam  IN_STREAM_4_REG_ADDR        = 5'd8           ;
              localparam  IN_STREAM_5_REG_ADDR        = 5'd9           ;
              localparam  IN_STREAM_6_REG_ADDR        = 5'd10          ;
              localparam  IN_STREAM_7_REG_ADDR        = 5'd11          ;
              localparam  IN_STREAM_8_REG_ADDR        = 5'd12          ;
              localparam  IN_STREAM_9_REG_ADDR        = 5'd13          ;
              localparam  IN_STREAM_10_REG_ADDR       = 5'd14          ;
              localparam  IN_STREAM_11_REG_ADDR       = 5'd15          ;
              localparam  IN_STREAM_12_REG_ADDR       = 5'd16          ;
              localparam  IN_STREAM_13_REG_ADDR       = 5'd17          ;
              localparam  IN_STREAM_14_REG_ADDR       = 5'd18          ;
              localparam  IN_STREAM_15_REG_ADDR       = 5'd19          ;

              //    ASSIGNING ENABLE SIGNALS IF ADDRESS MATCHES TO THE PARTICULAR STREAM REGISTERS
              assign tokens_stream_0_reg_en_w = (sch_reg_wr_en && (sch_reg_wr_addr == OUT_STREAM_0_REG_ADDR)) ? 1'b1 : 1'b0  ;
              assign tokens_stream_1_reg_en_w = (sch_reg_wr_en && (sch_reg_wr_addr == OUT_STREAM_1_REG_ADDR)) ? 1'b1 : 1'b0  ;
              assign tokens_stream_2_reg_en_w = (sch_reg_wr_en && (sch_reg_wr_addr == OUT_STREAM_2_REG_ADDR)) ? 1'b1 : 1'b0  ;
              assign tokens_stream_3_reg_en_w = (sch_reg_wr_en && (sch_reg_wr_addr == OUT_STREAM_3_REG_ADDR)) ? 1'b1 : 1'b0  ;

              assign in_stream_0_reg_en_w  = (sch_reg_wr_en && (sch_reg_wr_addr == IN_STREAM_0_REG_ADDR  )) ? 1'b1 : 1'b0  ;
              assign in_stream_1_reg_en_w  = (sch_reg_wr_en && (sch_reg_wr_addr == IN_STREAM_1_REG_ADDR  )) ? 1'b1 : 1'b0  ;
              assign in_stream_2_reg_en_w  = (sch_reg_wr_en && (sch_reg_wr_addr == IN_STREAM_2_REG_ADDR  )) ? 1'b1 : 1'b0  ;
              assign in_stream_3_reg_en_w  = (sch_reg_wr_en && (sch_reg_wr_addr == IN_STREAM_3_REG_ADDR  )) ? 1'b1 : 1'b0  ;
              assign in_stream_4_reg_en_w  = (sch_reg_wr_en && (sch_reg_wr_addr == IN_STREAM_4_REG_ADDR  )) ? 1'b1 : 1'b0  ;
              assign in_stream_5_reg_en_w  = (sch_reg_wr_en && (sch_reg_wr_addr == IN_STREAM_5_REG_ADDR  )) ? 1'b1 : 1'b0  ;
              assign in_stream_6_reg_en_w  = (sch_reg_wr_en && (sch_reg_wr_addr == IN_STREAM_6_REG_ADDR  )) ? 1'b1 : 1'b0  ;
              assign in_stream_7_reg_en_w  = (sch_reg_wr_en && (sch_reg_wr_addr == IN_STREAM_7_REG_ADDR  )) ? 1'b1 : 1'b0  ;
              assign in_stream_8_reg_en_w  = (sch_reg_wr_en && (sch_reg_wr_addr == IN_STREAM_8_REG_ADDR  )) ? 1'b1 : 1'b0  ;
              assign in_stream_9_reg_en_w  = (sch_reg_wr_en && (sch_reg_wr_addr == IN_STREAM_9_REG_ADDR  )) ? 1'b1 : 1'b0  ;
              assign in_stream_10_reg_en_w = (sch_reg_wr_en && (sch_reg_wr_addr == IN_STREAM_10_REG_ADDR )) ? 1'b1 : 1'b0  ;
              assign in_stream_11_reg_en_w = (sch_reg_wr_en && (sch_reg_wr_addr == IN_STREAM_11_REG_ADDR )) ? 1'b1 : 1'b0  ;
              assign in_stream_12_reg_en_w = (sch_reg_wr_en && (sch_reg_wr_addr == IN_STREAM_12_REG_ADDR )) ? 1'b1 : 1'b0  ;
              assign in_stream_13_reg_en_w = (sch_reg_wr_en && (sch_reg_wr_addr == IN_STREAM_13_REG_ADDR )) ? 1'b1 : 1'b0  ;
              assign in_stream_14_reg_en_w = (sch_reg_wr_en && (sch_reg_wr_addr == IN_STREAM_14_REG_ADDR )) ? 1'b1 : 1'b0  ;
              assign in_stream_15_reg_en_w = (sch_reg_wr_en && (sch_reg_wr_addr == IN_STREAM_15_REG_ADDR )) ? 1'b1 : 1'b0  ;

              //    ASSIGNING THE WRITE DATA TO THE REGISTERS
              always_ff@(posedge schduler_reg_clk or negedge schduler_reg_rstn)
              begin

              if(!schduler_reg_rstn)
                  begin
                   OUT_STREAM_0_REG    <= {DATA_WIDTH{1'B0}}          ;
                   OUT_STREAM_1_REG    <= {DATA_WIDTH{1'B0}}          ;
                   OUT_STREAM_2_REG    <= {DATA_WIDTH{1'B0}}          ;
                   OUT_STREAM_3_REG    <= {DATA_WIDTH{1'B0}}          ;
                   IN_STREAM_0_REG     <= {DATA_WIDTH{1'B0}}          ;
                   IN_STREAM_1_REG     <= {DATA_WIDTH{1'B0}}          ;
                   IN_STREAM_2_REG     <= {DATA_WIDTH{1'B0}}          ;
                   IN_STREAM_3_REG     <= {DATA_WIDTH{1'B0}}          ;
                   IN_STREAM_4_REG     <= {DATA_WIDTH{1'B0}}          ;
                   IN_STREAM_5_REG     <= {DATA_WIDTH{1'B0}}          ;
                   IN_STREAM_6_REG     <= {DATA_WIDTH{1'B0}}          ;
                   IN_STREAM_7_REG     <= {DATA_WIDTH{1'B0}}          ;
                   IN_STREAM_8_REG     <= {DATA_WIDTH{1'B0}}          ;
                   IN_STREAM_9_REG     <= {DATA_WIDTH{1'B0}}          ;
                   IN_STREAM_10_REG    <= {DATA_WIDTH{1'B0}}          ;
                   IN_STREAM_11_REG    <= {DATA_WIDTH{1'B0}}          ;
                   IN_STREAM_12_REG    <= {DATA_WIDTH{1'B0}}          ;
                   IN_STREAM_13_REG    <= {DATA_WIDTH{1'B0}}          ;
                   IN_STREAM_14_REG    <= {DATA_WIDTH{1'B0}}          ;
                   IN_STREAM_15_REG    <= {DATA_WIDTH{1'B0}}          ;
                  end
              else if(schduler_reg_sw_rst) 
                  begin
                   OUT_STREAM_0_REG    <= {DATA_WIDTH{1'B0}}          ;
                   OUT_STREAM_1_REG    <= {DATA_WIDTH{1'B0}}          ;
                   OUT_STREAM_2_REG    <= {DATA_WIDTH{1'B0}}          ;
                   OUT_STREAM_3_REG    <= {DATA_WIDTH{1'B0}}          ;
                   IN_STREAM_0_REG     <= {DATA_WIDTH{1'B0}}          ;
                   IN_STREAM_1_REG     <= {DATA_WIDTH{1'B0}}          ;
                   IN_STREAM_2_REG     <= {DATA_WIDTH{1'B0}}          ;
                   IN_STREAM_3_REG     <= {DATA_WIDTH{1'B0}}          ;
                   IN_STREAM_4_REG     <= {DATA_WIDTH{1'B0}}          ;
                   IN_STREAM_5_REG     <= {DATA_WIDTH{1'B0}}          ;
                   IN_STREAM_6_REG     <= {DATA_WIDTH{1'B0}}          ;
                   IN_STREAM_7_REG     <= {DATA_WIDTH{1'B0}}          ;
                   IN_STREAM_8_REG     <= {DATA_WIDTH{1'B0}}          ;
                   IN_STREAM_9_REG     <= {DATA_WIDTH{1'B0}}          ;
                   IN_STREAM_10_REG    <= {DATA_WIDTH{1'B0}}          ;
                   IN_STREAM_11_REG    <= {DATA_WIDTH{1'B0}}          ;
                   IN_STREAM_12_REG    <= {DATA_WIDTH{1'B0}}          ;
                   IN_STREAM_13_REG    <= {DATA_WIDTH{1'B0}}          ;
                   IN_STREAM_14_REG    <= {DATA_WIDTH{1'B0}}          ;
                   IN_STREAM_15_REG    <= {DATA_WIDTH{1'B0}}          ;
                  end
              else if(tokens_stream_0_reg_en_w)
                  begin
                  OUT_STREAM_0_REG  <= sch_reg_wr_data            ;
                  end
              else if(tokens_stream_1_reg_en_w)
                  begin
                  OUT_STREAM_1_REG  <= sch_reg_wr_data            ;
                  end
              else if(tokens_stream_2_reg_en_w)
                  begin
                  OUT_STREAM_2_REG  <= sch_reg_wr_data            ;
                  end
              else if(tokens_stream_3_reg_en_w)
                  begin
                  OUT_STREAM_3_REG  <= sch_reg_wr_data            ;
                  end
              else if(in_stream_0_reg_en_w)
                  begin
                  IN_STREAM_0_REG <= sch_reg_wr_data                 ;
                  end
              else if(in_stream_1_reg_en_w)
                  begin
                  IN_STREAM_1_REG <= sch_reg_wr_data                 ;
                  end
              else if(in_stream_2_reg_en_w)
                  begin
                  IN_STREAM_2_REG <= sch_reg_wr_data                 ;
                  end
              else if(in_stream_3_reg_en_w)
                  begin
                  IN_STREAM_3_REG <= sch_reg_wr_data                 ;
                  end
              else if(in_stream_4_reg_en_w)
                  begin
                  IN_STREAM_4_REG <= sch_reg_wr_data                 ;
                  end
              else if(in_stream_5_reg_en_w)
                  begin
                  IN_STREAM_5_REG <= sch_reg_wr_data                 ;
                  end
              else if(in_stream_6_reg_en_w)
                  begin
                  IN_STREAM_6_REG <= sch_reg_wr_data                 ;
                  end
              else if(in_stream_7_reg_en_w)
                  begin
                  IN_STREAM_7_REG <= sch_reg_wr_data                 ;
                  end
              else if(in_stream_8_reg_en_w)
                  begin
                  IN_STREAM_8_REG <= sch_reg_wr_data                 ;
                  end
              else if(in_stream_9_reg_en_w)
                  begin
                  IN_STREAM_9_REG <= sch_reg_wr_data                 ;
                  end
              else if(in_stream_10_reg_en_w)
                  begin
                  IN_STREAM_10_REG <= sch_reg_wr_data                 ;
                  end
              else if(in_stream_11_reg_en_w)
                  begin
                  IN_STREAM_11_REG <= sch_reg_wr_data                 ;
                  end
              else if(in_stream_12_reg_en_w)
                  begin
                  IN_STREAM_12_REG <= sch_reg_wr_data                 ;
                  end
              else if(in_stream_13_reg_en_w)
                  begin
                  IN_STREAM_13_REG <= sch_reg_wr_data                 ;
                  end
              else if(in_stream_14_reg_en_w)
                  begin
                  IN_STREAM_14_REG <= sch_reg_wr_data                 ;
                  end
              else if(in_stream_15_reg_en_w)
                  begin
                  IN_STREAM_15_REG <= sch_reg_wr_data                 ;
                  end
                  
              else
                  begin
                   OUT_STREAM_0_REG    <= OUT_STREAM_0_REG           ;
                   OUT_STREAM_1_REG    <= OUT_STREAM_1_REG           ;
                   OUT_STREAM_2_REG    <= OUT_STREAM_2_REG           ;
                   OUT_STREAM_3_REG    <= OUT_STREAM_3_REG           ;
                   IN_STREAM_0_REG     <= IN_STREAM_0_REG            ;
                   IN_STREAM_1_REG     <= IN_STREAM_1_REG            ;
                   IN_STREAM_2_REG     <= IN_STREAM_2_REG            ;
                   IN_STREAM_3_REG     <= IN_STREAM_3_REG            ;
                   IN_STREAM_4_REG     <= IN_STREAM_4_REG            ;
                   IN_STREAM_5_REG     <= IN_STREAM_5_REG            ;
                   IN_STREAM_6_REG     <= IN_STREAM_6_REG            ;
                   IN_STREAM_7_REG     <= IN_STREAM_7_REG            ;
                   IN_STREAM_8_REG     <= IN_STREAM_8_REG            ;
                   IN_STREAM_9_REG     <= IN_STREAM_9_REG            ;
                   IN_STREAM_10_REG    <= IN_STREAM_10_REG           ;
                   IN_STREAM_11_REG    <= IN_STREAM_11_REG           ;
                   IN_STREAM_12_REG    <= IN_STREAM_12_REG           ;
                   IN_STREAM_13_REG    <= IN_STREAM_13_REG           ;
                   IN_STREAM_14_REG    <= IN_STREAM_14_REG           ;
                   IN_STREAM_15_REG    <= IN_STREAM_15_REG           ;
                  end
                  
              end

endmodule             
